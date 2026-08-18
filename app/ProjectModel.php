<?php

class ProjectModel
{
    /**
     * Obtener todos los proyectos
     */
    public static function all(string $status = null): array
    {
        $sql = "SELECT * FROM vw_quote_summary";
        $params = [];

        if ($status) {
            $sql .= " WHERE status = ?";
            $params[] = $status;
        }

        $sql .= " ORDER BY created_at DESC";
        
        return Db::fetchAll($sql, $params);
    }

    /**
     * Obtener proyecto por ID
     */
    public static function find(int $id): ?array
    {
        return Db::fetchOne(
            "SELECT * FROM vw_quote_summary WHERE id = ?",
            [$id]
        );
    }

    /**
     * Obtener proyecto por código público
     */
    public static function findByCode(string $code): ?array
    {
        return Db::fetchOne(
            "SELECT * FROM vw_quote_summary WHERE public_code = ?",
            [$code]
        );
    }

    /**
     * Crear nuevo proyecto
     */
    public static function create(array $data): int
    {
        $defaultData = [
            'public_code' => 'COT-' . date('Y') . '-' . strtoupper(bin2hex(random_bytes(3))),
            'name' => $data['name'] ?? 'Proyecto sin nombre',
            'country_id' => $data['country_id'] ?? null,
            'currency_id' => $data['currency_id'] ?? null,
            'methodology' => $data['methodology'] ?? 'cuantitativo',
            'category_id' => $data['category_id'] ?? null,
            'target_type_id' => $data['target_type_id'] ?? null,
            'b2b_profile_id' => $data['b2b_profile_id'] ?? null,
            'target_age_range_id' => $data['target_age_range_id'] ?? null,
            'target_gender_id' => $data['target_gender_id'] ?? null,
            'target_nse_id' => $data['target_nse_id'] ?? null,
            'sample_size' => $data['sample_size'] ?? null,
            'proposed_margin_percent' => $data['margin_percent'] ?? 0,
            'approved_discount_percent' => $data['discount_percent'] ?? 0,
            'total_cost' => $data['total_cost'] ?? 0,
            'total_margin' => $data['total_margin'] ?? 0,
            'final_price' => $data['final_price'] ?? 0,
            'status' => 'draft',
            'created_by' => $data['created_by'] ?? 1,
            'calculation_data' => json_encode($data['calculation_data'] ?? []),
            'created_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s'),
        ];

        return Db::insert('projects', $defaultData);
    }

    /**
     * Actualizar proyecto
     */
    public static function update(int $id, array $data): int
    {
        $data['updated_at'] = date('Y-m-d H:i:s');
        $data['updated_by'] = $data['updated_by'] ?? 1;

        if (isset($data['calculation_data']) && is_array($data['calculation_data'])) {
            $data['calculation_data'] = json_encode($data['calculation_data']);
        }

        return Db::update('projects', $data, ['id' => $id]);
    }

    /**
     * Cambiar estado
     */
    public static function changeStatus(int $id, string $status): int
    {
        return self::update($id, ['status' => $status]);
    }

    /**
     * Finalizar proyecto
     */
    public static function finalize(int $id): int
    {
        return self::update($id, [
            'status' => 'finalized',
            'finalized_at' => date('Y-m-d H:i:s'),
        ]);
    }

    /**
     * Obtener líneas de cotización
     */
    public static function getQuoteLines(int $projectId): array
    {
        return Db::fetchAll(
            "SELECT * FROM vw_quote_lines_detail WHERE project_id = ? ORDER BY sort_order",
            [$projectId]
        );
    }

    /**
     * Obtener estadísticas
     */
    public static function getStats(): array
    {
        return Db::fetchOne(
            "SELECT 
                COUNT(*) AS total,
                SUM(CASE WHEN status = 'draft' THEN 1 ELSE 0 END) AS draft,
                SUM(CASE WHEN status = 'finalized' THEN 1 ELSE 0 END) AS finalized,
                SUM(CASE WHEN status = 'approved' THEN 1 ELSE 0 END) AS approved,
                SUM(final_price) AS total_value
            FROM projects WHERE deleted_at IS NULL"
        );
    }

    /**
     * Obtener proyectos por país
     */
    public static function getByCountry(int $countryId): array
    {
        return Db::fetchAll(
            "SELECT * FROM vw_quote_summary WHERE country_id = ? ORDER BY created_at DESC",
            [$countryId]
        );
    }

    /**
     * Obtener proyectos por categoría
     */
    public static function getByCategory(int $categoryId): array
    {
        return Db::fetchAll(
            "SELECT * FROM vw_quote_summary WHERE category_id = ? ORDER BY created_at DESC",
            [$categoryId]
        );
    }

    /**
     * Eliminar (soft delete)
     */
    public static function delete(int $id): int
    {
        return Db::update('projects', [
            'deleted_at' => date('Y-m-d H:i:s'),
        ], ['id' => $id]);
    }
}
