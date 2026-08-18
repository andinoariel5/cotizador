-- ========================================
-- VISTAS SQL - SISTEMA DE COTIZACIÓN
-- ========================================

DROP VIEW IF EXISTS vw_project_cost_summary;
DROP VIEW IF EXISTS vw_project_difficulty;
DROP VIEW IF EXISTS vw_country_costs_active;
DROP VIEW IF EXISTS vw_quote_lines_detail;
DROP VIEW IF EXISTS vw_quote_summary;
DROP VIEW IF EXISTS vw_country_statistics;
DROP VIEW IF EXISTS vw_audit_summary;
DROP VIEW IF EXISTS vw_b2b_profiles_active;
DROP VIEW IF EXISTS vw_categories_active;
DROP VIEW IF EXISTS vw_exchange_rates_current;
DROP VIEW IF EXISTS vw_parameters_active;
DROP VIEW IF EXISTS vw_project_versions_detail;

-- Vista resumen de cotizaciones
CREATE VIEW vw_quote_summary AS
SELECT
    p.id,
    p.public_code,
    p.name,
    p.status,
    c.name AS country_name,
    cur.code AS currency_code,
    cat.name AS category_name,
    tt.name AS target_type_name,
    b2b.name AS b2b_profile_name,
    u.name AS created_by_name,
    p.sample_size,
    p.total_cost,
    p.total_margin,
    p.final_price,
    p.proposed_margin_percent,
    p.approved_discount_percent,
    p.methodology,
    p.created_at,
    p.updated_at
FROM projects p
LEFT JOIN countries c ON c.id = p.country_id
LEFT JOIN currencies cur ON cur.id = p.currency_id
LEFT JOIN categories cat ON cat.id = p.category_id
LEFT JOIN target_types tt ON tt.id = p.target_type_id
LEFT JOIN b2b_profiles b2b ON b2b.id = p.b2b_profile_id
LEFT JOIN users u ON u.id = p.created_by
WHERE p.deleted_at IS NULL
ORDER BY p.created_at DESC;

CREATE VIEW vw_quote_lines_detail AS
SELECT
    ql.id,
    ql.project_id,
    p.public_code,
    p.name AS project_name,
    ql.cost_section,
    ql.cost_key,
    ql.description,
    ql.quantity,
    ql.unit_cost,
    ql.total_cost,
    ql.formula_text,
    ql.sort_order,
    ql.created_at,
    cc.label AS cost_label,
    cc.category AS cost_category
FROM quote_lines ql
LEFT JOIN projects p ON p.id = ql.project_id
LEFT JOIN country_costs cc ON cc.cost_key = ql.cost_key AND cc.country_id = p.country_id
WHERE p.deleted_at IS NULL
ORDER BY ql.project_id, ql.sort_order;

CREATE VIEW vw_project_target_context AS
SELECT
    p.id AS project_id,
    p.public_code,
    p.name,
    p.methodology,
    c.name AS country_name,
    tt.name AS target_type,
    age.label AS age_range,
    gender.label AS gender_label,
    nse.label AS nse_level,
    b2b.name AS b2b_profile,
    p.target_penetration,
    p.target_duration,
    p.target_difficulty,
    p.sample_size,
    p.total_cost,
    p.final_price
FROM projects p
LEFT JOIN countries c ON c.id = p.country_id
LEFT JOIN target_types tt ON tt.id = p.target_type_id
LEFT JOIN target_age_ranges age ON age.id = p.target_age_range_id
LEFT JOIN target_genders gender ON gender.id = p.target_gender_id
LEFT JOIN target_nse_levels nse ON nse.id = p.target_nse_id
LEFT JOIN b2b_profiles b2b ON b2b.id = p.b2b_profile_id;

CREATE VIEW vw_country_cost_catalog AS
SELECT
    cc.id,
    c.name AS country_name,
    cur.code AS currency_code,
    cc.cost_key,
    cc.label,
    cc.amount,
    cc.category,
    cc.effective_from,
    cc.effective_to,
    cc.is_current,
    cc.updated_by,
    cc.created_at,
    cc.updated_at
FROM country_costs cc
LEFT JOIN countries c ON c.id = cc.country_id
LEFT JOIN currencies cur ON cur.id = cc.currency_id
WHERE cc.is_current = 1
ORDER BY c.name, cc.label;

CREATE VIEW vw_audit_summary AS
SELECT
    al.id,
    al.user_id,
    u.name AS user_name,
    al.event_type,
    al.module,
    al.action,
    al.entity_type,
    al.entity_id,
    al.description,
    al.created_at,
    DATE(al.created_at) AS event_date,
    MONTH(al.created_at) AS event_month,
    YEAR(al.created_at) AS event_year
FROM audit_logs al
LEFT JOIN users u ON u.id = al.user_id
ORDER BY al.created_at DESC;

CREATE VIEW vw_active_parameters AS
SELECT
    id,
    parameter_key,
    label,
    value_decimal,
    value_text,
    unit,
    description,
    is_active,
    updated_by,
    created_at,
    updated_at
FROM parameters
WHERE is_active = 1;

CREATE VIEW vw_project_versions_latest AS
SELECT
    pv.id,
    pv.project_id,
    p.public_code,
    p.name AS project_name,
    pv.version_number,
    pv.snapshot,
    pv.change_note,
    pv.created_by,
    u.name AS created_by_name,
    pv.created_at
FROM project_versions pv
LEFT JOIN projects p ON p.id = pv.project_id
LEFT JOIN users u ON u.id = pv.created_by
WHERE pv.created_at = (
    SELECT MAX(pv2.created_at)
    FROM project_versions pv2
    WHERE pv2.project_id = pv.project_id
);

-- Vista de estadísticas por país
CREATE VIEW vw_country_statistics AS
SELECT 
    c.id,
    c.code,
    c.name,
    c.population,
    COUNT(p.id) AS total_projects,
    SUM(CASE WHEN p.status = 'draft' THEN 1 ELSE 0 END) AS draft_projects,
    SUM(CASE WHEN p.status = 'finalized' THEN 1 ELSE 0 END) AS finalized_projects,
    SUM(CASE WHEN p.status = 'approved' THEN 1 ELSE 0 END) AS approved_projects,
    SUM(p.total_cost) AS total_costs,
    SUM(p.total_margin) AS total_margins,
    SUM(p.final_price) AS total_final_price,
    COUNT(DISTINCT cu.id) AS currency_count,
    MAX(p.updated_at) AS last_update
FROM countries c
LEFT JOIN projects p ON c.id = p.country_id AND p.deleted_at IS NULL
LEFT JOIN currencies cu ON c.id = cu.country_id AND cu.is_active = 1
WHERE c.is_active = 1
GROUP BY c.id, c.code, c.name, c.population;

-- Vista de perfiles B2B activos
CREATE VIEW vw_b2b_profiles_active AS
SELECT 
    bp.id,
    bp.code,
    bp.name,
    bp.difficulty_score,
    COUNT(p.id) AS projects_count,
    SUM(p.final_price) AS total_price,
    bp.created_at
FROM b2b_profiles bp
LEFT JOIN projects p ON bp.id = p.b2b_profile_id AND p.deleted_at IS NULL
WHERE bp.is_active = 1
GROUP BY bp.id, bp.code, bp.name, bp.difficulty_score, bp.created_at;

-- Vista de categorías activas
CREATE VIEW vw_categories_active AS
SELECT 
    c.id,
    c.sector,
    c.name,
    c.market_penetration,
    c.penetration_score,
    c.difficulty_score,
    COUNT(p.id) AS projects_count,
    SUM(p.final_price) AS total_price,
    c.sort_order,
    c.created_at
FROM categories c
LEFT JOIN projects p ON c.id = p.category_id AND p.deleted_at IS NULL
WHERE c.is_active = 1
GROUP BY c.id, c.sector, c.name, c.market_penetration, c.penetration_score, 
         c.difficulty_score, c.sort_order, c.created_at
ORDER BY c.sector, c.sort_order;

-- Vista de intercambio de divisas vigentes
CREATE VIEW vw_exchange_rates_current AS
SELECT 
    er.id,
    er.currency_id,
    cu.code AS currency_code,
    cu.symbol,
    c.name AS country_name,
    er.rate_to_usd,
    er.effective_date,
    er.is_current,
    er.created_at
FROM exchange_rates er
JOIN currencies cu ON er.currency_id = cu.id
JOIN countries c ON cu.country_id = c.id
WHERE er.is_current = 1
ORDER BY c.name, cu.code;

-- Vista de cálculo de dificultad
CREATE VIEW vw_project_difficulty AS
SELECT 
    p.id,
    p.public_code,
    p.name,
    p.methodology,
    cat.difficulty_score AS category_difficulty,
    tt.name AS target_type,
    b2b.difficulty_score AS b2b_difficulty,
    COALESCE(p.target_difficulty_score, 1.0) AS target_difficulty_score,
    COALESCE(p.study_difficulty_score, 1.0) AS study_difficulty_score,
    (COALESCE(cat.difficulty_score, 1.0) * 
     COALESCE(b2b.difficulty_score, 1.0) * 
     COALESCE(p.target_difficulty_score, 1.0)) AS total_difficulty_factor,
    p.total_cost,
    p.total_margin,
    p.final_price,
    p.status,
    p.created_at
FROM projects p
LEFT JOIN categories cat ON p.category_id = cat.id
LEFT JOIN target_types tt ON p.target_type_id = tt.id
LEFT JOIN b2b_profiles b2b ON p.b2b_profile_id = b2b.id
WHERE p.deleted_at IS NULL;
