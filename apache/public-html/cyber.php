<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ciber Ataques</title>
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
            <h2>Ciber Ataques</h2>
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

            // Consulta SQL para obtener los incidentes
            $sql = "SELECT ciber.fecha, ciber.victima, ciber.enlace, paises_completos.pais_nombre
        FROM ciber
        JOIN paises_completos ON ciber.pais = paises_completos.pais
        ORDER BY ciber.fecha DESC";
            $result = $conn->query($sql);

            echo "<table>
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Víctima</th>
                            <th>Enlace</th>
                            <th>País</th>
                        </tr>
                    </thead>
                    <tbody>";

            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    echo "<tr>
                            <td>" . htmlspecialchars($row["fecha"]) . "</td>
                            <td>" . htmlspecialchars($row["victima"]) . "</td>
                            <td><a href='" . htmlspecialchars($row["enlace"]) . "' target='_blank'>Enlace</a></td>
                            <td>" . htmlspecialchars($row["pais_nombre"]) . "</td>
                          </tr>";
                }
            } else {
                echo "<tr><td colspan='4'>No se encontraron incidentes</td></tr>";
            }

            echo "</tbody></table>";

            $conn->close();
            ?>
        </main>
    </div>
</body>
</html>

