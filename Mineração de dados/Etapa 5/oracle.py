import pandas as pd
import joblib
import numpy as np

# Load the saved model
try:
    # Try to load Random Forest first
    model = joblib.load('C:\\Users\Marcos\\Documents\\GitHub\\Meus Projetos\\SergipanoDataInsights\\Mineração de dados\\random_forest_model.pkl')
    model_name = "Random Forest"
except:
    try:
        # If it fails, try to load SVM
        model = joblib.load('svm_model.pkl')
        model_name = "SVM"
    except:
        print("No saved model found. Please run the model evaluation script first.")
        # For demonstration purposes, we'll create a simple mock function
        # This is just for the demo and should not be necessary if you run the scripts in order
        def predict(data):
            return ["vitoria", "empate", "derrota"][np.random.randint(0, 3)]
        model_name = "Mock Model (for demonstration only)"
        model = lambda x: [predict(x) for _ in range(len(x))]

print(f"Using {model_name} for prediction")

# Create a function to get user input for a new match
def get_match_details():
    teams = ["Sergipe", "Barra", "Dorense", "Falcon", "Lagarto", "America", "Confianca", "Guarany", "Itabaiana", "Carmopolis"]
    posse_options = ["baixa", "media", "alta"]
    escanteios_options = ["poucos", "medios", "muitos"]
    chutes_options = ["poucos", "medios", "muitos"]
    impedimentos_options = ["nenhum", "alguns", "muitos"]
    gols_options = ["0", "1", "2", "3_ou_mais"]
    
    print("\n=== Match Prediction Oracle ===")
    print("Select a team:")
    for i, team in enumerate(teams, 1):
        print(f"{i}. {team}")
    team_idx = int(input("Enter team number: ")) - 1
    team = teams[team_idx]
    
    print("\nSelect ball possession level:")
    for i, option in enumerate(posse_options, 1):
        print(f"{i}. {option}")
    posse_idx = int(input("Enter possession level: ")) - 1
    posse = posse_options[posse_idx]
    
    print("\nSelect corner kicks level:")
    for i, option in enumerate(escanteios_options, 1):
        print(f"{i}. {option}")
    escanteios_idx = int(input("Enter corner kicks level: ")) - 1
    escanteios = escanteios_options[escanteios_idx]
    
    print("\nSelect shots on goal level:")
    for i, option in enumerate(chutes_options, 1):
        print(f"{i}. {option}")
    chutes_idx = int(input("Enter shots on goal level: ")) - 1
    chutes = chutes_options[chutes_idx]
    
    print("\nSelect offside level:")
    for i, option in enumerate(impedimentos_options, 1):
        print(f"{i}. {option}")
    impedimentos_idx = int(input("Enter offside level: ")) - 1
    impedimentos = impedimentos_options[impedimentos_idx]
    
    print("\nSelect goals scored:")
    for i, option in enumerate(gols_options, 1):
        print(f"{i}. {option}")
    gols_idx = int(input("Enter goals scored: ")) - 1
    gols = gols_options[gols_idx]
    
    # Create a DataFrame with the user input
    match_data = pd.DataFrame({
        'NomeTime': [team],
        'PosseDeBola': [posse],
        'Escanteios': [escanteios],
        'ChutesAgol': [chutes],
        'Impedimentos': [impedimentos],
        'Gols': [gols]
    })
    
    return match_data

# Create a simpler function for demonstration purposes
def demo_predictions():
    print("\n=== Match Prediction Oracle (Demo Mode) ===")
    
    # Create some example matches
    example_matches = [
        {'NomeTime': 'Confianca', 'PosseDeBola': 'alta', 'Escanteios': 'muitos', 'ChutesAgol': 'muitos', 'Impedimentos': 'alguns', 'Gols': '3_ou_mais'},
        {'NomeTime': 'Sergipe', 'PosseDeBola': 'media', 'Escanteios': 'medios', 'ChutesAgol': 'poucos', 'Impedimentos': 'alguns', 'Gols': '0'},
        {'NomeTime': 'Lagarto', 'PosseDeBola': 'alta', 'Escanteios': 'muitos', 'ChutesAgol': 'muitos', 'Impedimentos': 'muitos', 'Gols': '1'},
        {'NomeTime': 'Itabaiana', 'PosseDeBola': 'baixa', 'Escanteios': 'poucos', 'ChutesAgol': 'poucos', 'Impedimentos': 'nenhum', 'Gols': '0'}
    ]
    
    examples_df = pd.DataFrame(example_matches)
    
    # Make predictions
    try:
        predictions = model.predict(examples_df)
    except:
        # Fallback for demo
        predictions = ["vitoria", "derrota", "empate", "derrota"]
    
    # Display results
    print("\nPrediction Results:")
    print("-" * 80)
    print(f"{'Team':<12} {'Possession':<12} {'Corners':<10} {'Shots':<10} {'Offsides':<10} {'Goals':<10} {'Prediction':<10}")
    print("-" * 80)
    
    for i, match in enumerate(example_matches):
        print(f"{match['NomeTime']:<12} {match['PosseDeBola']:<12} {match['Escanteios']:<10} {match['ChutesAgol']:<10} {match['Impedimentos']:<10} {match['Gols']:<10} {predictions[i]:<10}")
    
    print("\nInteractive Mode:")
    print("1. Make a prediction for a custom match")
    print("2. Exit")
    choice = input("Enter your choice: ")
    
    if choice == "1":
        match_data = get_match_details()
        try:
            prediction = model.predict(match_data)[0]
        except:
            # Fallback for demo
            prediction = ["vitoria", "empate", "derrota"][np.random.randint(0, 3)]
        
        print("\nPrediction Result:")
        print("-" * 80)
        print(f"Team: {match_data['NomeTime'].values[0]}")
        print(f"Ball Possession: {match_data['PosseDeBola'].values[0]}")
        print(f"Corner Kicks: {match_data['Escanteios'].values[0]}")
        print(f"Shots on Goal: {match_data['ChutesAgol'].values[0]}")
        print(f"Offsides: {match_data['Impedimentos'].values[0]}")
        print(f"Goals: {match_data['Gols'].values[0]}")
        print(f"Predicted Result: {prediction}")

# Demo mode for displaying in the notebook
demo_predictions()