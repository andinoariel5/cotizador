<?php

class CountryModel
{
    /**
     * Obtener todos los países activos
     */
    public static function all(): array
    {
        return Db::fetchAll(
            "SELECT * FROM countries WHERE is_active = 1 ORDER BY name ASC"
        );
    }

    /**
     * Obtener país por ID
     */
    public static function find(int $id): ?array
    {
        return Db::fetchOne(
            "SELECT * FROM countries WHERE id = ? AND is_active = 1",
            [$id]
        );
    }

    /**
     * Obtener divisas por país
     */
    public static function getCurrencies(int $countryId): array
    {
        return Db::fetchAll(
            "SELECT * FROM currencies WHERE country_id = ? AND is_active = 1 ORDER BY code ASC",
            [$countryId]
        );
    }

    /**
     * Obtener tasa de cambio actual
     */
    public static function getExchangeRate(int $currencyId): ?array
    {
        return Db::fetchOne(
            "SELECT * FROM exchange_rates WHERE currency_id = ? AND is_current = 1",
            [$currencyId]
        );
    }

    /**
     * Obtener costos vigentes
     */
    public static function getCosts(int $countryId): array
    {
        return Db::fetchAll(
            "SELECT * FROM vw_country_costs_active WHERE country_id = ? ORDER BY category, label ASC",
            [$countryId]
        );
    }

    /**
     * Obtener costo específico
     */
    public static function getCost(int $countryId, string $costKey): ?array
    {
        return Db::fetchOne(
            "SELECT * FROM country_costs 
             WHERE country_id = ? AND cost_key = ? AND is_current = 1 
             ORDER BY effective_from DESC LIMIT 1",
            [$countryId, $costKey]
        );
    }

    /**
     * Obtener estadísticas del país
     */
    public static function getStats(int $countryId): ?array
    {
        return Db::fetchOne(
            "SELECT * FROM vw_country_statistics WHERE id = ?",
            [$countryId]
        );
    }

    /**
     * Obtener categorías disponibles
     */
    public static function getCategories(bool $activeOnly = true): array
    {
        $sql = "SELECT * FROM categories";
        $params = [];

        if ($activeOnly) {
            $sql .= " WHERE is_active = 1";
        }

        $sql .= " ORDER BY sector, sort_order ASC";

        return Db::fetchAll($sql, $params);
    }

    /**
     * Obtener target types
     */
    public static function getTargetTypes(): array
    {
        return Db::fetchAll(
            "SELECT id, name FROM target_types ORDER BY id ASC"
        );
    }

    /**
     * Obtener rangos de edad
     */
    public static function getAgeRanges(): array
    {
        return Db::fetchAll(
            "SELECT id, label FROM target_age_ranges ORDER BY id ASC"
        );
    }

    /**
     * Obtener géneros
     */
    public static function getGenders(): array
    {
        return Db::fetchAll(
            "SELECT id, label FROM target_genders ORDER BY id ASC"
        );
    }

    /**
     * Obtener niveles NSE
     */
    public static function getNseLevels(): array
    {
        return Db::fetchAll(
            "SELECT id, label FROM target_nse_levels ORDER BY id ASC"
        );
    }

    /**
     * Obtener perfiles B2B
     */
    public static function getB2BProfiles(): array
    {
        return Db::fetchAll(
            "SELECT id, code, name, difficulty_score FROM b2b_profiles WHERE is_active = 1 ORDER BY id ASC"
        );
    }
}
