<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Últimos 100 Incidentes de Ransomware</title>
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
            <h2>Últimos 100 Incidentes de Ransomware</h2>
            <table>
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Víctima</th>
                        <th>Actor</th>
                        <th>País</th>
                        <th>Enlace</th>
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

                    // Consulta SQL para obtener los últimos 100 incidentes
                    $sql = "SELECT Incidentes.fecha, Incidentes.victima, Actores.nombre AS actor, Incidentes.Pais_Victima AS pais, Actores.url 
                            FROM Incidentes 
                            JOIN Actores ON Incidentes.actor_id = Actores.id 
                            ORDER BY Incidentes.fecha DESC 
                            LIMIT 100";
                    $result = $conn->query($sql);

                    if ($result->num_rows > 0) {
                        // Mostrar datos de los incidentes
                        while($row = $result->fetch_assoc()) {
                            echo "<tr>
                                    <td>" . $row["fecha"] . "</td>
                                    <td>" . $row["victima"] . "</td>
                                    <td>" . $row["actor"] . "</td>
                                    <td>" . $row["pais"] . "</td>
                                    <td><a href='" . $row["url"] . "' target='_blank'>Detalles</a></td>
                                  </tr>";
                        }
                    } else {
                        echo "<tr><td colspan='5'>No se encontraron incidentes</td></tr>";
                    }
                    $conn->close();
                    ?>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>

