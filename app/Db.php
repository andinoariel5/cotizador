<?php

class Db
{
    private static ?PDO $instance = null;

    public static function pdo(): PDO
    {
        if (self::$instance !== null) {
            return self::$instance;
        }

        $host = env('DB_HOST', '127.0.0.1');
        $dbname = env('DB_NAME', 'cotizadordb');
        $user = env('DB_USERNAME', 'root');
        $password = env('DB_PASSWORD', '');
        $charset = env('DB_CHARSET', 'utf8mb4');

        $dsn = sprintf('mysql:host=%s;dbname=%s;charset=%s', $host, $dbname, $charset);

        self::$instance = new PDO($dsn, $user, $password, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]);

        // Ejecutar vistas SQL si es necesario
        self::ensureViews();

        return self::$instance;
    }

    /**
     * Crear o actualizar vistas SQL
     */
    private static function ensureViews(): void
    {
        try {
            $pdo = self::$instance;
            $viewsFile = APP_ROOT . '/sql/views.sql';
            
            if (file_exists($viewsFile)) {
                $sql = file_get_contents($viewsFile);
                // Ejecutar cada sentencia SQL
                $statements = array_filter(array_map('trim', explode(';', $sql)));
                foreach ($statements as $statement) {
                    if (!empty($statement)) {
                        $pdo->exec($statement);
                    }
                }
            }
        } catch (Exception $e) {
            error_log('Error al crear vistas: ' . $e->getMessage());
        }
    }

    /**
     * Ejecutar query preparada
     */
    public static function query(string $sql, array $params = []): PDOStatement
    {
        $pdo = self::pdo();
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    /**
     * Obtener un registro
     */
    public static function fetchOne(string $sql, array $params = []): ?array
    {
        $stmt = self::query($sql, $params);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result ?: null;
    }

    /**
     * Obtener múltiples registros
     */
    public static function fetchAll(string $sql, array $params = []): array
    {
        $stmt = self::query($sql, $params);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    /**
     * Obtener un valor
     */
    public static function getValue(string $sql, array $params = [])
    {
        $stmt = self::query($sql, $params);
        return $stmt->fetchColumn();
    }

    /**
     * Insertar registro
     */
    public static function insert(string $table, array $data): int
    {
        $pdo = self::pdo();
        $columns = implode(',', array_keys($data));
        $placeholders = implode(',', array_fill(0, count($data), '?'));
        
        $sql = "INSERT INTO $table ($columns) VALUES ($placeholders)";
        $stmt = $pdo->prepare($sql);
        $stmt->execute(array_values($data));
        
        return (int)$pdo->lastInsertId();
    }

    /**
     * Actualizar registros
     */
    public static function update(string $table, array $data, array $where): int
    {
        $pdo = self::pdo();
        $set = implode(',', array_map(fn($k) => "$k=?", array_keys($data)));
        $whereClause = implode(' AND ', array_map(fn($k) => "$k=?", array_keys($where)));
        
        $sql = "UPDATE $table SET $set WHERE $whereClause";
        $stmt = $pdo->prepare($sql);
        $stmt->execute(array_merge(array_values($data), array_values($where)));
        
        return $stmt->rowCount();
    }

    /**
     * Eliminar registros
     */
    public static function delete(string $table, array $where): int
    {
        $pdo = self::pdo();
        $whereClause = implode(' AND ', array_map(fn($k) => "$k=?", array_keys($where)));
        
        $sql = "DELETE FROM $table WHERE $whereClause";
        $stmt = $pdo->prepare($sql);
        $stmt->execute(array_values($where));
        
        return $stmt->rowCount();
    }

    /**
     * Comenzar transacción
     */
    public static function beginTransaction(): bool
    {
        return self::pdo()->beginTransaction();
    }

    /**
     * Confirmar transacción
     */
    public static function commit(): bool
    {
        return self::pdo()->commit();
    }

    /**
     * Revertir transacción
     */
    public static function rollback(): bool
    {
        return self::pdo()->rollBack();
    }
}
