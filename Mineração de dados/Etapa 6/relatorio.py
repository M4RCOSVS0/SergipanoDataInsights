import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import joblib
from sklearn.metrics import confusion_matrix, accuracy_score, classification_report
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split

# Load the saved model and data
try:
    # Try to load the dataset
    df = pd.read_csv(
        'D:\\Documentos\\GitHub\\Colab Projetos\\SergipanoDataInsights\\Mineração de dados\\sergipano_processed.csv')
    print(f"Dataset carregado com sucesso: {df.shape}")
    print(f"Colunas: {df.columns.tolist()}")
except Exception as e:
    print(f"Erro ao carregar dataset: {e}")
    exit()

# Carregar modelo
model = None
model_name = "Modelo não encontrado"

try:
    model = joblib.load(
        'D:\\Documentos\\GitHub\\Colab Projetos\\SergipanoDataInsights\\Mineração de dados\\random_forest_model.pkl')
    model_name = "Random Forest"
    print(f"Modelo {model_name} carregado com sucesso")
except:
    try:
        model = joblib.load('svm_model.pkl')
        model_name = "SVM"
        print(f"Modelo {model_name} carregado com sucesso")
    except Exception as e:
        print(f"Erro ao carregar modelos: {e}")
        print("Continuando sem modelo para análise exploratória...")

# Set up the visualization style
plt.style.use('ggplot')
sns.set(style="whitegrid")
plt.rcParams.update({'font.size': 12})

# Create a dashboard layout
fig = plt.figure(figsize=(20, 16))
fig.suptitle(f"Sergipano Championship Analysis - Prediction Model: {model_name}", fontsize=20)

# 1. Distribution of match results
ax1 = plt.subplot2grid((3, 3), (0, 0))
result_counts = df['Resultado'].value_counts()
colors = ['#2ca02c' if 'vitoria' in str(x).lower() else '#d62728' if 'derrota' in str(x).lower() else '#1f77b4'
          for x in result_counts.index]
result_counts.plot(kind='bar', ax=ax1, color=colors)
ax1.set_title('Distribution of Match Results')
ax1.set_ylabel('Count')
ax1.set_xlabel('Result')
for i, v in enumerate(result_counts):
    ax1.text(i, v + 0.5, str(v), ha='center')

# 2. Goals vs Results
ax2 = plt.subplot2grid((3, 3), (0, 1), colspan=2)
goals_results = pd.crosstab(df['Gols'], df['Resultado'])
goals_results.plot(kind='bar', stacked=True, ax=ax2, colormap='viridis')
ax2.set_title('Relationship between Goals and Match Results')
ax2.set_xlabel('Goals')
ax2.set_ylabel('Count')
ax2.legend(title='Result')

# 3. Team Performance
ax3 = plt.subplot2grid((3, 3), (1, 0), colspan=3)
team_results = pd.crosstab(df['NomeTime'], df['Resultado'])
team_results['Total'] = team_results.sum(axis=1)

# Verificar quais colunas existem no crosstab
available_columns = team_results.columns.tolist()
print(f"Colunas disponíveis no crosstab: {available_columns}")

# Calcular win rate baseado nas colunas que existem
victory_cols = [col for col in available_columns if 'vitoria' in str(col).lower()]
if victory_cols:
    team_results['Win_Rate'] = (team_results[victory_cols[0]] / team_results['Total'] * 100).round(2)
else:
    team_results['Win_Rate'] = 0
    print("Warning: No victory column found, setting win rate to 0")

team_results = team_results.sort_values('Win_Rate', ascending=False)

# Plot the win rates
team_results['Win_Rate'].plot(kind='bar', ax=ax3, color='#2ca02c')
ax3.set_title('Team Win Rates')
ax3.set_xlabel('Team')
ax3.set_ylabel('Win Rate (%)')
ax3.set_xticklabels(ax3.get_xticklabels(), rotation=45)
for i, v in enumerate(team_results['Win_Rate']):
    ax3.text(i, v + 1, f"{v}%", ha='center')

# 4. Factors influencing victories
ax4 = plt.subplot2grid((3, 3), (2, 0))
victory_results = df[df['Resultado'].str.lower().str.contains('vitoria', na=False)]
if len(victory_results) > 0:
    victory_by_possession = victory_results['PosseDeBola'].value_counts()
    victory_by_possession.plot(kind='pie', ax=ax4, autopct='%1.1f%%', startangle=90, colors=sns.color_palette("Blues"))
    ax4.set_title('Ball Possession in Victories')
else:
    ax4.text(0.5, 0.5, 'No victory data available', ha='center', va='center', transform=ax4.transAxes)
    ax4.set_title('Ball Possession Analysis')
ax4.set_ylabel('')

# 5. Corner kicks in victories
ax5 = plt.subplot2grid((3, 3), (2, 1))
if len(victory_results) > 0:
    victory_by_corners = victory_results['Escanteios'].value_counts()
    victory_by_corners.plot(kind='pie', ax=ax5, autopct='%1.1f%%', startangle=90, colors=sns.color_palette("Greens"))
    ax5.set_title('Corner Kicks in Victories')
else:
    ax5.text(0.5, 0.5, 'No victory data available', ha='center', va='center', transform=ax5.transAxes)
    ax5.set_title('Corner Kicks Analysis')
ax5.set_ylabel('')

# 6. Shots on goal in victories
ax6 = plt.subplot2grid((3, 3), (2, 2))
if len(victory_results) > 0:
    victory_by_shots = victory_results['ChutesAGol'].value_counts()
    victory_by_shots.plot(kind='pie', ax=ax6, autopct='%1.1f%%', startangle=90, colors=sns.color_palette("Reds"))
    ax6.set_title('Shots on Goal in Victories')
else:
    ax6.text(0.5, 0.5, 'No victory data available', ha='center', va='center', transform=ax6.transAxes)
    ax6.set_title('Shots on Goal Analysis')
ax6.set_ylabel('')

# Adjust layout
plt.tight_layout(rect=[0, 0.03, 1, 0.95])

# Save the dashboard
plt.savefig('sergipano_championship_dashboard.png', dpi=300, bbox_inches='tight')
print("Dashboard saved as 'sergipano_championship_dashboard.png'")

# Create a model evaluation visualization ONLY if model exists
if model is not None:
    try:
        # Preparar dados para predição
        print("Preparando dados para predição...")

        # Separate features and target
        feature_columns = ['NomeTime', 'PosseDeBola', 'Escanteios', 'ChutesAGol', 'Impedimentos', 'Gols']
        X = df[feature_columns].copy()
        y = df['Resultado'].copy()

        # CORREÇÃO: Renomear coluna para corresponder ao que o modelo espera
        if 'ChutesAGol' in X.columns:
            X = X.rename(columns={'ChutesAGol': 'ChutesAgol'})
            print("✅ Coluna 'ChutesAGol' renomeada para 'ChutesAgol' para compatibilidade com o modelo")

        # Verificar se o modelo tem informação sobre as features esperadas
        expected_columns = None
        if hasattr(model, 'feature_names_in_'):
            expected_columns = model.feature_names_in_
            print(f"📋 Colunas esperadas pelo modelo: {list(expected_columns)}")
        elif hasattr(model, 'named_steps') and hasattr(model.named_steps.get('preprocessor', None),
                                                       'feature_names_in_'):
            expected_columns = model.named_steps['preprocessor'].feature_names_in_
            print(f"📋 Colunas esperadas pelo modelo (do preprocessor): {list(expected_columns)}")
        else:
            print("⚠️  Não foi possível determinar as colunas esperadas pelo modelo")

        # Se conhecemos as colunas esperadas, garantir que temos exatamente essas colunas
        if expected_columns is not None:
            # Verificar se todas as colunas esperadas estão presentes
            missing_cols = set(expected_columns) - set(X.columns)
            if missing_cols:
                print(f"❌ Colunas faltando: {missing_cols}")
                # Tentar mapeamentos comuns
                column_mappings = {
                    'ChutesAgol': 'ChutesAGol',  # Caso contrário
                    'ChutesAGol': 'ChutesAgol'  # Caso principal
                }

                for missing_col in missing_cols:
                    if missing_col in column_mappings and column_mappings[missing_col] in df.columns:
                        X[missing_col] = df[column_mappings[missing_col]]
                        print(f"✅ Mapeado {column_mappings[missing_col]} -> {missing_col}")

            # Reordenar colunas para corresponder exatamente ao modelo
            X = X.reindex(columns=expected_columns, fill_value=0)
            print(f"✅ Colunas reordenadas para corresponder ao modelo: {X.columns.tolist()}")

        print(f"Formato original dos dados:")
        print(f"X shape: {X.shape}")
        print(f"Colunas X: {X.columns.tolist()}")
        print(f"Tipos de dados em X:\n{X.dtypes}")
        print(f"y valores únicos: {y.unique()}")

        # Verificar se há valores NaN
        print(f"\nValores NaN em X:\n{X.isnull().sum()}")
        print(f"Valores NaN em y: {y.isnull().sum()}")

        # Remover linhas com valores NaN
        mask = ~(X.isnull().any(axis=1) | y.isnull())
        X_clean = X[mask].copy()
        y_clean = y[mask].copy()

        print(f"\nApós limpeza:")
        print(f"X_clean shape: {X_clean.shape}")
        print(f"y_clean shape: {y_clean.shape}")

        # Preparar features para o modelo
        X_processed = X_clean.copy()

        # Codificar variáveis categóricas
        le_time = LabelEncoder()
        X_processed['NomeTime'] = le_time.fit_transform(X_processed['NomeTime'].astype(str))

        # CORREÇÃO CRÍTICA: Converter todos os tipos para float64 para evitar problemas de tipos mistos
        for col in X_processed.columns:
            X_processed[col] = pd.to_numeric(X_processed[col], errors='coerce').astype(np.float64)

        # Verificar se há NaN após conversão
        if X_processed.isnull().any().any():
            print("⚠️ Valores NaN detectados após conversão numérica:")
            print(X_processed.isnull().sum())
            X_processed = X_processed.fillna(0)
            print("✅ Valores NaN preenchidos com 0")

        # Codificar target se necessário
        le_target = LabelEncoder()
        y_processed = le_target.fit_transform(y_clean.astype(str))

        print(f"\nApós processamento:")
        print(f"X_processed dtypes:\n{X_processed.dtypes}")
        print(f"X_processed shape: {X_processed.shape}")
        print(f"y_processed shape: {y_processed.shape}")
        print(f"y_processed valores únicos: {np.unique(y_processed)}")

        # Verificar se os dados estão prontos para predição
        print("✅ Todos os dados convertidos para float64, prosseguindo com predição...")

        # ADICIONAR: Verificação extra de compatibilidade
        print(f"📊 Estatísticas dos dados processados:")
        print(f"X_processed info:\n{X_processed.info()}")
        print(f"Amostra dos dados:\n{X_processed.head()}")

        try:
            # Fazer predições
            print("🔮 Iniciando predição...")

            # ADICIONAR: Verificação de compatibilidade final antes da predição
            print(f"🔍 Verificação final de compatibilidade:")
            print(f"   Modelo espera {getattr(model, 'n_features_in_', 'N/A')} features")
            print(f"   Dados têm {X_processed.shape[1]} features")
            print(f"   Tipos de dados: {X_processed.dtypes.tolist()}")
            print(f"   Valores únicos por coluna:")
            for col in X_processed.columns:
                unique_vals = X_processed[col].unique()
                print(
                    f"     {col}: {len(unique_vals)} valores únicos (range: {unique_vals.min():.2f} - {unique_vals.max():.2f})")

            # Tentar predição com verificação de array
            X_array = X_processed.values
            print(f"   Array shape: {X_array.shape}, dtype: {X_array.dtype}")

            # Verificar se há infinitos ou valores muito grandes
            if np.any(np.isinf(X_array)):
                print("⚠️ Valores infinitos detectados, substituindo...")
                X_array = np.nan_to_num(X_array, posinf=999999, neginf=-999999)

            if np.any(np.abs(X_array) > 1e10):
                print("⚠️ Valores muito grandes detectados, normalizando...")
                X_array = np.clip(X_array, -1e6, 1e6)

            y_pred = model.predict(X_array)
            prediction_method = "Modelo Real"

            print(f"✅ Predições realizadas com sucesso!")
            print(f"y_pred shape: {y_pred.shape}")
            print(f"y_pred valores únicos: {np.unique(y_pred)}")
            print(f"y_pred tipo: {type(y_pred[0])}")

        except Exception as pred_error:
            print(f"❌ Erro específico na predição: {pred_error}")
            print(f"Tipo do erro: {type(pred_error)}")

            # Diagnóstico mais detalhado
            print(f"\n🔍 DIAGNÓSTICO DETALHADO:")
            print(f"   Modelo: {type(model)}")
            print(f"   X_processed info:")
            print(X_processed.info())
            print(f"   Primeiras linhas dos dados:")
            print(X_processed.head())

            # Tentar diagnóstico mais específico
            try:
                print("🔍 Testando predição com uma amostra...")
                sample_data = X_processed.iloc[:1].values.astype(np.float64)
                print(f"   Sample shape: {sample_data.shape}, dtype: {sample_data.dtype}")
                print(f"   Sample values: {sample_data}")

                sample_pred = model.predict(sample_data)
                print(f"✅ Predição de amostra funcionou: {sample_pred}")

                # Se amostra funciona, problema pode ser com batch size
                print("🔄 Tentando predição em lotes menores...")
                y_pred_list = []
                batch_size = 10
                for i in range(0, len(X_processed), batch_size):
                    batch = X_processed.iloc[i:i + batch_size].values.astype(np.float64)
                    batch_pred = model.predict(batch)
                    y_pred_list.extend(batch_pred)

                y_pred = np.array(y_pred_list)
                prediction_method = "Modelo Real (em lotes)"
                print(f"✅ Predições em lotes realizadas com sucesso!")
                print(f"y_pred shape: {y_pred.shape}")
                print(f"y_pred valores únicos: {np.unique(y_pred)}")

            except Exception as batch_error:
                print(f"❌ Erro também na predição em lotes: {batch_error}")

                # Último recurso: verificar se é problema do pipeline
                if hasattr(model, 'named_steps'):
                    print("🔍 Modelo é um pipeline, tentando diagnóstico por etapas...")
                    try:
                        # Testar preprocessor separadamente
                        if 'preprocessor' in model.named_steps:
                            print("   Testando preprocessor...")
                            X_transformed = model.named_steps['preprocessor'].transform(X_processed.iloc[:5])
                            print(f"   Preprocessor OK: {X_transformed.shape}")

                        # Testar classifier separadamente
                        if 'classifier' in model.named_steps:
                            print("   Testando classifier...")
                            # Se preprocessor funcionou, usar dados transformados
                            test_pred = model.named_steps['classifier'].predict(X_transformed)
                            print(f"   Classifier OK: {test_pred}")

                    except Exception as pipeline_error:
                        print(f"   Erro no pipeline: {pipeline_error}")

                raise pred_error  # Re-raise erro original

        # Converter predições de volta para labels originais se necessário
        if hasattr(le_target, 'inverse_transform'):
            try:
                y_pred_labels = le_target.inverse_transform(y_pred)
                y_true_labels = le_target.inverse_transform(y_processed)
            except:
                y_pred_labels = y_pred
                y_true_labels = y_processed
        else:
            y_pred_labels = y_pred
            y_true_labels = y_processed

        # Create confusion matrix
        cm = confusion_matrix(y_true_labels, y_pred_labels)

        # Plot confusion matrix
        plt.figure(figsize=(10, 8))
        classes = sorted(np.unique(y_true_labels))

        # Normalizar matriz de confusão
        cm_normalized = cm.astype('float') / cm.sum(axis=1)[:, np.newaxis]
        cm_normalized = np.nan_to_num(cm_normalized)  # Substituir NaN por 0

        sns.heatmap(cm_normalized, annot=cm, fmt='d', cmap='Blues',
                    xticklabels=classes, yticklabels=classes)
        plt.xlabel('Predicted')
        plt.ylabel('Actual')
        plt.title(f'Confusion Matrix - {model_name}\n(Método: {prediction_method})')

        # Calcular e mostrar accuracy
        accuracy = accuracy_score(y_true_labels, y_pred_labels)
        plt.figtext(0.02, 0.02, f'Accuracy: {accuracy:.3f}', fontsize=12,
                    bbox=dict(boxstyle="round,pad=0.3", facecolor="lightblue"))

        plt.tight_layout()
        plt.savefig('confusion_matrix.png', dpi=300, bbox_inches='tight')
        print("Confusion matrix saved as 'confusion_matrix.png'")

        # Relatório de classificação
        print(f"\n📊 RELATÓRIO DE CLASSIFICAÇÃO:")
        print(f"Accuracy: {accuracy:.3f}")
        try:
            report = classification_report(y_true_labels, y_pred_labels)
            print(report)
        except Exception as e:
            print(f"Não foi possível gerar relatório detalhado: {e}")

        # Feature importance para Random Forest
        if model_name == "Random Forest":
            try:
                # Tentar extrair importâncias das features
                if hasattr(model, 'feature_importances_'):
                    importances = model.feature_importances_
                    # Usar os nomes das colunas após o renomeamento
                    feature_names = ['NomeTime', 'PosseDeBola', 'Escanteios', 'ChutesAgol', 'Impedimentos', 'Gols']
                elif hasattr(model, 'named_steps') and 'classifier' in model.named_steps:
                    importances = model.named_steps['classifier'].feature_importances_
                    feature_names = ['NomeTime', 'PosseDeBola', 'Escanteios', 'ChutesAgol', 'Impedimentos', 'Gols']
                else:
                    raise AttributeError("Não foi possível encontrar feature_importances_")

                indices = np.argsort(importances)[::-1]

                # Plot feature importance
                plt.figure(figsize=(12, 8))
                plt.title('Feature Importances - Random Forest')
                bars = plt.bar(range(len(indices)), importances[indices],
                               color='skyblue', edgecolor='navy', alpha=0.7)
                plt.xticks(range(len(indices)), [feature_names[i] for i in indices],
                           rotation=45, ha='right')
                plt.ylabel('Importance Score')
                plt.xlabel('Features')

                # Adicionar valores nas barras
                for i, v in enumerate(importances[indices]):
                    plt.text(i, v + 0.005, f'{v:.3f}', ha='center', va='bottom', fontsize=9)

                plt.tight_layout()
                plt.savefig('feature_importances.png', dpi=300, bbox_inches='tight')
                print("Feature importances saved as 'feature_importances.png'")

            except Exception as e:
                print(f"Não foi possível gerar gráfico de feature importance: {e}")

        # Gerar distribuição de predições
        plt.figure(figsize=(10, 6))
        pred_counts = pd.Series(y_pred_labels).value_counts()
        colors = ['#2ca02c' if 'vitoria' in str(x).lower() else '#d62728' if 'derrota' in str(x).lower() else '#1f77b4'
                  for x in pred_counts.index]
        pred_counts.plot(kind='bar', color=colors, edgecolor='black', alpha=0.8)
        plt.title(f'Distribution of Predictions by {model_name}')
        plt.xlabel('Predicted Result')
        plt.ylabel('Count')
        plt.xticks(rotation=45)
        for i, v in enumerate(pred_counts):
            plt.text(i, v + 0.5, str(v), ha='center', va='bottom', fontweight='bold')
        plt.tight_layout()
        plt.savefig('prediction_distribution.png', dpi=300)
        print("Prediction distribution saved as 'prediction_distribution.png'")

    except Exception as e:
        print(f"Erro durante predição com modelo real: {e}")
        print("Realizando apenas análise exploratória sem predições...")
        model = None  # Definir como None para pular predições

# Se não há modelo, fazer apenas análise exploratória
if model is None:
    print("\n=== REALIZANDO APENAS ANÁLISE EXPLORATÓRIA ===")

    # Gerar matriz de confusão simulada baseada nos dados reais
    plt.figure(figsize=(10, 8))

    # Split simples para simular train/test
    X_simple = df[['PosseDeBola', 'Escanteios', 'ChutesAGol', 'Impedimentos', 'Gols']]
    y_simple = df['Resultado']


    # Usar uma regra simples baseada em gols para "predição"
    def simple_prediction_rule(row):
        if row['Gols'] >= 2:
            return 'vitoria'
        elif row['Gols'] == 1:
            return 'empate'
        else:
            return 'derrota'


    y_pred_simple = X_simple.apply(simple_prediction_rule, axis=1)

    # Ajustar predições para corresponder aos valores reais do dataset
    unique_results = y_simple.unique()
    mapping = {}
    for i, result in enumerate(['vitoria', 'empate', 'derrota']):
        if result in unique_results:
            mapping[result] = result
        elif result.upper() in unique_results:
            mapping[result] = result.upper()
        elif len(unique_results) > i:
            mapping[result] = unique_results[i]

    y_pred_mapped = y_pred_simple.map(mapping).fillna(unique_results[0])

    cm = confusion_matrix(y_simple, y_pred_mapped)

    classes = sorted(unique_results)
    cm_normalized = cm.astype('float') / cm.sum(axis=1)[:, np.newaxis]
    cm_normalized = np.nan_to_num(cm_normalized)

    sns.heatmap(cm_normalized, annot=cm, fmt='d', cmap='Blues',
                xticklabels=classes, yticklabels=classes)
    plt.xlabel('Predicted')
    plt.ylabel('Actual')
    plt.title('Análise Exploratória - Regra Baseada em Gols')

    accuracy_simple = accuracy_score(y_simple, y_pred_mapped)
    plt.figtext(0.02, 0.02, f'Accuracy (Regra Simples): {accuracy_simple:.3f}', fontsize=12,
                bbox=dict(boxstyle="round,pad=0.3", facecolor="lightgreen"))

    plt.tight_layout()
    plt.savefig('confusion_matrix.png', dpi=300, bbox_inches='tight')
    print("Exploratory analysis confusion matrix saved as 'confusion_matrix.png'")

    # Distribuição de predições da regra simples
    plt.figure(figsize=(10, 6))
    pred_counts = pd.Series(y_pred_mapped).value_counts()
    colors = ['#2ca02c' if 'vitoria' in str(x).lower() else '#d62728' if 'derrota' in str(x).lower() else '#1f77b4'
              for x in pred_counts.index]
    pred_counts.plot(kind='bar', color=colors, edgecolor='black', alpha=0.8)
    plt.title('Distribution of Predictions (Simple Rule: Goals-based)')
    plt.xlabel('Predicted Result')
    plt.ylabel('Count')
    plt.xticks(rotation=45)
    for i, v in enumerate(pred_counts):
        plt.text(i, v + 0.5, str(v), ha='center', va='bottom', fontweight='bold')
    plt.tight_layout()
    plt.savefig('prediction_distribution.png', dpi=300, bbox_inches='tight')
    print("Simple rule prediction distribution saved as 'prediction_distribution.png'")

# Continuar com o resto das análises (estatísticas dos times, etc.)
print("\n=== GERANDO ESTATÍSTICAS DOS TIMES ===")

# Create team statistics
team_stats = pd.DataFrame()
result_values = df['Resultado'].unique()

for team in df['NomeTime'].unique():
    team_df = df[df['NomeTime'] == team]

    # Contar resultados
    victories = len(team_df[team_df['Resultado'].str.lower().str.contains('vitoria', na=False)])
    draws = len(team_df[team_df['Resultado'].str.lower().str.contains('empate', na=False)])
    defeats = len(team_df[team_df['Resultado'].str.lower().str.contains('derrota', na=False)])

    # Calcular gols
    goals_scored = team_df['Gols'].astype(int).sum()

    stats = {
        'Team': team,
        'Games': len(team_df),
        'Victories': victories,
        'Draws': draws,
        'Defeats': defeats,
        'Goals_Scored': goals_scored,
        'Avg_Possession': team_df['PosseDeBola'].mean(),
        'Avg_Corners': team_df['Escanteios'].mean(),
        'Avg_Shots': team_df['ChutesAGol'].mean(),
        'Win_Rate': (victories / len(team_df) * 100) if len(team_df) > 0 else 0
    }

    team_stats = pd.concat([team_stats, pd.DataFrame([stats])], ignore_index=True)

# Sort by win rate
team_stats = team_stats.sort_values('Win_Rate', ascending=False)

# Save team statistics
team_stats.to_csv('team_statistics.csv', index=False)
print("Team statistics saved as 'team_statistics.csv'")

# Create factor statistics
factors = ['PosseDeBola', 'Escanteios', 'ChutesAGol', 'Impedimentos', 'Gols']
factor_stats = pd.DataFrame()

for factor in factors:
    for value in df[factor].unique():
        for result in df['Resultado'].unique():
            matches = len(df[(df[factor] == value) & (df['Resultado'] == result)])
            total = len(df[df[factor] == value])
            percentage = (matches / total * 100) if total > 0 else 0

            stat = {
                'Factor': factor,
                'Value': value,
                'Result': result,
                'Count': matches,
                'Total': total,
                'Percentage': round(percentage, 2)
            }

            factor_stats = pd.concat([factor_stats, pd.DataFrame([stat])], ignore_index=True)

# Save factor statistics
factor_stats.to_csv('factor_statistics.csv', index=False)
print("Factor statistics saved as 'factor_statistics.csv'")

# Gerar visualizações extras
print("\n=== GERANDO VISUALIZAÇÕES EXTRAS ===")

# 1. Análise de Correlação
plt.figure(figsize=(12, 10))
numeric_df = df.select_dtypes(include=[np.number])
if len(numeric_df.columns) > 1:
    correlation_matrix = numeric_df.corr()
    sns.heatmap(correlation_matrix, annot=True, cmap='RdYlBu_r', center=0,
                square=True, linewidths=0.5, cbar_kws={"shrink": .8})
    plt.title('Matriz de Correlação entre Variáveis Numéricas', fontsize=16, pad=20)
    plt.tight_layout()
    plt.savefig('correlation_matrix.png', dpi=300, bbox_inches='tight')
    print("Correlation matrix saved as 'correlation_matrix.png'")

# 2. Análise de Performance por Posse de Bola
plt.figure(figsize=(14, 8))
# Criar faixas de posse de bola
df['Faixa_Posse'] = pd.cut(df['PosseDeBola'], bins=[0, 40, 50, 60, 100],
                           labels=['0-40%', '41-50%', '51-60%', '61-100%'])
possession_performance = pd.crosstab(df['Faixa_Posse'], df['Resultado'], normalize='index') * 100
possession_performance.plot(kind='bar', stacked=True,
                            color=['#ff6b6b', '#feca57', '#48cae4'],
                            edgecolor='black', linewidth=0.5)
plt.title('Distribuição de Resultados por Faixa de Posse de Bola (%)', fontsize=14)
plt.xlabel('Faixa de Posse de Bola')
plt.ylabel('Percentual de Jogos (%)')
plt.legend(title='Resultado', bbox_to_anchor=(1.05, 1), loc='upper left')
plt.xticks(rotation=0)
plt.tight_layout()
plt.savefig('possession_performance.png', dpi=300, bbox_inches='tight')
print("Possession performance analysis saved as 'possession_performance.png'")

# 3. Análise de Eficiência de Chutes
plt.figure(figsize=(12, 8))
df['Eficiencia_Chutes'] = df['Gols'] / (df['ChutesAGol'] + 1)  # +1 para evitar divisão por zero
efficiency_by_team = df.groupby('NomeTime')['Eficiencia_Chutes'].mean().sort_values(ascending=False)

plt.bar(range(len(efficiency_by_team)), efficiency_by_team.values,
        color='lightseagreen', edgecolor='darkslategray', alpha=0.8)
plt.title('Eficiência de Chutes por Time (Gols/Chutes)', fontsize=14)
plt.xlabel('Times')
plt.ylabel('Eficiência (Gols por Chute)')
plt.xticks(range(len(efficiency_by_team)), efficiency_by_team.index, rotation=45, ha='right')

for i, v in enumerate(efficiency_by_team.values):
    plt.text(i, v + 0.01, f'{v:.3f}', ha='center', va='bottom', fontweight='bold')

plt.tight_layout()
plt.savefig('shooting_efficiency.png', dpi=300, bbox_inches='tight')
print("Shooting efficiency analysis saved as 'shooting_efficiency.png'")

print("\n=== ANÁLISE CONCLUÍDA ===")
print("✅ Todos os gráficos e análises foram gerados com base nos dados reais")
print("✅ Não foram utilizadas predições aleatórias")
print("✅ As visualizações refletem os padrões reais do dataset")

# Salvar resumo final
summary = {
    'Total_Games': len(df),
    'Total_Teams': df['NomeTime'].nunique(),
    'Victories': len(df[df['Resultado'].str.lower().str.contains('vitoria', na=False)]),
    'Draws': len(df[df['Resultado'].str.lower().str.contains('empate', na=False)]),
    'Defeats': len(df[df['Resultado'].str.lower().str.contains('derrota', na=False)]),
    'Total_Goals': df['Gols'].astype(int).sum(),
    'Avg_Possession': df['PosseDeBola'].mean(),
    'Model_Used': model_name
}

summary_df = pd.DataFrame([summary])
summary_df.to_csv('analysis_summary.csv', index=False)
print(f"\nResumo da análise salvo em 'analysis_summary.csv'")
print(f"Modelo utilizado: {model_name}")