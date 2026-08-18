<?php

class QuoteService
{
    /**
     * Obtener dashboard con estadísticas
     */
    public function dashboard(): array
    {
        $stats = ProjectModel::getStats();
        $quotes = ProjectModel::all();
        $countryStats = Db::fetchAll(
            "SELECT * FROM vw_country_statistics ORDER BY total_final_price DESC LIMIT 10"
        );
        $categoryStats = Db::fetchAll(
            "SELECT * FROM vw_categories_active ORDER BY projects_count DESC LIMIT 10"
        );
        $recentAudit = AuditLog::getHistory('quotes', 7);

        return [
            'stats' => $stats,
            'quotes' => array_slice($quotes, 0, 20),
            'countries' => $countryStats,
            'categories' => $categoryStats,
            'recentActivity' => array_slice($recentAudit, 0, 10),
        ];
    }

    /**
     * Obtener datos del formulario
     */
    public function getFormData(): array
    {
        return [
            'countries' => CountryModel::all(),
            'categories' => CountryModel::getCategories(),
            'targetTypes' => CountryModel::getTargetTypes(),
            'ageRanges' => CountryModel::getAgeRanges(),
            'genders' => CountryModel::getGenders(),
            'nseLevels' => CountryModel::getNseLevels(),
            'b2bProfiles' => CountryModel::getB2BProfiles(),
        ];
    }

    /**
     * Obtener divisas por país
     */
    public function getCurrenciesByCountry(int $countryId): array
    {
        return CountryModel::getCurrencies($countryId);
    }

    /**
     * Obtener costos por país
     */
    public function getCostsByCountry(int $countryId): array
    {
        return CountryModel::getCosts($countryId);
    }

    /**
     * Crear nueva cotización
     */
    public function createQuote(array $input): array
    {
        try {
            Db::beginTransaction();

            $countryId = (int)($input['country_id'] ?? 0);
            $marginPercent = (float)($input['margin_percent'] ?? 30);
            $discountPercent = (float)($input['discount_percent'] ?? 20);

            // Obtener divisa por defecto del país
            $currencies = CountryModel::getCurrencies($countryId);
            $currencyId = $currencies[0]['id'] ?? null;

            if ($input['currency_id'] ?? null) {
                $currencyId = (int)$input['currency_id'];
            }

            // Crear proyecto base
            $projectId = ProjectModel::create([
                'name' => $input['name'] ?? 'Proyecto sin nombre',
                'country_id' => $countryId,
                'currency_id' => $currencyId,
                'methodology' => $input['methodology'] ?? 'cuantitativo',
                'category_id' => $input['category_id'] ?? null,
                'target_type_id' => $input['target_type_id'] ?? null,
                'b2b_profile_id' => $input['b2b_profile_id'] ?? null,
                'target_age_range_id' => $input['target_age_range_id'] ?? null,
                'target_gender_id' => $input['target_gender_id'] ?? null,
                'target_nse_id' => $input['target_nse_id'] ?? null,
                'sample_size' => (int)($input['sample_size'] ?? 1),
                'margin_percent' => $marginPercent,
                'discount_percent' => $discountPercent,
                'calculation_data' => $input,
                'created_by' => $input['user_id'] ?? 1,
            ]);

            // Agregar líneas de costo
            if (isset($input['cost_lines']) && is_array($input['cost_lines'])) {
                foreach ($input['cost_lines'] as $index => $line) {
                    CostModel::addLine($projectId, [
                        'cost_section' => $line['section'] ?? 'Campo',
                        'cost_key' => $line['key'] ?? null,
                        'description' => $line['description'] ?? '',
                        'quantity' => $line['quantity'] ?? 0,
                        'unit_cost' => $line['unit_cost'] ?? 0,
                        'sort_order' => $index,
                    ]);
                }
            }

            // Calcular totales
            $this->recalculateProjectTotals($projectId, $marginPercent, $discountPercent);

            // Registrar auditoría
            $project = ProjectModel::find($projectId);
            AuditLog::logCreateQuote($input['user_id'] ?? 1, $projectId, [
                'public_code' => $project['public_code'],
                'name' => $project['name'],
                'total_cost' => $project['total_cost'],
                'final_price' => $project['final_price'],
            ]);

            Db::commit();

            return [
                'success' => true,
                'project_id' => $projectId,
                'project' => ProjectModel::find($projectId),
            ];
        } catch (Exception $e) {
            Db::rollback();
            return [
                'success' => false,
                'error' => $e->getMessage(),
            ];
        }
    }

    /**
     * Actualizar cotización
     */
    public function updateQuote(int $projectId, array $input): array
    {
        try {
            Db::beginTransaction();

            $oldProject = ProjectModel::find($projectId);
            $marginPercent = (float)($input['margin_percent'] ?? $oldProject['proposed_margin_percent']);
            $discountPercent = (float)($input['discount_percent'] ?? $oldProject['approved_discount_percent']);

            // Actualizar proyecto
            ProjectModel::update($projectId, [
                'name' => $input['name'] ?? $oldProject['name'],
                'category_id' => $input['category_id'] ?? $oldProject['category_id'],
                'target_type_id' => $input['target_type_id'] ?? $oldProject['target_type_id'],
                'b2b_profile_id' => $input['b2b_profile_id'] ?? $oldProject['b2b_profile_id'],
                'target_age_range_id' => $input['target_age_range_id'] ?? $oldProject['target_age_range_id'],
                'target_gender_id' => $input['target_gender_id'] ?? $oldProject['target_gender_id'],
                'target_nse_id' => $input['target_nse_id'] ?? $oldProject['target_nse_id'],
                'sample_size' => $input['sample_size'] ?? $oldProject['sample_size'],
                'proposed_margin_percent' => $marginPercent,
                'approved_discount_percent' => $discountPercent,
                'updated_by' => $input['user_id'] ?? 1,
            ]);

            // Recalcular totales
            $this->recalculateProjectTotals($projectId, $marginPercent, $discountPercent);

            // Registrar auditoría
            $newProject = ProjectModel::find($projectId);
            AuditLog::logUpdateQuote($input['user_id'] ?? 1, $projectId, [
                'total_cost' => $oldProject['total_cost'],
                'final_price' => $oldProject['final_price'],
            ], [
                'total_cost' => $newProject['total_cost'],
                'final_price' => $newProject['final_price'],
            ]);

            Db::commit();

            return [
                'success' => true,
                'project' => $newProject,
            ];
        } catch (Exception $e) {
            Db::rollback();
            return [
                'success' => false,
                'error' => $e->getMessage(),
            ];
        }
    }

    /**
     * Recalcular totales del proyecto
     */
    private function recalculateProjectTotals(int $projectId, float $marginPercent, float $discountPercent): void
    {
        $totalCost = CostModel::calculateTotal($projectId);
        $totalMargin = $totalCost * ($marginPercent / 100);
        $finalPrice = ($totalCost + $totalMargin) * (1 - ($discountPercent / 100));

        ProjectModel::update($projectId, [
            'total_cost' => round($totalCost, 2),
            'total_margin' => round($totalMargin, 2),
            'final_price' => round($finalPrice, 2),
            'proposed_margin_percent' => $marginPercent,
            'approved_discount_percent' => $discountPercent,
        ]);
    }

    /**
     * Obtener cotización
     */
    public function getQuote(int $projectId): ?array
    {
        $project = ProjectModel::find($projectId);
        
        if (!$project) {
            return null;
        }

        $lines = CostModel::getLines($projectId);
        $costSummary = CostModel::getSummary($projectId);
        $difficulty = Db::fetchOne(
            "SELECT * FROM vw_project_difficulty WHERE id = ?",
            [$projectId]
        );

        return [
            'project' => $project,
            'lines' => $lines,
            'costSummary' => $costSummary,
            'difficulty' => $difficulty,
        ];
    }

    /**
     * Obtener todas las cotizaciones
     */
    public function getAllQuotes(string $status = null, int $limit = 100): array
    {
        return ProjectModel::all($status);
    }

    /**
     * Finalizar cotización
     */
    public function finalizeQuote(int $projectId, int $userId): array
    {
        try {
            $project = ProjectModel::find($projectId);

            if ($project['status'] !== 'draft') {
                return [
                    'success' => false,
                    'error' => 'Solo se pueden finalizar cotizaciones en estado borrador',
                ];
            }

            ProjectModel::finalize($projectId);

            AuditLog::logFinalizeQuote($userId, $projectId, $project['public_code']);

            return [
                'success' => true,
                'project' => ProjectModel::find($projectId),
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'error' => $e->getMessage(),
            ];
        }
    }

    /**
     * Agregar línea de costo
     */
    public function addCostLine(int $projectId, array $input): array
    {
        try {
            $lineId = CostModel::addLine($projectId, $input);

            $marginPercent = (float)Db::getValue(
                "SELECT proposed_margin_percent FROM projects WHERE id = ?",
                [$projectId]
            );
            $discountPercent = (float)Db::getValue(
                "SELECT approved_discount_percent FROM projects WHERE id = ?",
                [$projectId]
            );

            $this->recalculateProjectTotals($projectId, $marginPercent, $discountPercent);

            return [
                'success' => true,
                'line_id' => $lineId,
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'error' => $e->getMessage(),
            ];
        }
    }

    /**
     * Actualizar línea de costo
     */
    public function updateCostLine(int $lineId, array $input): array
    {
        try {
            CostModel::updateLine($lineId, $input);

            $projectId = Db::getValue(
                "SELECT project_id FROM quote_lines WHERE id = ?",
                [$lineId]
            );

            $marginPercent = (float)Db::getValue(
                "SELECT proposed_margin_percent FROM projects WHERE id = ?",
                [$projectId]
            );
            $discountPercent = (float)Db::getValue(
                "SELECT approved_discount_percent FROM projects WHERE id = ?",
                [$projectId]
            );

            $this->recalculateProjectTotals($projectId, $marginPercent, $discountPercent);

            return [
                'success' => true,
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'error' => $e->getMessage(),
            ];
        }
    }

    /**
     * Eliminar línea de costo
     */
    public function deleteCostLine(int $lineId): array
    {
        try {
            $projectId = Db::getValue(
                "SELECT project_id FROM quote_lines WHERE id = ?",
                [$lineId]
            );

            CostModel::deleteLine($lineId);

            $marginPercent = (float)Db::getValue(
                "SELECT proposed_margin_percent FROM projects WHERE id = ?",
                [$projectId]
            );
            $discountPercent = (float)Db::getValue(
                "SELECT approved_discount_percent FROM projects WHERE id = ?",
                [$projectId]
            );

            $this->recalculateProjectTotals($projectId, $marginPercent, $discountPercent);

            return [
                'success' => true,
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'error' => $e->getMessage(),
            ];
        }
    }

    /**
     * Exportar cotización
     */
    public function exportQuote(int $projectId): array
    {
        $quote = $this->getQuote($projectId);

        if (!$quote) {
            return ['success' => false, 'error' => 'Cotización no encontrada'];
        }

        return [
            'success' => true,
            'data' => $quote,
            'generated_at' => date('Y-m-d H:i:s'),
        ];
    }
}
            'currency_id' => $currencyId ?: null,
            'methodology' => $input['methodology'] ?? 'cuantitativo',
            'category_id' => $categoryId ?: null,
            'target_type_id' => (int)($input['target_type_id'] ?? 0) ?: null,
            'b2b_profile_id' => (int)($input['b2b_profile_id'] ?? 0) ?: null,
            'target_age_range_id' => (int)($input['target_age_range_id'] ?? 0) ?: null,
            'target_gender_id' => (int)($input['target_gender_id'] ?? 0) ?: null,
            'target_nse_id' => (int)($input['target_nse_id'] ?? 0) ?: null,
            'target_penetration' => isset($input['target_penetration']) ? (float)$input['target_penetration'] : 0.0,
            'category_penetration_score' => isset($input['category_penetration_score']) ? (int)$input['category_penetration_score'] : 0,
            'target_duration' => isset($input['target_duration']) ? (float)$input['target_duration'] : 0.0,
            'target_difficulty' => isset($input['target_difficulty']) ? (float)$input['target_difficulty'] : 0.0,
            'target_difficulty_score' => isset($input['target_difficulty_score']) ? (float)$input['target_difficulty_score'] : 0.0,
            'study_difficulty_score' => isset($input['study_difficulty_score']) ? (float)$input['study_difficulty_score'] : 0.0,
            'coverage_population' => isset($input['coverage_population']) ? (int)$input['coverage_population'] : null,
            'coverage_response_effectiveness' => isset($input['coverage_response_effectiveness']) ? (float)$input['coverage_response_effectiveness'] : null,
            'coverage_sample_size_f2f' => isset($input['coverage_sample_size_f2f']) ? (int)$input['coverage_sample_size_f2f'] : null,
            'coverage_daily_productivity' => isset($input['coverage_daily_productivity']) ? (float)$input['coverage_daily_productivity'] : null,
            'coverage_execution_days' => isset($input['coverage_execution_days']) ? (float)$input['coverage_execution_days'] : null,
            'project_cost_field' => (float)$this->sumBySection($lines, 'Campo'),
            'project_cost_telecom' => (float)$this->sumBySection($lines, 'Telecom'),
            'project_cost_materials' => (float)$this->sumBySection($lines, 'Materiales'),
            'project_cost_total' => (float)$totalCost,
            'quote_margin_percent' => $marginPercent,
            'quote_discount_percent' => $discountPercent,
            'quote_final_price' => $finalPrice,
            'sample_size' => $sampleSize,
            'proposed_margin_percent' => $marginPercent,
            'approved_discount_percent' => $discountPercent,
            'total_cost' => $totalCost,
            'total_margin' => $totalMargin,
            'final_price' => $finalPrice,
            'calculation_data' => json_encode([
                'country_id' => $countryId,
                'sample_size' => $sampleSize,
                'margin' => $marginPercent,
                'discount' => $discountPercent,
                'lines' => $lines,
            ], JSON_UNESCAPED_UNICODE),
        ];

        $stmt = $pdo->prepare($projectSql);
        $stmt->execute($projectData);
        $projectId = (int)$pdo->lastInsertId();

        foreach ($lines as $index => $line) {
            $pdo->prepare(
                "INSERT INTO quote_lines (project_id, cost_section, cost_key, description, quantity, unit_cost, total_cost, formula_text, sort_order)
                 VALUES (:project_id, :cost_section, :cost_key, :description, :quantity, :unit_cost, :total_cost, :formula_text, :sort_order)"
            )->execute([
                'project_id' => $projectId,
                'cost_section' => $line['section'],
                'cost_key' => $line['key'],
                'description' => $line['description'],
                'quantity' => $line['quantity'],
                'unit_cost' => $line['unit_cost'],
                'total_cost' => $line['total_cost'],
                'formula_text' => $line['formula_text'],
                'sort_order' => $index,
            ]);
        }

        $pdo->prepare(
            "INSERT INTO project_versions (project_id, version_number, snapshot, change_note, created_by)
             VALUES (:project_id, 1, :snapshot, :change_note, :created_by)"
        )->execute([
            'project_id' => $projectId,
            'snapshot' => json_encode([
                'country_id' => $countryId,
                'currency_id' => $currencyId,
                'category_id' => $categoryId,
                'sample_size' => $sampleSize,
                'margin' => $marginPercent,
                'discount' => $discountPercent,
                'lines' => $lines,
            ], JSON_UNESCAPED_UNICODE),
            'change_note' => 'Cotización creada desde el sistema inicial',
            'created_by' => 1,
        ]);

        $pdo->prepare(
            "INSERT INTO audit_logs (user_id, event_type, module, action, entity_type, entity_id, description, new_values, ip_address, user_agent)
             VALUES (:user_id, 'create', 'quotes', 'create', 'projects', :project_id, :description, :new_values, :ip_address, :user_agent)"
        )->execute([
            'user_id' => 1,
            'project_id' => $projectId,
            'description' => 'Creó cotización ' . $publicCode,
            'new_values' => json_encode(['code' => $publicCode, 'total_cost' => $totalCost, 'final_price' => $finalPrice], JSON_UNESCAPED_UNICODE),
            'ip_address' => $_SERVER['REMOTE_ADDR'] ?? '127.0.0.1',
            'user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? 'System',
        ]);

        return [
            'id' => $projectId,
            'public_code' => $publicCode,
            'name' => $projectName,
            'total_cost' => $totalCost,
            'final_price' => $finalPrice,
        ];
    }

    public function getProject(int $id): ?array
    {
        $pdo = Db::pdo();
        $project = $pdo->prepare("SELECT * FROM projects WHERE id = :id");
        $project->execute(['id' => $id]);
        $row = $project->fetch();

        if (!$row) {
            return null;
        }

        $rows = $pdo->prepare("SELECT * FROM quote_lines WHERE project_id = :id ORDER BY sort_order ASC");
        $rows->execute(['id' => $id]);

        $row['lines'] = $rows->fetchAll();
        return $row;
    }

    protected function buildLines(PDO $pdo, int $countryId, int $sampleSize, array $input): array
    {
        $baseInterviewCost = (float)$this->getCountryCostAmount($pdo, $countryId, 'encuesta_muy_sencilla_8_10_minutos', 20);
        $supervisorCost = (float)$this->getCountryCostAmount($pdo, $countryId, 'pago_dia_supervisores_campo', 510);
        $fieldCost = (float)$this->getCountryCostAmount($pdo, $countryId, 'pago_dia_encuestadores_campo', 425);
        $telecomCost = (float)$this->getCountryCostAmount($pdo, $countryId, 'coste_paquete_diario_llamadas_y_datos', 100);
        $cloudCost = (float)$this->getCountryCostAmount($pdo, $countryId, 'coste_espacio_en_la_nube', 210);
        $incentiveCost = (float)$this->getCountryCostAmount($pdo, $countryId, 'incentivos_perfil_bajo', 20);
        $copyCost = (float)$this->getCountryCostAmount($pdo, $countryId, 'copias_de_papel_blanco_y_negro_1_ud', 20);
        $opsCost = (float)$this->getCountryCostAmount($pdo, $countryId, 'pago_dia_coordinador_operaciones', 500);
        $processedCost = (float)$this->getCountryCostAmount($pdo, $countryId, 'pago_dia_coordinador_procesado', 500);
        $auditCost = (float)$this->getCountryCostAmount($pdo, $countryId, 'pago_dia_coordinador_auditoria', 479.1667);
        $executiveCost = (float)$this->getCountryCostAmount($pdo, $countryId, 'pago_dia_ejecutivo', 625);

        $supervisionDays = max(1, (int)ceil($sampleSize / 20));
        $interviewerDays = max(1, (int)ceil($sampleSize / 30));
        $telecomDays = max(1, (int)($input['telecom_days'] ?? 3));
        $cloudQty = (int)($input['cloud_devices'] ?? 1);
        $materialCopies = max(1, (int)($input['copies_per_participant'] ?? 1));

        $lines = [
            ['section' => 'Campo', 'key' => 'encuesta_muy_sencilla_8_10_minutos', 'description' => 'Aplicación de encuestas según duración', 'quantity' => (float)$sampleSize, 'unit_cost' => $baseInterviewCost, 'total_cost' => (float)($sampleSize * $baseInterviewCost), 'formula_text' => 'Cantidad x tarifa vigente'],
            ['section' => 'Campo', 'key' => 'pago_dia_supervisores_campo', 'description' => 'Supervisión de campo', 'quantity' => (float)$supervisionDays, 'unit_cost' => $supervisorCost, 'total_cost' => (float)($supervisionDays * $supervisorCost), 'formula_text' => 'Cantidad x tarifa vigente'],
            ['section' => 'Campo', 'key' => 'pago_dia_encuestadores_campo', 'description' => 'Coordinación de encuestadores', 'quantity' => (float)$interviewerDays, 'unit_cost' => $fieldCost, 'total_cost' => (float)($interviewerDays * $fieldCost), 'formula_text' => 'Cantidad x tarifa vigente'],
            ['section' => 'Telecom', 'key' => 'coste_paquete_diario_llamadas_y_datos', 'description' => 'Conectividad y paquetes diarios', 'quantity' => (float)$telecomDays, 'unit_cost' => $telecomCost, 'total_cost' => (float)($telecomDays * $telecomCost), 'formula_text' => 'Cantidad x tarifa vigente'],
            ['section' => 'Telecom', 'key' => 'coste_espacio_en_la_nube', 'description' => 'Plataforma y almacenamiento', 'quantity' => (float)$cloudQty, 'unit_cost' => $cloudCost, 'total_cost' => (float)($cloudQty * $cloudCost), 'formula_text' => 'Cantidad x tarifa vigente'],
            ['section' => 'Materiales', 'key' => 'incentivos_perfil_bajo', 'description' => 'Incentivos de participantes', 'quantity' => (float)$sampleSize, 'unit_cost' => $incentiveCost, 'total_cost' => (float)($sampleSize * $incentiveCost), 'formula_text' => 'Cantidad x tarifa vigente'],
            ['section' => 'Materiales', 'key' => 'copias_de_papel_blanco_y_negro_1_ud', 'description' => 'Materiales e impresiones', 'quantity' => (float)($sampleSize * $materialCopies), 'unit_cost' => $copyCost, 'total_cost' => (float)($sampleSize * $materialCopies * $copyCost), 'formula_text' => 'Cantidad x tarifa vigente'],
            ['section' => 'Operaciones', 'key' => 'pago_dia_coordinador_operaciones', 'description' => 'Coordinación operativa', 'quantity' => (float)$supervisionDays, 'unit_cost' => $opsCost, 'total_cost' => (float)($supervisionDays * $opsCost), 'formula_text' => 'Cantidad x tarifa vigente'],
            ['section' => 'Procesado', 'key' => 'pago_dia_coordinador_procesado', 'description' => 'Procesamiento y tabulación', 'quantity' => (float)$supervisionDays, 'unit_cost' => $processedCost, 'total_cost' => (float)($supervisionDays * $processedCost), 'formula_text' => 'Cantidad x tarifa vigente'],
            ['section' => 'Auditoría', 'key' => 'pago_dia_coordinador_auditoria', 'description' => 'Control de calidad y auditoría', 'quantity' => (float)max(1, (int)ceil($sampleSize / 25)), 'unit_cost' => $auditCost, 'total_cost' => (float)(max(1, (int)ceil($sampleSize / 25)) * $auditCost), 'formula_text' => 'Cantidad x tarifa vigente'],
            ['section' => 'Ejecutivo', 'key' => 'pago_dia_ejecutivo', 'description' => 'Gestión ejecutiva y proyecto', 'quantity' => (float)max(1, (int)ceil($sampleSize / 50)), 'unit_cost' => $executiveCost, 'total_cost' => (float)(max(1, (int)ceil($sampleSize / 50)) * $executiveCost), 'formula_text' => 'Cantidad x tarifa vigente'],
        ];

        return $lines;
    }

    protected function getCountryDefaultCurrency(PDO $pdo, int $countryId): ?int
    {
        $stmt = $pdo->prepare("SELECT id FROM currencies WHERE country_id = :country_id AND is_active = 1 ORDER BY id ASC LIMIT 1");
        $stmt->execute(['country_id' => $countryId]);
        $row = $stmt->fetch();

        return $row['id'] ?? null;
    }

    protected function getCountryCostAmount(PDO $pdo, int $countryId, string $costKey, float $fallback): float
    {
        $stmt = $pdo->prepare(
            "SELECT amount FROM country_costs WHERE country_id = :country_id AND cost_key = :cost_key AND is_current = 1 LIMIT 1"
        );
        $stmt->execute(['country_id' => $countryId, 'cost_key' => $costKey]);
        $row = $stmt->fetch();

        if ($row && isset($row['amount'])) {
            return (float)$row['amount'];
        }

        return $fallback;
    }

    protected function sumBySection(array $lines, string $section): float
    {
        $total = 0.0;
        foreach ($lines as $line) {
            if (($line['section'] ?? '') === $section) {
                $total += (float)($line['total_cost'] ?? 0);
            }
        }

        return $total;
    }
}
