import urllib.request
from html_table_parser.parser import HTMLTableParser
import json
import datetime
import os

def url_get_contents(url):
    req = urllib.request.Request(url=url)
    f = urllib.request.urlopen(req)
    return f.read()

def scrape_table(url):
    html_content = url_get_contents(url).decode('utf-8')
    parser = HTMLTableParser()
    parser.feed(html_content)
    table_data = parser.tables[0]



    tld_to_country = {

    "co.uk": "Reino Unido",

    "de": "Alemania",

    "abudhabi": "Emiratos Árabes Unidos",

    "ae": "Emiratos Árabes Unidos",

    "af": "Afganistán",

    "ax": "Åland",

    "al": "Albania",

    "dz": "Argelia",

    "as": "Samoa Americana",

    "ad": "Andorra",

    "ao": "Angola",

    "ai": "Anguila",

    "aq": "Antártida",

    "ag": "Antigua y Barbuda",

    "ar": "Argentina",

    "am": "Armenia",

    "aw": "Aruba",

    "ac": "Isla de Ascensión",

    "au": "Australia",

    "at": "Austria",

    "az": "Azerbaiyán",

    "bs": "Bahamas",

    "bh": "Baréin",

    "bd": "Bangladés",

    "bb": "Barbados",

    "eus": "País Vasco",

    "by": "Bielorrusia",

    "be": "Bélgica",

    "bz": "Belice",

    "bj": "Benín",

    "bm": "Bermudas",

    "bt": "Bután",

    "bo": "Bolivia",

    "bq": "Bonaire",

    "an": "Antillas Neerlandesas",

    "nl": "Países Bajos",

    "ba": "Bosnia y Herzegovina",

    "bw": "Botsuana",

    "bv": "Isla Bouvet",

    "br": "Brasil",

    "io": "Territorio Británico del Océano Índico",

    "vg": "Islas Vírgenes Británicas",

    "bn": "Brunéi",

    "bg": "Bulgaria",

    "bf": "Burkina Faso",

    "mm": "Birmania (Myanmar)",

    "bi": "Burundi",

    "kh": "Camboya",

    "cm": "Camerún",

    "ca": "Canadá",

    "cv": "Cabo Verde",

    "cat": "Cataluña",

    "ky": "Islas Caimán",

    "cf": "República Centroafricana",

    "td": "Chad",

    "cl": "Chile",

    "cn": "China",

    "cx": "Isla de Navidad",

    "cc": "Islas Cocos (Keeling)",

    "co": "Colombia",

    "km": "Comoras",

    "cd": "República Democrática del Congo",

    "cg": "República del Congo",

    "ck": "Islas Cook",

    "cr": "Costa Rica",

    "ci": "Costa de Marfil",

    "hr": "Croacia",

    "cu": "Cuba",

    "cw": "Curazao",

    "cy": "Chipre",

    "nc.tr": "Chipre del Norte",

    "cz": "República Checa",

    "dk": "Dinamarca",

    "dj": "Yibuti",

    "dm": "Dominica",

    "do": "República Dominicana",

    "ae": "Dubái",

    "tl": "Timor Oriental",

    "tp": "Timor Oriental",

    "ec": "Ecuador",

    "eg": "Egipto",

    "sv": "El Salvador",

    "gq": "Guinea Ecuatorial",

    "er": "Eritrea",

    "ee": "Estonia",

    "et": "Etiopía",

    "eu": "Unión Europea",

    "fo": "Islas Feroe",

    "fk": "Islas Malvinas",

    "fj": "Fiyi",

    "fi": "Finlandia",

    "fr": "Francia",

    "gf": "Guayana Francesa",

    "pf": "Polinesia Francesa",

    "tf": "Tierras Australes y Antárticas Francesas",

    "ga": "Gabón",

    "gal": "Galicia",

    "gm": "Gambia",

    "ps": "Franja de Gaza",

    "ge": "Georgia",

    "de": "Alemania",

    "gh": "Ghana",

    "gi": "Gibraltar",

    "gb": "Gran Bretaña",

    "gr": "Grecia",

    "gl": "Groenlandia",

    "gd": "Granada",

    "gp": "Guadalupe",

    "gu": "Guam",

    "gt": "Guatemala",

    "gg": "Guernsey",

    "gn": "Guinea",

    "gw": "Guinea-Bissau",

    "gy": "Guyana",

    "ht": "Haití",

    "hm": "Islas Heard y McDonald",

    "nl": "Holanda",

    "hn": "Honduras",

    "hk": "Hong Kong",

    "hu": "Hungría",

    "is": "Islandia",

    "in": "India",

    "id": "Indonesia",

    "ir": "Irán",

    "iq": "Irak",

    "ie": "Irlanda",

    "im": "Isla de Man",

    "il": "Israel",

    "it": "Italia",

    "jm": "Jamaica",

    "jp": "Japón",

    "je": "Jersey",

    "jo": "Jordania",

    "kz": "Kazajistán",

    "ke": "Kenia",

    "ki": "Kiribati",

    "kp": "Corea del Norte",

    "kr": "Corea del Sur",

    "kw": "Kuwait",

    "kg": "Kirguistán",

    "la": "Laos",

    "lv": "Letonia",

    "lb": "Líbano",

    "ls": "Lesoto",

    "lr": "Liberia",

    "ly": "Libia",

    "li": "Liechtenstein",

    "lt": "Lituania",

    "lu": "Luxemburgo",

    "mo": "Macao",

    "mk": "Macedonia del Norte",

    "mg": "Madagascar",

    "mw": "Malaui",

    "my": "Malasia",

    "mv": "Maldivas",

    "ml": "Malí",

    "mt": "Malta",

    "mh": "Islas Marshall",

    "mq": "Martinica",

    "mr": "Mauritania",

    "mu": "Mauricio",

    "yt": "Mayotte",

    "mx": "México",

    "fm": "Micronesia",

    "md": "Moldavia",

    "mc": "Mónaco",

    "mn": "Mongolia",

    "me": "Montenegro",

    "ms": "Montserrat",

    "ma": "Marruecos",

    "mz": "Mozambique",

    "na": "Namibia",

    "nr": "Nauru",

    "np": "Nepal",

    "nz": "Nueva Zelanda",

    "ni": "Nicaragua",

    "ne": "Níger",

    "ng": "Nigeria",

    "nu": "Niue",

    "nf": "Isla Norfolk",

    "nc.tr": "Chipre del Norte",

    "kp": "Corea del Norte",

    "mk": "Macedonia del Norte",

    "uk": "Reino Unido",

    "mp": "Islas Marianas del Norte",

    "no": "Noruega",

    "om": "Omán",

    "pk": "Pakistán",

    "pw": "Palau",

    "ps": "Palestina",

    "pa": "Panamá",

    "pg": "Papúa Nueva Guinea",

    "py": "Paraguay",

    "pe": "Perú",

    "ph": "Filipinas",

    "pn": "Islas Pitcairn",

    "pl": "Polonia",

    "pt": "Portugal",

    "pr": "Puerto Rico",

    "qa": "Catar",

    "re": "Reunión",

    "ro": "Rumania",

    "ru": "Rusia",

    "rw": "Ruanda",

    "bl": "San Bartolomé",

    "sh": "Santa Elena",

    "kn": "San Cristóbal y Nieves",

    "lc": "Santa Lucía",

    "mf": "San Martín",

    "vc": "San Vicente y las Granadinas",

    "pm": "San Pedro y Miquelón",

    "ws": "Samoa",

    "sm": "San Marino",

    "st": "Santo Tomé y Príncipe",

    "sa": "Arabia Saudita",

    "sn": "Senegal",

    "rs": "Serbia",

    "sc": "Seychelles",

    "sl": "Sierra Leona",

    "sg": "Singapur",

    "sk": "Eslovaquia",

    "si": "Eslovenia",

    "sb": "Islas Salomón",

    "so": "Somalia",

    "za": "Sudáfrica",

    "kr": "Corea del Sur",

    "ss": "Sudán del Sur",

    "es": "España",

    "lk": "Sri Lanka",

    "sd": "Sudán",

    "sr": "Surinam",

    "sj": "Svalbard y Jan Mayen",

    "sz": "Suazilandia",

    "se": "Suecia",

    "ch": "Suiza",

    "sy": "Siria",

    "tw": "Taiwán",

    "tj": "Tayikistán",

    "tz": "Tanzania",

    "th": "Tailandia",

    "tg": "Togo",

    "tk": "Tokelau",

    "to": "Tonga",

    "tt": "Trinidad y Tobago",

    "tn": "Túnez",

    "tr": "Turquía",

    "tm": "Turkmenistán",

    "tc": "Islas Turcas y Caicos",

    "tv": "Tuvalu",

    "ug": "Uganda",

    "ua": "Ucrania",

    "ae": "Emiratos Árabes Unidos",

    "us": "Estados Unidos",

    "vi": "Islas Vírgenes de los Estados Unidos",

    "uy": "Uruguay",

    "uz": "Uzbekistán",

    "vu": "Vanuatu",

    "va": "Ciudad del Vaticano",

    "ve": "Venezuela",

    "vn": "Vietnam",

    "wf": "Wallis y Futuna",

    "eh": "Sahara Occidental",

    "ye": "Yemen",

    "zm": "Zambia",

    "zw": "Zimbabue"

}



    incidentes = []
    for row in table_data[1:]:
        email_domain = row[1].split('.')[-1]
        pais_victima = tld_to_country.get(email_domain, "Desconocido")
        incidente = {'Fecha': row[0], 'Victima': row[1], 'Pais_Victima': pais_victima, 'Actor': row[2]}
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

url = 'https://www.ransomlook.io/recent'
nombre_archivo_registro = 'registro.json'  # Ruta relativa al directorio del script

# Verificar la ruta de los archivos de salida
ruta_absoluta_registro = os.path.abspath(nombre_archivo_registro)
print("Directorio de registro:", ruta_absoluta_registro)

fecha_actual = datetime.datetime.now()
nombre_archivo_nuevas_entradas = f"registros_diarios/{fecha_actual.strftime('%Y-%m-%d_%H-%M-%S')}.json"

# Directorio donde se encuentra el script
directorio_script = os.path.dirname(os.path.abspath(__file__))

nombre_archivo_registro_abs = os.path.join(directorio_script, nombre_archivo_registro)
nombre_archivo_nuevas_entradas_abs = os.path.join(directorio_script, nombre_archivo_nuevas_entradas)

registro_anterior = cargar_registro(nombre_archivo_registro_abs)
nuevos_incidentes = scrape_table(url)
todos_incidentes = registro_anterior + nuevos_incidentes

claves_unicas = set()
incidentes_sin_duplicados = []
entradas_duplicadas_eliminadas = 0

for incidente in todos_incidentes:
    clave = (incidente['Fecha'], incidente['Victima'], incidente['Actor'])
    if clave not in claves_unicas:
        claves_unicas.add(clave)
        incidentes_sin_duplicados.append(incidente)
    else:
        entradas_duplicadas_eliminadas += 1

guardar_registro(incidentes_sin_duplicados, nombre_archivo_registro_abs)
nuevas_entradas = [incidente for incidente in incidentes_sin_duplicados if incidente not in registro_anterior]
guardar_nuevas_entradas(nuevas_entradas, nombre_archivo_nuevas_entradas_abs)

for incidente in incidentes_sin_duplicados:
    print(incidente)

print(f"Se eliminaron {entradas_duplicadas_eliminadas} entradas duplicadas del registro.")
