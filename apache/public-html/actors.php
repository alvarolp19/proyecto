<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Actores</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            border-spacing: 0;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 6px;
            overflow: hidden;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #f2f2f2;
        }
        th {
            background-color: #f8f8f8;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f2f2f2;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
        .chart-container {
            width: 80%;
            margin: auto;
            margin-top: 20px;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
            <h2>Listado de Actores</h2>
            <table>
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Dirección</th>
                        <th>Número de Incidentes</th>
                    </tr>
                </thead>
                <tbody>
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

                    // Consulta SQL para obtener el listado de actores y sus direcciones
                    $sql = "SELECT Actores.nombre, IFNULL(Actores.url, 'No disponible') AS direccion, COUNT(Incidentes.id) AS num_incidentes 
                            FROM Actores 
                            LEFT JOIN Incidentes ON Actores.id = Incidentes.actor_id 
                            GROUP BY Actores.id";
                    $result = $conn->query($sql);

                    if ($result->num_rows > 0) {
                        // Mostrar listado de actores, sus direcciones y número de incidentes
                        while($row = $result->fetch_assoc()) {
                            echo "<tr>
                                    <td>" . $row["nombre"] . "</td>
                                    <td>" . $row["direccion"] . "</td>
                                    <td>" . $row["num_incidentes"] . "</td>
                                  </tr>";
                        }

                        // Obtener datos para la gráfica
                        $labels = [];
                        $data = [];
                        $result->data_seek(0);
                        while($row = $result->fetch_assoc()) {
                            if ($row["num_incidentes"] > 0) {
                                $labels[] = $row["nombre"];
                                $data[] = $row["num_incidentes"];
                            }
                        }
                    } else {
                        echo "<tr><td colspan='3'>No se encontraron actores</td></tr>";
                    }
                    $conn->close();
                    ?>
                </tbody>
            </table>

            <?php if (!empty($labels)): ?>
            <div class="chart-container">
                <canvas id="chart"></canvas>
            </div>
            <script>
                // Crear la gráfica con Chart.js
                var ctx = document.getElementById('chart').getContext('2d');
                var chart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: <?php echo json_encode($labels); ?>,
                        datasets: [{
                            label: 'Número de Incidentes por Actor',
                            data: <?php echo json_encode($data); ?>,
                            backgroundColor: 'rgba(54, 162, 235, 0.6)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                        }
                    }
                });
            </script>
            <?php endif; ?>
        </main>
    </div>
</body>
</html>

