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
            <ul>
                <li><a href="index.html">Dashboard</a></li>
                <li><a href="ramsome.php">Ransomware</a></li>
                <li><a href="cyber.php">Ciberataques</a></li>
                <li><a href="actors.php">Actores</a></li>
                <li><a href="mapa.html">Mapa de Incidentes</a></li>
                <li><a href="incidents-by-actor.php">Incidentes por Actor</a></li>
                <li><a href="incidents-by-country.php">Incidentes por País</a></li>
                <li><a href="exploit.php">Exploits Recientes</a></li>
                <li><a href="vuls.php">Vulnerabilidades</a></li>
                <li><a href="trends.html">Tendencias</a></li>
            </ul>
        </nav>
        <main class="content">
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

            if (isset($_GET['actor_id'])) {
                // Mostrar incidentes del actor seleccionado
                $actor_id = intval($_GET['actor_id']);
                $sql = "SELECT Actores.nombre AS actor_nombre, Incidentes.fecha, Incidentes.victima, Incidentes.Pais_Victima
                        FROM Incidentes
                        INNER JOIN Actores ON Incidentes.actor_id = Actores.id
                        WHERE Actores.id = $actor_id";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    echo "<h2>Incidentes del Actor</h2>";
                    echo "<table>";
                    echo "<thead>
                            <tr>
                                <th>Fecha</th>
                                <th>Víctima</th>
                                <th>País de la Víctima</th>
                            </tr>
                          </thead>
                          <tbody>";
                    while($row = $result->fetch_assoc()) {
                        echo "<tr>
                                <td>" . $row["fecha"] . "</td>
                                <td>" . $row["victima"] . "</td>
                                <td>" . $row["Pais_Victima"] . "</td>
                              </tr>";
                    }
                    echo "</tbody></table>";
                } else {
                    echo "<h2>No se encontraron incidentes para este actor.</h2>";
                }
                echo "<p><a href='actors.php'>Volver al listado de actores</a></p>";
            } else {
                // Mostrar listado de actores
                $sql = "SELECT Actores.id, Actores.nombre, IFNULL(Actores.url, 'No disponible') AS direccion, COUNT(Incidentes.id) AS num_incidentes 
                        FROM Actores 
                        LEFT JOIN Incidentes ON Actores.id = Incidentes.actor_id 
                        GROUP BY Actores.id";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    echo "<h2>Listado de Actores</h2>";
                    echo "<table>";
                    echo "<thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Dirección</th>
                                <th>Número de Incidentes</th>
                            </tr>
                          </thead>
                          <tbody>";
                    while($row = $result->fetch_assoc()) {
                        echo "<tr>
                                <td><a href='?actor_id=" . $row["id"] . "'>" . $row["nombre"] . "</a></td>
                                <td>" . $row["direccion"] . "</td>
                                <td>" . $row["num_incidentes"] . "</td>
                              </tr>";
                    }
                    echo "</tbody></table>";

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

                    if (!empty($labels)) {
                        echo "<div class='chart-container'>
                                <canvas id='chart'></canvas>
                              </div>
                              <script>
                                  // Crear la gráfica con Chart.js
                                  var ctx = document.getElementById('chart').getContext('2d');
                                  var chart = new Chart(ctx, {
                                      type: 'bar',
                                      data: {
                                          labels: " . json_encode($labels) . ",
                                          datasets: [{
                                              label: 'Número de Incidentes por Actor',
                                              data: " . json_encode($data) . ",
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
                              </script>";
                    }
                } else {
                    echo "<h2>No se encontraron actores</h2>";
                }
            }
            $conn->close();
            ?>
        </main>
    </div>
</body>
</html>
