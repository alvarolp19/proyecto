<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Incidentes por Actor</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            display: flex;
        }
        
        .content {
            flex: 1;
            padding: 20px;
        }
        h2, h3 {
            color: #333;
        }
        form {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
        }
        select, button {
            padding: 10px;
            margin-top: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f8f8f8;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        a {
            color: #007bff;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .chart-container {
            width: 80%;
            margin: auto;
            margin-top: 20px;
        }
        .chart-container canvas {
            width: 100%;
            height: auto;
        }
    </style>
</head>
<body>
    <div class="container">
    <nav class="sidebar">
            <h2>Menú</h2>
            <ul>
                <li><a href="index.html">dashboard</a></li>
                <li><a href="ramsome.php">Ransomware</a></li>
                <li><a href="cyber.php">Cyber Attacks</a></li>
                <li><a href="actors.php">Actors</a></li>
                <li><a href="mapa.html">Incident Map</a></li>
                <li><a href="incidents-by-actor.php">Incidents by Actor</a></li>
                <li><a href="incidents-by-country.php">Incidents by Country</a></li>
                <li><a href="exploit.php">Recent Exploits</a></li>
                <li><a href="vuls.php">Vulnerabilities</a></li>
                <li><a href="trends.html">trends</a></li>
            </ul>
        </nav>
        <main class="content">
            <h2>Incidentes por Actor</h2>
            <form method="GET" action="incidents-by-actor.php">
                <label for="actor">Selecciona un Actor:</label>
                <select name="actor" id="actor">
                    <?php
                    // Conexión a la base de datos
                    $servername = "db";
                    $username = "root";
                    $password = "root";
                    $dbname = "ramsome";

                    $conn = new mysqli($servername, $username, $password, $dbname);
                    if ($conn->connect_error) {
                        die("Conexión fallida: " . $conn->connect_error);
                    }

                    // Consulta SQL para obtener todos los actores
                    $sql = "SELECT id, nombre FROM Actores";
                    $result = $conn->query($sql);

                    if ($result->num_rows > 0) {
                        while($row = $result->fetch_assoc()) {
                            echo "<option value='" . $row["id"] . "'>" . $row["nombre"] . "</option>";
                        }
                    } else {
                        echo "<option value=''>No se encontraron actores</option>";
                    }
                    $conn->close();
                    ?>
                </select>
                <button type="submit">Mostrar Incidentes</button>
            </form>

            <?php if (isset($_GET['actor'])): ?>
                <h3>Incidentes para el Actor Seleccionado</h3>
                <table>
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Víctima</th>
                            <th>País</th>
                            <th>Enlace</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $actor_id = $_GET['actor'];

                        // Conexión a la base de datos
                        $conn = new mysqli($servername, $username, $password, $dbname);
                        if ($conn->connect_error) {
                            die("Conexión fallida: " . $conn->connect_error);
                        }

                        // Consulta SQL para obtener los incidentes del actor seleccionado
                        $sql = "SELECT Incidentes.fecha, Incidentes.victima, Incidentes.Pais_Victima, Actores.url 
                                FROM Incidentes 
                                JOIN Actores ON Incidentes.actor_id = Actores.id 
                                WHERE Incidentes.actor_id = $actor_id 
                                ORDER BY Incidentes.fecha DESC";
                        $result = $conn->query($sql);

                        if ($result->num_rows > 0) {
                            while($row = $result->fetch_assoc()) {
                                echo "<tr>
                                        <td>" . $row["fecha"] . "</td>
                                        <td>" . $row["victima"] . "</td>
                                        <td>" . $row["Pais_Victima"] . "</td>
                                        <td><a href='" . $row["url"] . "' target='_blank'>Detalles</a></td>
                                      </tr>";
                            }
                        } else {
                            echo "<tr><td colspan='4'>No se encontraron incidentes para este actor</td></tr>";
                        }
                        $conn->close();
                        ?>
                    </tbody>
                </table>
            <?php endif; ?>

            <h3>Porcentaje de Ataques por Actor</h3>
            <div class="chart-container">
                <canvas id="actorChart"></canvas>
            </div>

            <?php
            // Conexión a la base de datos
            $conn = new mysqli($servername, $username, $password, $dbname);
            if ($conn->connect_error) {
                die("Conexión fallida: " . $conn->connect_error);
            }

            // Consulta SQL para obtener el número de incidentes por actor
            $sql = "SELECT Actores.nombre, COUNT(Incidentes.id) AS incident_count 
                    FROM Incidentes 
                    JOIN Actores ON Incidentes.actor_id = Actores.id 
                    GROUP BY Incidentes.actor_id";
            $result = $conn->query($sql);

            $actor_names = [];
            $incident_counts = [];

            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    $actor_names[] = $row["nombre"];
                    $incident_counts[] = $row["incident_count"];
                }
            }
            $conn->close();
            ?>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script>
                const ctx = document.getElementById('actorChart').getContext('2d');
                const actorChart = new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: <?php echo json_encode($actor_names); ?>,
                        datasets: [{
                            label: 'Porcentaje de Ataques',
                            data: <?php echo json_encode($incident_counts); ?>,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)',
                                // Agrega más colores si tienes más actores
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)',
                                // Agrega más colores si tienes más actores
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                            tooltip: {
                                callbacks: {
                                    label: function(tooltipItem) {
                                        return tooltipItem.label + ': ' + tooltipItem.raw + ' incidentes';
                                    }
                                }
                            }
                        }
                    }
                });
            </script>
        </main>
    </div>
</body>
</html>
