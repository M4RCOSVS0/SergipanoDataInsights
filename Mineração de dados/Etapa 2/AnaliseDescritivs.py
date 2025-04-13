import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from io import StringIO

# Define the ARFF content
arff_content = """@relation campeonato_sergipano

@attribute NomeTime {Sergipe, Barra, Dorense, Falcon, Lagarto, America, Confianca, Guarany, Itabaiana, Carmopolis}
@attribute PosseDeBola {baixa, media, alta}
@attribute Escanteios {poucos, medios, muitos}
@attribute ChutesAgol {poucos, medios, muitos}
@attribute Impedimentos {nenhum, alguns, muitos}
@attribute Gols {0, 1, 2, 3, 4_ou_mais}
@attribute Resultado {vitoria, empate, derrota}

@data
Sergipe,alta,muitos,medios,alguns,1,empate
Barra,baixa,poucos,poucos,nenhum,1,empate
Dorense,media,medios,poucos,alguns,0,derrota
Falcon,media,medios,medios,alguns,2,vitoria
Lagarto,media,poucos,medios,nenhum,2,vitoria
America,media,poucos,poucos,nenhum,1,derrota
Confianca,alta,medios,muitos,alguns,4_ou_mais,vitoria
Guarany,baixa,medios,medios,muitos,1,derrota
Itabaiana,media,muitos,poucos,alguns,2,vitoria
Carmopolis,media,poucos,medios,alguns,1,derrota
America,media,medios,poucos,alguns,1,vitoria
Dorense,media,poucos,poucos,alguns,0,derrota
Barra,baixa,poucos,poucos,nenhum,0,derrota
Lagarto,alta,poucos,medios,nenhum,4_ou_mais,vitoria
Carmopolis,media,medios,medios,alguns,1,derrota
Sergipe,media,muitos,poucos,alguns,2,vitoria
Itabaiana,media,muitos,medios,alguns,1,empate
Guarany,media,muitos,poucos,alguns,1,empate
Confianca,media,medios,muitos,nenhum,3,vitoria
Falcon,media,poucos,medios,nenhum,1,derrota
Confianca,media,poucos,medios,nenhum,1,empate
America,media,poucos,medios,alguns,1,empate
Falcon,alta,medios,medios,alguns,4_ou_mais,vitoria
Barra,baixa,muitos,poucos,muitos,0,derrota
Dorense,media,poucos,poucos,alguns,0,empate
Carmopolis,media,medios,poucos,muitos,0,empate
Lagarto,media,muitos,muitos,alguns,4_ou_mais,vitoria
Guarany,media,poucos,medios,muitos,0,derrota
Sergipe,media,muitos,poucos,nenhum,1,empate
Itabaiana,media,poucos,medios,muitos,1,empate
Carmopolis,baixa,poucos,poucos,muitos,1,derrota
Confianca,alta,medios,muitos,muitos,2,vitoria
Guarany,media,poucos,poucos,alguns,1,vitoria
Barra,media,poucos,poucos,nenhum,0,derrota
America,media,medios,medios,nenhum,1,empate
Itabaiana,media,muitos,medios,alguns,1,empate
Sergipe,alta,muitos,muitos,alguns,0,derrota
Falcon,baixa,poucos,poucos,alguns,1,vitoria
Dorense,media,poucos,poucos,alguns,1,empate
Lagarto,media,medios,muitos,muitos,1,empate
Lagarto,media,muitos,medios,muitos,0,derrota
Confianca,media,medios,muitos,muitos,4_ou_mais,vitoria
Dorense,media,poucos,poucos,alguns,0,derrota
Sergipe,media,medios,medios,nenhum,1,vitoria
America,alta,poucos,muitos,alguns,3,vitoria
Guarany,baixa,medios,poucos,muitos,0,derrota
Itabaiana,baixa,poucos,medios,nenhum,4_ou_mais,vitoria
Falcon,alta,poucos,poucos,nenhum,0,derrota
Barra,baixa,medios,medios,alguns,3,vitoria
Carmopolis,alta,poucos,poucos,muitos,2,derrota
Sergipe,baixa,poucos,poucos,muitos,1,derrota
Confianca,alta,medios,medios,muitos,2,vitoria
Lagarto,media,poucos,medios,nenhum,0,derrota
Itabaiana,media,poucos,poucos,alguns,1,vitoria
Dorense,media,poucos,medios,nenhum,1,derrota
Guarany,media,poucos,poucos,alguns,2,vitoria
Falcon,alta,muitos,muitos,alguns,3,vitoria
Carmopolis,baixa,poucos,medios,alguns,2,derrota
America,media,poucos,poucos,muitos,0,derrota
Barra,media,medios,muitos,alguns,1,vitoria
Barra,baixa,poucos,poucos,nenhum,1,derrota
Confianca,alta,medios,muitos,alguns,4_ou_mais,vitoria
Carmopolis,media,poucos,medios,nenhum,1,empate
America,media,poucos,medios,alguns,1,empate
Falcon,media,poucos,poucos,nenhum,0,derrota
Guarany,media,poucos,medios,nenhum,2,vitoria
Dorense,baixa,poucos,poucos,alguns,1,derrota
Itabaiana,alta,medios,muitos,muitos,4_ou_mais,vitoria
Lagarto,media,muitos,muitos,alguns,4_ou_mais,vitoria
Sergipe,media,muitos,medios,muitos,0,derrota
Confianca,alta,muitos,medios,alguns,0,empate
Itabaiana,baixa,poucos,poucos,nenhum,0,empate
Sergipe,baixa,poucos,muitos,alguns,4_ou_mais,vitoria
Guarany,alta,poucos,poucos,alguns,0,derrota
Carmopolis,baixa,poucos,poucos,muitos,1,empate
Lagarto,alta,medios,muitos,muitos,1,empate
Dorense,media,poucos,muitos,alguns,2,vitoria
Barra,media,poucos,medios,alguns,0,derrota
Falcon,alta,muitos,poucos,alguns,0,derrota
America,baixa,poucos,poucos,muitos,1,vitoria
Itabaiana,alta,poucos,muitos,alguns,4_ou_mais,vitoria
Barra,baixa,poucos,poucos,nenhum,2,derrota
Confianca,media,poucos,poucos,nenhum,1,derrota
Dorense,media,poucos,medios,alguns,2,vitoria
Falcon,media,poucos,poucos,alguns,0,derrota
Lagarto,media,medios,medios,alguns,3,vitoria
America,media,medios,medios,alguns,1,vitoria
Sergipe,media,medios,medios,muitos,0,derrota
Carmopolis,baixa,poucos,medios,alguns,1,derrota
Guarany,alta,poucos,poucos,alguns,2,vitoria"""

# Parse ARFF data
lines = arff_content.strip().split('\n')
data_section = False
data_lines = []
attributes = []

for line in lines:
    line = line.strip()
    if line.startswith('@attribute'):
        # Extract attribute name
        attr_name = line.split(' ')[1]
        attributes.append(attr_name)
    elif line == '@data':
        data_section = True
    elif data_section and line:
        data_lines.append(line)

# Convert to Pandas DataFrame
df = pd.DataFrame([line.split(',') for line in data_lines], columns=attributes)

# Display basic information
print("Shape of dataset:", df.shape)
print("\nFirst 5 rows:")
print(df.head())

print("\nSummary statistics:")
# Count values for categorical variables
for column in df.columns:
    print(f"\n{column} value counts:")
    print(df[column].value_counts())
    print(f"{column} distribution percentage:")
    print(df[column].value_counts(normalize=True).mul(100).round(2))

# Analyze relationship between features and target
print("\nRelationship between features and target (Resultado):")
for column in df.columns[:-1]:  # All columns except Resultado
    print(f"\nContingency table for {column} vs Resultado:")
    ct = pd.crosstab(df[column], df['Resultado'], normalize='index').mul(100).round(2)
    print(ct)

# Visualize distribution of the target variable
plt.figure(figsize=(10, 6))
df['Resultado'].value_counts().plot(kind='bar')
plt.title('Distribution of Match Results')
plt.xlabel('Result')
plt.ylabel('Count')
plt.savefig('result_distribution.png')

# Visualize relationship between goals and result
plt.figure(figsize=(10, 6))
pd.crosstab(df['Gols'], df['Resultado']).plot(kind='bar', stacked=True)
plt.title('Relationship between Goals and Result')
plt.xlabel('Goals')
plt.ylabel('Count')
plt.savefig('goals_vs_result.png')

# Analyze team performance
team_results = pd.crosstab(df['NomeTime'], df['Resultado'])
team_results['Total'] = team_results.sum(axis=1)
team_results['Win_Rate'] = (team_results['vitoria'] / team_results['Total'] * 100).round(2)
team_results = team_results.sort_values('Win_Rate', ascending=False)

print("\nTeam Performance:")
print(team_results)

# Save processed data for later use
df.to_csv('sergipano_processed.csv', index=False)

print("\nData saved to 'sergipano_processed.csv'")