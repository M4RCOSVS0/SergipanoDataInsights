import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import joblib
from sklearn.metrics import confusion_matrix

# Load the saved model and data
try:
    # Try to load the dataset
    df = pd.read_csv('C:\\Users\\Marcos\\Documents\\GitHub\\Meus Projetos\\SergipanoDataInsights\\Mineração de dados\\sergipano_processed.csv')
except:
    # If loading fails, recreate the dataset from raw data
    # (This would include the parsing code from the first script)
    print("Error: Dataset not found")

try:
    # Try to load the model
    model = joblib.load('C:\\Users\\Marcos\\Documents\\GitHub\\Meus Projetos\\SergipanoDataInsights\\Mineração de dados\\random_forest_model.pkl')
    model_name = "Random Forest"
except:
    try:
        model = joblib.load('svm_model.pkl')
        model_name = "SVM"
    except:
        print("Error: Model not found")
        # This is just for demonstration purposes
        model_name = "Mock Model"

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
result_counts.plot(kind='bar', ax=ax1, color=['#2ca02c', '#d62728', '#1f77b4'])
ax1.set_title('Distribution of Match Results')
ax1.set_ylabel('Count')
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
team_results['Win_Rate'] = (team_results['vitoria'] / team_results['Total'] * 100).round(2)
team_results = team_results.sort_values('Win_Rate', ascending=False)

# Plot the win rates
team_results['Win_Rate'].plot(kind='bar', ax=ax3, color='#2ca02c')
ax3.set_title('Team Win Rates')
ax3.set_xlabel('Team')
ax3.set_ylabel('Win Rate (%)')
for i, v in enumerate(team_results['Win_Rate']):
    ax3.text(i, v + 1, f"{v}%", ha='center')

# 4. Factors influencing victories
ax4 = plt.subplot2grid((3, 3), (2, 0))
victory_by_possession = df[df['Resultado'] == 'vitoria']['PosseDeBola'].value_counts()
victory_by_possession.plot(kind='pie', ax=ax4, autopct='%1.1f%%', startangle=90, colors=sns.color_palette("Blues"))
ax4.set_title('Ball Possession in Victories')
ax4.set_ylabel('')

# 5. Corner kicks in victories
ax5 = plt.subplot2grid((3, 3), (2, 1))
victory_by_corners = df[df['Resultado'] == 'vitoria']['Escanteios'].value_counts()
victory_by_corners.plot(kind='pie', ax=ax5, autopct='%1.1f%%', startangle=90, colors=sns.color_palette("Greens"))
ax5.set_title('Corner Kicks in Victories')
ax5.set_ylabel('')

# 6. Shots on goal in victories
ax6 = plt.subplot2grid((3, 3), (2, 2))
victory_by_shots = df[df['Resultado'] == 'vitoria']['ChutesAgol'].value_counts()
victory_by_shots.plot(kind='pie', ax=ax6, autopct='%1.1f%%', startangle=90, colors=sns.color_palette("Reds"))
ax6.set_title('Shots on Goal in Victories')
ax6.set_ylabel('')

# Adjust layout
plt.tight_layout(rect=[0, 0.03, 1, 0.95])

# Save the dashboard
plt.savefig('sergipano_championship_dashboard.png', dpi=300, bbox_inches='tight')
print("Dashboard saved as 'sergipano_championship_dashboard.png'")

# Create a model evaluation visualization
if 'model' in locals():
    try:
        # Separate features and target
        X = df.drop('Resultado', axis=1)
        y = df['Resultado']

        # Make predictions
        y_pred = model.predict(X)

        # Create confusion matrix
        cm = confusion_matrix(y, y_pred)

        # Plot confusion matrix
        plt.figure(figsize=(10, 8))
        classes = ['derrota', 'empate', 'vitoria']
        cm_normalized = cm.astype('float') / cm.sum(axis=1)[:, np.newaxis]

        sns.heatmap(cm_normalized, annot=cm, fmt='d', cmap='Blues',
                    xticklabels=classes, yticklabels=classes)
        plt.xlabel('Predicted')
        plt.ylabel('Actual')
        plt.title(f'Confusion Matrix - {model_name}')
        plt.tight_layout()
        plt.savefig('confusion_matrix.png', dpi=300)
        print("Confusion matrix saved as 'confusion_matrix.png'")

        # Feature importance if using Random Forest
        if model_name == "Random Forest":
            try:
                # Extract the random forest classifier from the pipeline
                rf_classifier = model.named_steps['classifier']

                # Get feature names after one-hot encoding
                preprocessor = model.named_steps['preprocessor']
                cat_features = preprocessor.transformers_[0][2]
                encoder = preprocessor.named_transformers_['cat'].named_steps['onehot']
                feature_names = encoder.get_feature_names_out(cat_features)

                # Get feature importances
                importances = rf_classifier.feature_importances_
                indices = np.argsort(importances)[::-1]

                # Plot feature importance
                plt.figure(figsize=(12, 8))
                plt.title('Feature Importances')
                plt.bar(range(len(indices)), importances[indices], color='b', align='center')
                plt.xticks(range(len(indices)), feature_names[indices], rotation=90)
                plt.tight_layout()
                plt.savefig('feature_importances.png', dpi=300)
                print("Feature importances saved as 'feature_importances.png'")
            except Exception as e:
                print(f"Could not generate feature importance plot: {e}")

        # Generate a prediction distribution chart
        plt.figure(figsize=(10, 6))
        pd.Series(y_pred).value_counts().plot(kind='bar', color=['#d62728', '#1f77b4', '#2ca02c'])
        plt.title(f'Distribution of Predictions by {model_name}')
        plt.xlabel('Predicted Result')
        plt.ylabel('Count')
        plt.xticks(rotation=0)
        for i, v in enumerate(pd.Series(y_pred).value_counts()):
            plt.text(i, v + 0.5, str(v), ha='center')
        plt.tight_layout()
        plt.savefig('prediction_distribution.png', dpi=300)
        print("Prediction distribution saved as 'prediction_distribution.png'")

    except Exception as e:
        print(f"Error generating model visualizations: {e}")

    # Generate data for an interactive dashboard
    # This could be used with tools like Power BI, Tableau, or other BI platforms

    # Create team statistics
    team_stats = pd.DataFrame()
    for team in df['NomeTime'].unique():
        team_df = df[df['NomeTime'] == team]

        stats = {
            'Team': team,
            'Games': len(team_df),
            'Victories': len(team_df[team_df['Resultado'] == 'vitoria']),
            'Draws': len(team_df[team_df['Resultado'] == 'empate']),
            'Defeats': len(team_df[team_df['Resultado'] == 'derrota']),
            'Goals_Scored': sum([0 if g == '0' else 1 if g == '1' else 2 if g == '2' else 3 for g in team_df['Gols']]),
            'High_Possession_Games': len(team_df[team_df['PosseDeBola'] == 'alta']),
            'Win_Rate': len(team_df[team_df['Resultado'] == 'vitoria']) / len(team_df) * 100 if len(team_df) > 0 else 0
        }

        team_stats = pd.concat([team_stats, pd.DataFrame([stats])], ignore_index=True)

    # Sort by win rate
    team_stats = team_stats.sort_values('Win_Rate', ascending=False)

    # Save team statistics for BI tool
    team_stats.to_csv('team_statistics.csv', index=False)
    print("Team statistics saved as 'team_statistics.csv'")

    # Create factor statistics
    # This analyzes how different factors affect match results
    factors = ['PosseDeBola', 'Escanteios', 'ChutesAgol', 'Impedimentos', 'Gols']
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

    # Save factor statistics for BI tool
    factor_stats.to_csv('factor_statistics.csv', index=False)
    print("Factor statistics saved as 'factor_statistics.csv'")

    # Create a sample dashboard template for Power BI
    html_template = """
        <!DOCTYPE html>
        <html>
        <head>
            <title>Sergipano Championship Analysis - Power BI Template</title>
            <style>
                body { font-family: Arial, sans-serif; }
                .container { width: 90%; margin: 0 auto; }
                .header { text-align: center; padding: 20px; background-color: #f0f0f0; }
                .dashboard-section { margin-bottom: 30px; padding: 15px; border: 1px solid #ddd; }
                .title { font-size: 18px; font-weight: bold; margin-bottom: 10px; }
                .placeholder { height: 300px; background-color: #f9f9f9; display: flex; align-items: center; justify-content: center; }
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">
                    <h1>Sergipano Championship Analysis</h1>
                    <p>Powered by Machine Learning</p>
                </div>

                <div class="dashboard-section">
                    <div class="title">Match Result Distribution</div>
                    <div class="placeholder">
                        [Power BI Chart: Pie chart of match results]
                    </div>
                </div>

                <div class="dashboard-section">
                    <div class="title">Team Performance</div>
                    <div class="placeholder">
                        [Power BI Chart: Bar chart of team win rates]
                    </div>
                </div>

                <div class="dashboard-section">
                    <div class="title">Goals vs Results Analysis</div>
                    <div class="placeholder">
                        [Power BI Chart: Stacked bar chart of goals vs results]
                    </div>
                </div>

                <div class="dashboard-section">
                    <div class="title">Match Predictor</div>
                    <div class="placeholder">
                        [Power BI: Interactive match prediction tool]
                    </div>
                </div>

                <div class="dashboard-section">
                    <div class="title">Key Performance Factors</div>
                    <div class="placeholder">
                        [Power BI Chart: Heat map of factors influencing victory]
                    </div>
                </div>
            </div>
        </body>
        </html>
        """

    # Save the HTML template
    with open('power_bi_template.html', 'w') as f:
        f.write(html_template)
    print("Power BI template saved as 'power_bi_template.html'")

    print("\nAll BI visualizations and data files have been generated!")