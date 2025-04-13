import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.model_selection import cross_validate, StratifiedKFold
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
import matplotlib.pyplot as plt

# Load the data (assuming it was saved in the previous step)
# If you're running this separately, use the parsing code from the previous script
# For demo purposes, I'll show how to load from CSV
try:
    df = pd.read_csv('C:\\Users\\Marcos\\Documents\\GitHub\\Meus Projetos\\SergipanoDataInsights\\Mineração de dados\\sergipano_processed.csv')
except:
    # If CSV not found, recreate the DataFrame from the raw data
    # (Code from previous script to parse ARFF and create df)
    # This is just a fallback and would contain the parsing code we used before
    pass

# Separate features and target
X = df.drop('Resultado', axis=1)
y = df['Resultado']

# Encode categorical features
categorical_features = X.columns.tolist()
categorical_transformer = Pipeline(steps=[
    ('onehot', OneHotEncoder(handle_unknown='ignore'))
])

preprocessor = ColumnTransformer(
    transformers=[
        ('cat', categorical_transformer, categorical_features)
    ])

# Define the classifiers
rf_classifier = Pipeline(steps=[
    ('preprocessor', preprocessor),
    ('classifier', RandomForestClassifier(random_state=42))
])

svm_classifier = Pipeline(steps=[
    ('preprocessor', preprocessor),
    ('classifier', SVC(probability=True, random_state=42))
])

# Set up cross-validation
cv = StratifiedKFold(n_splits=10, shuffle=True, random_state=42)
scoring = ['accuracy', 'precision_macro', 'recall_macro', 'f1_macro']

# Evaluate Random Forest
print("Evaluating Random Forest...")
rf_scores = cross_validate(rf_classifier, X, y, cv=cv, scoring=scoring)

# Evaluate SVM
print("Evaluating SVM...")
svm_scores = cross_validate(svm_classifier, X, y, cv=cv, scoring=scoring)

# Print results
print("\nRandom Forest Results:")
print(f"Accuracy: {rf_scores['test_accuracy'].mean():.4f} ± {rf_scores['test_accuracy'].std():.4f}")
print(f"Precision: {rf_scores['test_precision_macro'].mean():.4f} ± {rf_scores['test_precision_macro'].std():.4f}")
print(f"Recall: {rf_scores['test_recall_macro'].mean():.4f} ± {rf_scores['test_recall_macro'].std():.4f}")
print(f"F1 Score: {rf_scores['test_f1_macro'].mean():.4f} ± {rf_scores['test_f1_macro'].std():.4f}")

print("\nSVM Results:")
print(f"Accuracy: {svm_scores['test_accuracy'].mean():.4f} ± {svm_scores['test_accuracy'].std():.4f}")
print(f"Precision: {svm_scores['test_precision_macro'].mean():.4f} ± {svm_scores['test_precision_macro'].std():.4f}")
print(f"Recall: {svm_scores['test_recall_macro'].mean():.4f} ± {svm_scores['test_recall_macro'].std():.4f}")
print(f"F1 Score: {svm_scores['test_f1_macro'].mean():.4f} ± {svm_scores['test_f1_macro'].std():.4f}")

# Determine the winner based on F1 score
if rf_scores['test_f1_macro'].mean() > svm_scores['test_f1_macro'].mean():
    print("\nWinner: Random Forest")
    winner = "Random Forest"
    winner_pipeline = rf_classifier
else:
    print("\nWinner: SVM")
    winner = "SVM"
    winner_pipeline = svm_classifier

# Visualize the results
metrics = ['Accuracy', 'Precision', 'Recall', 'F1 Score']
rf_means = [rf_scores['test_accuracy'].mean(), 
            rf_scores['test_precision_macro'].mean(), 
            rf_scores['test_recall_macro'].mean(), 
            rf_scores['test_f1_macro'].mean()]
svm_means = [svm_scores['test_accuracy'].mean(), 
             svm_scores['test_precision_macro'].mean(), 
             svm_scores['test_recall_macro'].mean(), 
             svm_scores['test_f1_macro'].mean()]

x = np.arange(len(metrics))
width = 0.35

fig, ax = plt.subplots(figsize=(12, 8))
rects1 = ax.bar(x - width/2, rf_means, width, label='Random Forest')
rects2 = ax.bar(x + width/2, svm_means, width, label='SVM')

ax.set_ylabel('Scores')
ax.set_title('Model Performance Comparison')
ax.set_xticks(x)
ax.set_xticklabels(metrics)
ax.legend()

# Add value labels on bars
def autolabel(rects):
    for rect in rects:
        height = rect.get_height()
        ax.annotate(f'{height:.3f}',
                    xy=(rect.get_x() + rect.get_width() / 2, height),
                    xytext=(0, 3),  # 3 points vertical offset
                    textcoords="offset points",
                    ha='center', va='bottom')

autolabel(rects1)
autolabel(rects2)

fig.tight_layout()
plt.savefig('model_comparison.png')

# Save the winner model for later use
import joblib
winner_pipeline.fit(X, y)
joblib.dump(winner_pipeline, f'{winner.lower().replace(" ", "_")}_model.pkl')
print(f"\nWinner model saved as '{winner.lower().replace(' ', '_')}_model.pkl'")