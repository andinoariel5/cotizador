<?php

class CostModel
{
    /**
     * Agregar línea de costo
     */
    public static function addLine(int $projectId, array $data): int
    {
        $lineData = [
            'project_id' => $projectId,
            'cost_section' => $data['cost_section'] ?? 'Campo',
            'cost_key' => $data['cost_key'] ?? null,
            'description' => $data['description'] ?? '',
            'quantity' => $data['quantity'] ?? 0,
            'unit_cost' => $data['unit_cost'] ?? 0,
            'total_cost' => ($data['quantity'] ?? 0) * ($data['unit_cost'] ?? 0),
            'formula_text' => $data['formula_text'] ?? null,
            'sort_order' => $data['sort_order'] ?? 0,
            'created_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s'),
        ];

        return Db::insert('quote_lines', $lineData);
    }

    /**
     * Actualizar línea de costo
     */
    public static function updateLine(int $lineId, array $data): int
    {
        $data['updated_at'] = date('Y-m-d H:i:s');
        
        if (isset($data['quantity']) && isset($data['unit_cost'])) {
            $data['total_cost'] = $data['quantity'] * $data['unit_cost'];
        }

        return Db::update('quote_lines', $data, ['id' => $lineId]);
    }

    /**
     * Eliminar línea de costo
     */
    public static function deleteLine(int $lineId): int
    {
        return Db::delete('quote_lines', ['id' => $lineId]);
    }

    /**
     * Obtener líneas por proyecto
     */
    public static function getLines(int $projectId): array
    {
        return Db::fetchAll(
            "SELECT * FROM vw_quote_lines_detail WHERE project_id = ? ORDER BY sort_order ASC",
            [$projectId]
        );
    }

    /**
     * Obtener resumen de costos
     */
    public static function getSummary(int $projectId): ?array
    {
        return Db::fetchOne(
            "SELECT 
                SUM(CASE WHEN cost_section = 'Campo' THEN total_cost ELSE 0 END) AS field_cost,
                SUM(CASE WHEN cost_section = 'Telecom' THEN total_cost ELSE 0 END) AS telecom_cost,
                SUM(CASE WHEN cost_section = 'Materiales' THEN total_cost ELSE 0 END) AS materials_cost,
                SUM(CASE WHEN cost_section = 'Operaciones' THEN total_cost ELSE 0 END) AS operations_cost,
                SUM(CASE WHEN cost_section = 'Procesado' THEN total_cost ELSE 0 END) AS processing_cost,
                SUM(CASE WHEN cost_section = 'Auditoría' THEN total_cost ELSE 0 END) AS audit_cost,
                SUM(CASE WHEN cost_section = 'Ejecutivo' THEN total_cost ELSE 0 END) AS executive_cost,
                SUM(total_cost) AS total_cost
            FROM quote_lines WHERE project_id = ?",
            [$projectId]
        );
    }

    /**
     * Obtener costos por sección
     */
    public static function getBySection(int $projectId, string $section): array
    {
        return Db::fetchAll(
            "SELECT * FROM vw_quote_lines_detail WHERE project_id = ? AND cost_section = ? ORDER BY sort_order ASC",
            [$projectId, $section]
        );
    }

    /**
     * Calcular total de costos
     */
    public static function calculateTotal(int $projectId): float
    {
        return (float)Db::getValue(
            "SELECT COALESCE(SUM(total_cost), 0) FROM quote_lines WHERE project_id = ?",
            [$projectId]
        );
    }

    /**
     * Crear líneas automáticamente basadas en el alcance
     */
    public static function createLinesFromCatalog(int $projectId, array $scope): array
    {
        $pdo = Db::pdo();
        $project = ProjectModel::find($projectId);
        
        if (!$project) {
            return [];
        }

        $lineIds = [];
        $sampleSize = $project['sample_size'] ?? 1;
        $countryId = $project['country_id'];

        // Obtener costos del catálogo
        $costs = Db::fetchAll(
            "SELECT * FROM country_costs WHERE country_id = ? AND is_current = 1",
            [$countryId]
        );

        $costMap = [];
        foreach ($costs as $cost) {
            $costMap[$cost['cost_key']] = $cost;
        }

        // Crear líneas para cada sección
        $sections = [
            'Campo' => ['encuesta_muy_sencilla_8_10_minutos', 'pago_dia_supervisores_campo'],
            'Telecom' => ['coste_paquete_diario_llamadas_y_datos', 'coste_espacio_en_la_nube'],
            'Materiales' => ['incentivos_perfil_bajo', 'copias_de_papel_blanco_y_negro_1_ud'],
        ];

        $sortOrder = 0;
        foreach ($sections as $section => $costKeys) {
            foreach ($costKeys as $costKey) {
                if (isset($costMap[$costKey])) {
                    $cost = $costMap[$costKey];
                    $quantity = $scope[$costKey] ?? 1;
                    
                    $lineId = self::addLine($projectId, [
                        'cost_section' => $section,
                        'cost_key' => $costKey,
                        'description' => $cost['label'],
                        'quantity' => $quantity,
                        'unit_cost' => $cost['amount'],
                        'sort_order' => $sortOrder++,
                    ]);
                    
                    $lineIds[] = $lineId;
                }
            }
        }

        return $lineIds;
    }

    /**
     * Obtener todas las secciones disponibles
     */
    public static function getSections(): array
    {
        return ['Campo', 'Telecom', 'Materiales', 'Operaciones', 'Procesado', 'Auditoría', 'Ejecutivo'];
    }
}
