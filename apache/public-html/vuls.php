<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Últimas Vulnerabilidades</title>
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
        form {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
        }
        select, button {
            padding: 10px;
            font-size: 16px;
            margin-right: 10px;
        }
        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
        .styled-button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
        .styled-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Menú lateral -->
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
        <!-- Contenido principal -->
        <main class="content">
            <h2>Últimas Vulnerabilidades</h2>
            <!-- Filtro de productos -->
            <form action="" method="post">
                <label for="producto">Seleccionar Producto:</label>
                <select name="producto" id="producto">
                    <option value="">Todos los productos</option>
                    <?php
                    // Conexión a la base de datos
                    $servername = "db";
                    $username = "root";
                    $password = "root";
                    $dbname = "vuls";

                    $conn = new mysqli($servername, $username, $password, $dbname);
                    if ($conn->connect_error) {
                        die("Conexión fallida: " . $conn->connect_error);
                    }

                    // Consulta SQL para obtener los productos
                    $sql = "SELECT ID_Producto, Nombre_Producto FROM Productos";
                    $result = $conn->query($sql);

                    if ($result->num_rows > 0) {
                        while($row = $result->fetch_assoc()) {
                            echo "<option value='" . $row["ID_Producto"] . "'>" . $row["Nombre_Producto"] . "</option>";
                        }
                    }
                    $conn->close();
                    ?>
                </select>
                <button type="submit" class="styled-button">Filtrar</button>
            </form>
            <!-- Fin del filtro de productos -->
            <table>
                <thead>
                    <tr>
                        <th>Vuln ID</th>
                        <th>Resumen</th>
                        <th>Gravedad CVSS</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    // Conexión a la base de datos
                    $conn = new mysqli($servername, $username, $password, $dbname);
                    if ($conn->connect_error) {
                        die("Conexión fallida: " . $conn->connect_error);
                    }

                    // Filtro de productos
                    $filtro = "";
                    if (isset($_POST['producto']) && !empty($_POST['producto'])) {
                        $producto_id = $_POST['producto'];
                        $filtro = " WHERE Producto_ID = $producto_id";
                    }

                    // Consulta SQL para obtener las últimas 100 vulnerabilidades con filtro opcional
                    $sql = "SELECT Vuln_ID, Resumen, Gravedad_CVSS FROM Vulnerabilidades $filtro ORDER BY Vuln_ID DESC LIMIT 100";
                    $result = $conn->query($sql);

                    if ($result->num_rows > 0) {
                        while($row = $result->fetch_assoc()) {
                            echo "<tr>
                                    <td>" . $row["Vuln_ID"] . "</td>
                                    <td>" . $row["Resumen"] . "</td>
                                    <td>" . $row["Gravedad_CVSS"] . "</td>
                                  </tr>";
                        }
                    } else {
                        echo "<tr><td colspan='3'>No se encontraron vulnerabilidades</td></tr>";
                    }
                    $conn->close();
                    ?>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>

