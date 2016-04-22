# kml-brasil
Coordenadas geográficas de fronteiras de estados e municípios brasileiros em formato KML e JSON.


## Fonte dos dados
As coordenadas foram extraídas diretamente do [IBGE](http://downloads.ibge.gov.br/downloads_geociencias.htm) que disponibiliza as malhas digitais através de Censos em coordenadas geodésicas (Latitude e Longitude) em Sirgas2000, na escala 1:250.000.


## Processamento dos dados
Os dados do IBGE são disponibilizados em formato [SHP](https://pt.wikipedia.org/wiki/Shapefile) (shapefile) e foram convertidos para KML e JSON afim de facilitar a manipulação dentro do Google Maps ou qualquer outra utilização necessária.

Para reduzir o tamanho dos arquivos e a complexidade para o carregamento em navegadores, os poligonos foram suavizados utilizando o [mapshaper](https://github.com/mbloch/mapshaper) e exportados para [TopoJSON](https://github.com/mbostock/topojson), e posteriormente re-exportados para KML e JSON (nos formatos disponibilizados neste repositório).

## Encode dos arquivos
Todos os arquivos `kml` e `json` estão salvos em `UTF-8`.

## Organização de arquivos
Os arquivos na [biblioteca](./lib) estão organizados nas seguinte forma:

- 9999 (ano do censo)
  - estados
    - json
      - **UF.json** *(documento contendo fronteiras do estado específico)*
    - kml
      - **UF.kml** *(xml contendo fronteiras do estado específico)*
  - municipios
    - UF
      - json
        - **MUNICIPIO.json** *(documento contendo fronteiras do municipio específico)*
      - kml
        - **MUNICIPIO.kml** *(xml contendo fronteiras do municipio específico)*
  - pais *(agrupado por país)*
    - json
      - **Brasil_Estados.json** *(array contendo todos os estados do país)*
      - **Brasil_Municipios.json** *(array contendo todos os municipios do país)*
    - kml
      - **Brasil_Estados.kml** *(xml contendo todos os estados do país separados por placemark)*
      - **Brasil_Municipios.kml** *(xml contendo todos os municipios do país separados por placemark)*
  - **br.9999.estados.zip** *(arquivo compactado com `kml` e `json` de cada estado)*
  - **br.9999.municipios.zip** *(arquivo compactado com `kml` e `json` de cada municipio)*
 
## Formato de arquivos

### UF.kml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
	<name>UF.kml</name>
	<Placemark>
		<name>UF</name>
		<description>NOME DO ESTADO / REGIÃO</description>
		<LineString>
			<coordinates>
				lng,lat
				...
			</coordinates>
		</LineString>
	</Placemark>
	[...]
</Document>
</kml>
```
*__Nota__: O documento pode possuir mais de um `Placemark` em caso de estados que possuam ilhas por exemplo.*

### UF.json
```json
{
	"state": {
		"code": "UF",
		"name": "NOME DO ESTADO",
		"region": "REGIÃO"
	},
	"borders": [
		[
			{
				"lat": 99.999999999,
				"lng": 99.999999999
			}
		]
	]
}
```
*__Nota__: A array `borders` pode possuir varios elementos em caso de estados que possuam ilhas por exemplo.*


### MUNICIPIO.kml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
	<name>MUNICIPIO.kml</name>
	<Placemark>
		<name>MUNICIPIO</name>
		<description>NOME DO MUNICIPIO / UF</description>
		<LineString>
			<coordinates>
				lng,lat
				...
			</coordinates>
		</LineString>
	</Placemark>
	[...]
</Document>
</kml>
```
*__Nota__: O documento pode possuir mais de um `Placemark` em caso de municipios que possuam ilhas por exemplo.*

### MUNICIPIO.json
```json
{
	"city": {
		"name": "NOME DO MUNICIPIO",
		"state": "UF"
	},
	"borders": [
		[
			{
				"lat": 99.999999999,
				"lng": 99.999999999
			}
		]
	]
}
```
*__Nota__: A array `borders` pode possuir varios elementos em caso de municipios que possuam ilhas por exemplo.*

### Brasil_Estados.kml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
	<name>Brasil_Estados.kml</name>
	<Placemark>
		<name>UF</name>
		<description>NOME DO ESTADO / REGIÃO</description>
		<LineString>
			<coordinates>
				lng,lat
				...
			</coordinates>
		</LineString>
	</Placemark>
	...
</Document>
</kml>
```
*__Nota__: O documento possui um `Placemark` para cada estado (sendo que alguns estados com ilhas podem possuir vários).*


### Brasil_Estados.json
```json
[
  {
  	"state": {
  		"code": "UF",
  		"name": "NOME DO ESTADO",
  		"region": "REGIÃO"
  	},
  	"borders": [
  		[
  			{
  				"lat": 99.999999999,
  				"lng": 99.999999999
  			}
  		]
  	]
  }
]
```
*__Nota__: A array `borders` pode possuir varios elementos em caso de estados que possuam ilhas por exemplo.*

### Brasil_Municipios.kml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
	<name>Brasil_Municipios.kml</name>
	<Placemark>
		<name>MUNICIPIO</name>
		<description>NOME DO MUNICIPIO / UF</description>
		<LineString>
			<coordinates>
				lng,lat
				...
			</coordinates>
		</LineString>
	</Placemark>
	...
</Document>
</kml>
```
*__Nota__: O documento possui um `Placemark` para cada municipio (sendo que alguns municipio com ilhas podem possuir vários).*

### Brasil_Municipios.json
```json
[
  {
  	"city": {
  		"name": "NOME DO MUNICIPIO",
  		"state": "UF"
  	},
  	"borders": [
  		[
  			{
  				"lat": 99.999999999,
  				"lng": 99.999999999
  			}
  		]
  	]
  }
]
```
*__Nota__: A array `borders` pode possuir varios elementos em caso de municipios que possuam ilhas por exemplo.*
