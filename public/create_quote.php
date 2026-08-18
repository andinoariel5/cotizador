<?php
require_once dirname(__DIR__) . '/app/bootstrap.php';

$service = new QuoteService();
$formData = $service->getFormData();

$errors = [];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        $result = $service->createQuote($_POST);
        header('Location: quote.php?id=' . (int)$result['id']);
        exit;
    } catch (Throwable $e) {
        $errors[] = $e->getMessage();
    }
}
?>
<!doctype html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Crear cotización</title>
  <link rel="stylesheet" href="assets/app.css" />
</head>
<body>
  <div class="container narrow">
    <h1>Crear cotización</h1>
    <a class="button ghost" href="index.php">← Volver</a>

    <?php if ($errors): ?>
      <div class="alert error"><?php foreach ($errors as $error): ?><div><?= htmlspecialchars($error) ?></div><?php endforeach; ?></div>
    <?php endif; ?>

    <form method="post">
      <div class="grid">
        <label>
          <span>Nombre del proyecto</span>
          <input type="text" name="name" required />
        </label>

        <label>
          <span>País</span>
          <select name="country_id" required>
            <option value="">Seleccione</option>
            <?php foreach ($formData['countries'] as $country): ?>
              <option value="<?= (int)$country['id'] ?>"><?= htmlspecialchars($country['name']) ?></option>
            <?php endforeach; ?>
          </select>
        </label>

        <label>
          <span>Categoría</span>
          <select name="category_id">
            <option value="">Seleccione</option>
            <?php foreach ($formData['categories'] as $category): ?>
              <option value="<?= (int)$category['id'] ?>"><?= htmlspecialchars($category['name']) ?></option>
            <?php endforeach; ?>
          </select>
        </label>

        <label>
          <span>Tipo de público</span>
          <select name="target_type_id">
            <option value="">Seleccione</option>
            <?php foreach ($formData['targetTypes'] as $type): ?>
              <option value="<?= (int)$type['id'] ?>"><?= htmlspecialchars($type['name']) ?></option>
            <?php endforeach; ?>
          </select>
        </label>

        <label>
          <span>Rango de edad</span>
          <select name="target_age_range_id">
            <option value="">Seleccione</option>
            <?php foreach ($formData['ageRanges'] as $age): ?>
              <option value="<?= (int)$age['id'] ?>"><?= htmlspecialchars($age['label']) ?></option>
            <?php endforeach; ?>
          </select>
        </label>

        <label>
          <span>Género</span>
          <select name="target_gender_id">
            <option value="">Seleccione</option>
            <?php foreach ($formData['genders'] as $gender): ?>
              <option value="<?= (int)$gender['id'] ?>"><?= htmlspecialchars($gender['label']) ?></option>
            <?php endforeach; ?>
          </select>
        </label>

        <label>
          <span>NSE</span>
          <select name="target_nse_id">
            <option value="">Seleccione</option>
            <?php foreach ($formData['nseLevels'] as $nse): ?>
              <option value="<?= (int)$nse['id'] ?>"><?= htmlspecialchars($nse['label']) ?></option>
            <?php endforeach; ?>
          </select>
        </label>

        <label>
          <span>Perfil B2B</span>
          <select name="b2b_profile_id">
            <option value="">Seleccione</option>
            <?php foreach ($formData['b2bProfiles'] as $profile): ?>
              <option value="<?= (int)$profile['id'] ?>"><?= htmlspecialchars($profile['name']) ?></option>
            <?php endforeach; ?>
          </select>
        </label>

        <label>
          <span>Metodología</span>
          <select name="methodology">
            <option value="cuantitativo">Cuantitativo</option>
            <option value="cualitativo">Cualitativo</option>
          </select>
        </label>

        <label>
          <span>Tamaño de muestra</span>
          <input type="number" min="1" name="sample_size" value="100" required />
        </label>

        <label>
          <span>Margen %</span>
          <input type="number" step="0.01" min="0" name="margin_percent" value="30" required />
        </label>

        <label>
          <span>Descuento %</span>
          <input type="number" step="0.01" min="0" name="discount_percent" value="20" required />
        </label>

        <label>
          <span>Días de telecom</span>
          <input type="number" min="1" name="telecom_days" value="3" />
        </label>

        <label>
          <span>Dispositivos / cloud</span>
          <input type="number" min="1" name="cloud_devices" value="1" />
        </label>

        <label>
          <span>Copias por participante</span>
          <input type="number" min="1" name="copies_per_participant" value="1" />
        </label>
      </div>

      <div class="actions">
        <button class="button primary" type="submit">Guardar cotización</button>
      </div>
    </form>
  </div>
</body>
</html>
