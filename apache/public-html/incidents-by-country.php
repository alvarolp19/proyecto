<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Incidentes por País</title>
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
            <h2>Incidentes por País</h2>
            <?php
            // Conexión a la base de datos
            $servername = "db";
            $username = "root";
            $password = "root";
            $dbname = "ciber";

            $conn = new mysqli($servername, $username, $password, $dbname);
            if ($conn->connect_error) {
                die("Conexión fallida: " . $conn->connect_error);
            }

            if (isset($_GET['pais'])) {
                $pais = $_GET['pais'];

                // Consulta SQL para obtener los incidentes del país seleccionado
                $sql = "SELECT fecha, victima, enlace FROM ciber WHERE pais = ?";
                $stmt = $conn->prepare($sql);
                $stmt->bind_param("s", $pais);
                $stmt->execute();
                $result = $stmt->get_result();

                echo "<h3>Incidentes en " . htmlspecialchars($pais) . "</h3>";
                echo "<table>
                        <thead>
                            <tr>
                                <th>Fecha</th>
                                <th>Víctima</th>
                                <th>Enlace</th>
                            </tr>
                        </thead>
                        <tbody>";

                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        echo "<tr>
                                <td>" . htmlspecialchars($row["fecha"]) . "</td>
                                <td>" . htmlspecialchars($row["victima"]) . "</td>
                                <td><a href='" . htmlspecialchars($row["enlace"]) . "' target='_blank'>Enlace</a></td>
                              </tr>";
                    }
                } else {
                    echo "<tr><td colspan='3'>No se encontraron incidentes para este país</td></tr>";
                }

                echo "</tbody></table>";
                echo "<div style='text-align:center; margin-top: 20px;'><a href='incidents-by-country.php'><button>Volver</button></a></div>";
            } else {
                // Consulta SQL para obtener el total de incidentes
                $sql_total = "SELECT COUNT(*) as total FROM ciber";
                $result_total = $conn->query($sql_total);
                $row_total = $result_total->fetch_assoc();
                $total_incidentes = $row_total['total'];

                // Consulta SQL para obtener el número de incidentes por país
                $sql = "SELECT paises_completos.pais_nombre, ciber.pais, COUNT(*) as count 
                        FROM ciber 
                        JOIN paises_completos ON ciber.pais = paises_completos.pais 
                        GROUP BY ciber.pais";
                $result = $conn->query($sql);

                $paises = [];
                $porcentajes = [];

                echo "<table>
                        <thead>
                            <tr>
                                <th>País</th>
                                <th>Porcentaje de Ataques</th>
                            </tr>
                        </thead>
                        <tbody>";

                if ($result->num_rows > 0) {
                    while($row = $result->fetch_assoc()) {
                        $pais_completo = $row["pais_nombre"];
                        $pais = $row["pais"];
                        $count = $row["count"];
                        $porcentaje = ($count / $total_incidentes) * 100;
                        $paises[] = $pais_completo;
                        $porcentajes[] = $porcentaje;
                        echo "<tr>
                                <td><a href='?pais=" . htmlspecialchars($pais) . "'>" . htmlspecialchars($pais_completo) . "</a></td>
                                <td>" . number_format($porcentaje, 2) . "%</td>
                              </tr>";
                    }
                } else {
                    echo "<tr><td colspan='2'>No se encontraron incidentes</td></tr>";
                }

                echo "</tbody></table>";

                echo "<div class='chart-container'>
                        <canvas id='countryChart'></canvas>
                      </div>
                      <div style='text-align:center; margin-top: 20px;'>
                        <a href='mapa.html'><button>Ver Mapa</button></a>
                      </div>";
            }

            $conn->close();
            ?>
        </main>
    </div>

    <script>
        var ctx = document.getElementById('countryChart').getContext('2d');
        var countryChart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: <?php echo json_encode($paises); ?>,
                datasets: [{
                    label: 'Porcentaje de Ataques por País',
                    data: <?php echo json_encode($porcentajes); ?>,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)',
                        'rgba(201, 203, 207, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)',
                        'rgba(201, 203, 207, 1)'
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
                            label: function(context) {
                                let label = context.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed !== null) {
                                    label += context.parsed.toFixed(2) + '%';
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>

