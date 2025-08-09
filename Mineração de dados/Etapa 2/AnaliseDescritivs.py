import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from io import StringIO

# Define the ARFF content
arff_content = """@relation campeonato_sergipano

@attribute NomeTime {Sergipe, Barra, Dorense, Falcon, Lagarto, América, Confiança, Guarany, Itabaiana, Carmópolis}
@attribute PosseDeBola numeric
@attribute Escanteios numeric
@attribute ChutesAGol numeric
@attribute Impedimentos numeric
@attribute Gols numeric
@attribute Resultado {EMPATE, DERROTA, VITORIA}

@data
Sergipe,65,9,6,1,1,EMPATE
Barra,35,0,2,0,1,EMPATE
Dorense,55,4,1,1,0,DERROTA
Falcon,45,3,5,1,2,VITORIA
Lagarto,55,2,5,0,1,DERROTA
América,45,1,2,0,2,VITORIA
Confiança,60,6,10,2,5,VITORIA
Guarany,40,5,6,3,1,DERROTA
Itabaiana,54,8,3,1,2,VITORIA
Carmópolis,46,1,4,1,1,DERROTA
Dorense,45,1,0,2,0,DERROTA
América,55,5,2,2,1,VITORIA
Barra,43,0,1,0,1,DERROTA
Lagarto,57,2,6,0,4,VITORIA
Sergipe,47,8,2,1,2,VITORIA
Carmópolis,53,4,5,1,1,DERROTA
Guarany,46,7,3,1,1,EMPATE
Itabaiana,54,9,6,1,1,EMPATE
Falcon,53,3,6,0,1,DERROTA
Confiança,47,6,8,0,3,VITORIA
América,45,3,4,2,1,EMPATE
Confiança,55,3,5,0,1,EMPATE
Barra,41,7,2,3,0,DERROTA
Falcon,59,5,4,1,4,VITORIA
Dorense,55,3,3,1,0,EMPATE
Carmópolis,45,5,1,5,0,EMPATE
Lagarto,50,7,10,1,3,VITORIA
Guarany,50,1,5,3,1,DERROTA
Sergipe,48,7,3,0,1,EMPATE
Itabaiana,52,2,4,3,1,EMPATE
Confiança,58,5,7,3,0,EMPATE
Carmópolis,42,2,2,4,0,EMPATE
Barra,55,1,1,0,0,EMPATE
Guarany,55,1,3,1,0,EMPATE
América,45,6,5,0,0,EMPATE
Itabaiana,55,7,5,1,0,EMPATE
Sergipe,58,11,9,1,0,EMPATE
Falcon,42,1,1,1,0,EMPATE
Dorense,45,3,2,2,0,EMPATE
Lagarto,55,4,8,3,0,EMPATE
Lagarto,54,7,4,3,0,EMPATE
Confiança,46,6,7,3,0,EMPATE
Sergipe,45,5,4,0,1,VITORIA
Dorense,55,2,2,1,0,DERROTA
América,60,3,7,1,0,EMPATE
Guarany,40,6,3,4,0,EMPATE
Falcon,59,1,3,0,0,EMPATE
Itabaiana,41,2,6,0,0,EMPATE
Barra,39,5,6,1,3,VITORIA
Carmópolis,61,3,2,3,2,DERROTA
Sergipe,38,1,3,3,0,EMPATE
Confiança,62,6,5,4,0,EMPATE
Lagarto,50,0,5,0,0,EMPATE
Itabaiana,50,0,1,1,0,EMPATE
Dorense,55,2,5,0,0,EMPATE
Guarany,45,2,2,1,0,EMPATE
Falcon,57,8,7,1,0,EMPATE
Carmópolis,43,2,5,1,0,EMPATE
Barra,55,5,9,1,0,EMPATE
América,45,2,3,3,0,EMPATE
Barra,40,1,2,0,0,EMPATE
Confiança,60,4,12,1,0,EMPATE
América,50,3,6,2,0,EMPATE
Carmópolis,50,0,4,0,0,EMPATE
Falcon,45,1,2,0,0,DERROTA
Guarany,55,3,5,0,2,VITORIA
Dorense,40,3,3,1,0,EMPATE
Itabaiana,60,4,8,4,0,EMPATE
Sergipe,51,8,5,3,0,EMPATE
Lagarto,49,8,9,1,0,EMPATE
Confiança,59,7,4,1,0,EMPATE
Itabaiana,41,0,2,0,0,EMPATE
Sergipe,42,0,7,1,4,VITORIA
Guarany,58,2,3,1,0,DERROTA
Lagarto,59,6,7,3,1,EMPATE
Carmópolis,41,0,3,4,1,EMPATE
Barra,48,2,4,2,0,DERROTA
Dorense,52,3,7,1,2,VITORIA
Falcon,63,10,2,1,0,DERROTA
América,37,1,2,4,1,VITORIA
Barra,40,2,3,0,2,DERROTA
Itabaiana,60,2,8,1,4,VITORIA
Dorense,55,2,5,1,2,VITORIA
Confiança,45,1,2,0,1,DERROTA
Falcon,50,2,3,2,0,DERROTA
Lagarto,50,5,6,1,3,VITORIA
Sergipe,53,5,4,3,0,DERROTA
América,47,5,4,1,1,VITORIA
Guarany,60,3,3,1,2,VITORIA
Carmópolis,40,2,4,1,1,DERROTA
Sergipe,56,8,7,0,0,DERROTA
Itabaiana,44,2,2,1,2,VITORIA
Falcon,40,3,4,2,0,EMPATE
Lagarto,60,8,4,0,0,EMPATE
América,42,2,4,2,1,VITORIA
Guarany,58,6,1,0,0,DERROTA
América,57,3,3,0,1,EMPATE
Itabaiana,43,4,4,2,1,EMPATE
Falcon,50,0,4,0,1,DERROTA
Confiança,50,1,4,0,2,VITORIA
América,45,2,5,2,0,DERROTA
Itabaiana,55,2,4,2,1,VITORIA
Falcon,52,3,4,1,0,DERROTA
Confiança,48,1,5,1,3,VITORIA
Confiança,45,7,4,0,2,VITORIA
Itabaiana,55,10,5,2,1,DERROTA
Confiança,42,3,2,0,1,EMPATE
Itabaiana,28,9,5,2,1,EMPATE"""

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
team_results['Win_Rate'] = (team_results['VITORIA'] / team_results['Total'] * 100).round(2)
team_results = team_results.sort_values('Win_Rate', ascending=False)

print("\nTeam Performance:")
print(team_results)

# Save processed data for later use
df.to_csv('sergipano_processed.csv', index=False)

print("\nData saved to 'sergipano_processed.csv'")