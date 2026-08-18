<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
date_default_timezone_set('America/Honduras');

define('APP_ROOT', dirname(__DIR__));
define('APP_ENV', env('APP_ENV', 'development'));

function env(string $key, $default = null)
{
    $value = $_ENV[$key] ?? $_SERVER[$key] ?? getenv($key);

    if ($value === false || $value === null || $value === '') {
        return $default;
    }

    return $value;
}

function dd($data) {
    echo '<pre>';
    var_dump($data);
    echo '</pre>';
    die;
}

function response(array $data, int $status = 200) {
    header('Content-Type: application/json');
    http_response_code($status);
    return json_encode($data, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
}

// Load all classes
require_once APP_ROOT . '/app/Db.php';
require_once APP_ROOT . '/app/QuoteService.php';
require_once APP_ROOT . '/app/ProjectModel.php';
require_once APP_ROOT . '/app/CountryModel.php';
require_once APP_ROOT . '/app/CostModel.php';
require_once APP_ROOT . '/app/AuditLog.php';
