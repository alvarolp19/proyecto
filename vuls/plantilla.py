import urllib.request
from html_table_parser.parser import HTMLTableParser
import json
import datetime

def url_get_contents(url):
    try:
        req = urllib.request.Request(url=url)
        f = urllib.request.urlopen(req)
        return f.read()
    except urllib.error.URLError as e:
        print(f"Error fetching URL {url}: {e}")
        return None

def scrape_table(url):
    html_content = url_get_contents(url)
    if not html_content:
        return []

    html_content = html_content.decode('utf-8')  # Decodificar de bytes a str

    parser = HTMLTableParser()
    parser.feed(html_content)

    if not parser.tables:
        return []

    table_data = parser.tables[0]

    incidentes = []
    for row in table_data[1:]:
        incidente = {'Producto': 'termino', 'Vuln ID': row[0], 'Resumen': row[1], 'Gravedad de CVSS': row[2]}
        incidentes.append(incidente)

    return incidentes

def cargar_registro(nombre_archivo):
    try:
        with open(nombre_archivo, 'r') as archivo:
            return json.load(archivo)
    except FileNotFoundError:
        return []

def guardar_registro(incidentes, nombre_archivo):
    with open(nombre_archivo, 'w') as archivo:
        json.dump(incidentes, archivo, ensure_ascii=False, indent=4)

def guardar_nuevas_entradas(nuevas_entradas, nombre_archivo):
    with open(nombre_archivo, 'w') as archivo:
        json.dump(nuevas_entradas, archivo, ensure_ascii=False, indent=4)

url = 'https://nvd.nist.gov/vuln/search/results?form_type=Basic&results_type=overview&query=termino&search_type=all&isCpeNameSearch=false'
nombre_archivo_registro = 'vuls/termino/registro.json'

fecha_actual = datetime.datetime.now()
nombre_archivo_nuevas_entradas = f"vuls/termino/{fecha_actual.strftime('%Y-%m-%d_%H-%M-%S')}_termino.json"

registro_anterior = cargar_registro(nombre_archivo_registro)
nuevos_incidentes = scrape_table(url)

todos_incidentes = registro_anterior + nuevos_incidentes

claves_unicas = set()
incidentes_sin_duplicados = []
entradas_duplicadas_eliminadas = 0

for incidente in todos_incidentes:
    clave = (incidente['Vuln ID'], incidente['Resumen'], incidente['Gravedad de CVSS'])
    if clave not in claves_unicas:
        claves_unicas.add(clave)
        incidentes_sin_duplicados.append(incidente)
    else:
        entradas_duplicadas_eliminadas += 1

guardar_registro(incidentes_sin_duplicados, nombre_archivo_registro)

nuevas_entradas = [incidente for incidente in incidentes_sin_duplicados if incidente not in registro_anterior]
guardar_nuevas_entradas(nuevas_entradas, nombre_archivo_nuevas_entradas)

for incidente in incidentes_sin_duplicados:
    print(incidente)

print(f"Se eliminaron {entradas_duplicadas_eliminadas} entradas duplicadas del registro.")

