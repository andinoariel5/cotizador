<?php
require_once dirname(__DIR__) . '/app/bootstrap.php';

$service = new QuoteService();
$id = (int)($_GET['id'] ?? 0);
$quote = $service->getProject($id);
?>
<!doctype html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Detalle de cotización</title>
  <link rel="stylesheet" href="assets/app.css" />
</head>
<body>
  <div class="container">
    <h1>Detalle de cotización</h1>
    <a class="button ghost" href="index.php">← Volver</a>

    <?php if (!$quote): ?>
      <div class="alert error">No se encontró la cotización.</div>
      <?php return; ?>
    <?php endif; ?>

    <div class="summary-box">
      <h2><?= htmlspecialchars($quote['public_code']) ?> - <?= htmlspecialchars($quote['name']) ?></h2>
      <div class="summary-grid">
        <div><strong>Total costo:</strong> $<?= number_format((float)($quote['total_cost'] ?? 0), 2) ?></div>
        <div><strong>Margen:</strong> $<?= number_format((float)($quote['total_margin'] ?? 0), 2) ?></div>
        <div><strong>Precio final:</strong> $<?= number_format((float)($quote['final_price'] ?? 0), 2) ?></div>
        <div><strong>Estado:</strong> <?= htmlspecialchars($quote['status']) ?></div>
      </div>
    </div>

    <table>
      <thead>
        <tr>
          <th>Sección</th>
          <th>Concepto</th>
          <th>Cantidad</th>
          <th>Unitario</th>
          <th>Total</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($quote['lines'] as $line): ?>
          <tr>
            <td><?= htmlspecialchars($line['cost_section']) ?></td>
            <td><?= htmlspecialchars($line['description']) ?></td>
            <td><?= number_format((float)($line['quantity'] ?? 0), 2) ?></td>
            <td>$<?= number_format((float)($line['unit_cost'] ?? 0), 2) ?></td>
            <td>$<?= number_format((float)($line['total_cost'] ?? 0), 2) ?></td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
</body>
</html>
