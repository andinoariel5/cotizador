<?php
require_once dirname(__DIR__) . '/app/bootstrap.php';

$service = new QuoteService();
$data = $service->dashboard();
?>
<!doctype html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Cotizador</title>
  <link rel="stylesheet" href="assets/app.css" />
</head>
<body>
  <div class="container">
    <h1>Dashboard de Cotizaciones</h1>

    <div class="stats">
      <div class="card">
        <span>Total cotizaciones</span>
        <strong><?= (int)($data['stats']['total_quotes'] ?? 0) ?></strong>
      </div>
      <div class="card">
        <span>Borradores</span>
        <strong><?= (int)($data['stats']['draft_quotes'] ?? 0) ?></strong>
      </div>
      <div class="card">
        <span>Finalizadas</span>
        <strong><?= (int)($data['stats']['finalized_quotes'] ?? 0) ?></strong>
      </div>
      <div class="card">
        <span>Valor total</span>
        <strong>$<?= number_format((float)($data['stats']['total_value'] ?? 0), 2) ?></strong>
      </div>
    </div>

    <div class="actions">
      <a class="button primary" href="create_quote.php">Crear cotización</a>
    </div>

    <table>
      <thead>
        <tr>
          <th>Código</th>
          <th>Proyecto</th>
          <th>País</th>
          <th>Estado</th>
          <th>Precio final</th>
          <th>Fecha</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($data['quotes'] as $quote): ?>
          <tr>
            <td><a href="quote.php?id=<?= (int)$quote['id'] ?>"><?= htmlspecialchars($quote['public_code']) ?></a></td>
            <td><?= htmlspecialchars($quote['name']) ?></td>
            <td><?= htmlspecialchars($quote['country_name'] ?? '-') ?></td>
            <td><?= htmlspecialchars($quote['status']) ?></td>
            <td>$<?= number_format((float)($quote['final_price'] ?? 0), 2) ?></td>
            <td><?= htmlspecialchars($quote['created_at']) ?></td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
</body>
</html>
