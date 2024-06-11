import pandas as pd
import json
import folium
from geopy.geocoders import Nominatim
import pycountry
from datetime import datetime
from geopy.point import Point  

with open('./registros.json', 'r') as file:
    data = json.load(file)

df = pd.DataFrame(data)

df['Fecha'] = pd.to_datetime(df['Fecha'])

current_year = datetime.now().year

df_currentyear = df[df['Fecha'].dt.year == current_year]

country_counts = df_currentyear['Pais'].value_counts().reset_index()
country_counts.columns = ['country', 'count']

geolocator = Nominatim(user_agent="mapa_ciberataques", timeout=20)  
country_counts['coords'] = country_counts['country'].apply(lambda x: geolocator.geocode(pycountry.countries.get(alpha_3=x).name).point if (pycountry.countries.get(alpha_3=x) and geolocator.geocode(pycountry.countries.get(alpha_3=x).name)) else None)

map = folium.Map(location=[20, 0], zoom_start=2)

scale_factor = 1

for idx, row in country_counts.iterrows():
    if row['coords'] is not None and isinstance(row['coords'], Point):  # Verificar si es un objeto Point
        lat, lon = row['coords'].latitude, row['coords'].longitude  # Acceder a los atributos latitude y longitude
        if lat is not None and lon is not None:
            folium.CircleMarker(
                location=[lat, lon],
                radius=scale_factor * row['count']**0.5,
                popup=f"{pycountry.countries.get(alpha_3=row['country']).name}: {row['count']} incidente(s)",
                color='red',
                fill=True,
                fill_opacity=0.7
            ).add_to(map)
        else:
            print("Skipping " + row['country'] + " debido a coordenadas faltantes o inválidas.")
    else:
        print("Skipping " + row['country'] + " debido a coordenadas faltantes o inválidas.")

map.save('../apache/public-html/mapa.html')

print('Mapa creado exitosamente.')

