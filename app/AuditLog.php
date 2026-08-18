<?php

class AuditLog
{
    /**
     * Registrar evento de auditoría
     */
    public static function log(
        int $userId,
        string $eventType,
        string $module,
        string $action,
        ?string $entityType = null,
        ?int $entityId = null,
        ?string $description = null,
        ?array $oldValues = null,
        ?array $newValues = null
    ): int {
        $data = [
            'user_id' => $userId,
            'event_type' => $eventType,
            'module' => $module,
            'action' => $action,
            'entity_type' => $entityType,
            'entity_id' => $entityId,
            'description' => $description,
            'old_values' => $oldValues ? json_encode($oldValues) : null,
            'new_values' => $newValues ? json_encode($newValues) : null,
            'ip_address' => $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0',
            'user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? '',
            'created_at' => date('Y-m-d H:i:s'),
        ];

        return Db::insert('audit_logs', $data);
    }

    /**
     * Registrar creación de cotización
     */
    public static function logCreateQuote(int $userId, int $projectId, array $values): int
    {
        return self::log(
            $userId,
            'create',
            'quotes',
            'create',
            'projects',
            $projectId,
            'Creó cotización ' . ($values['public_code'] ?? ''),
            null,
            ['name' => $values['name'], 'total_cost' => $values['total_cost'], 'final_price' => $values['final_price']]
        );
    }

    /**
     * Registrar actualización de cotización
     */
    public static function logUpdateQuote(int $userId, int $projectId, array $oldValues, array $newValues): int
    {
        return self::log(
            $userId,
            'update',
            'quotes',
            'update',
            'projects',
            $projectId,
            'Actualizó cotización ' . ($oldValues['name'] ?? ''),
            $oldValues,
            $newValues
        );
    }

    /**
     * Registrar finalización de cotización
     */
    public static function logFinalizeQuote(int $userId, int $projectId, string $code): int
    {
        return self::log(
            $userId,
            'finalize',
            'quotes',
            'finalize',
            'projects',
            $projectId,
            'Finalizó cotización ' . $code
        );
    }

    /**
     * Obtener historial de auditoría
     */
    public static function getHistory(string $module = null, ?int $days = 30): array
    {
        $sql = "SELECT * FROM vw_audit_summary WHERE 1=1";
        $params = [];

        if ($module) {
            $sql .= " AND module = ?";
            $params[] = $module;
        }

        if ($days) {
            $sql .= " AND created_at >= DATE_SUB(NOW(), INTERVAL ? DAY)";
            $params[] = $days;
        }

        $sql .= " ORDER BY created_at DESC";

        return Db::fetchAll($sql, $params);
    }

    /**
     * Obtener actividad por usuario
     */
    public static function getUserActivity(int $userId, ?int $days = 30): array
    {
        $sql = "SELECT * FROM vw_audit_summary WHERE user_id = ?";
        $params = [$userId];

        if ($days) {
            $sql .= " AND created_at >= DATE_SUB(NOW(), INTERVAL ? DAY)";
            $params[] = $days;
        }

        $sql .= " ORDER BY created_at DESC";

        return Db::fetchAll($sql, $params);
    }

    /**
     * Obtener estadísticas de auditoría
     */
    public static function getStats(): ?array
    {
        return Db::fetchOne(
            "SELECT 
                COUNT(*) AS total_events,
                COUNT(DISTINCT user_id) AS total_users,
                COUNT(DISTINCT module) AS total_modules,
                MAX(created_at) AS last_event
            FROM audit_logs"
        );
    }
}
