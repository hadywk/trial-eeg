import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
import pickle

# Load data from a CSV file into a pandas DataFrame
df = pd.read_csv('C:/Users/Owner/development/projects/test1/lib/data_eeg.csv')

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(df.iloc[:,:-1], df.iloc[:,-1], test_size=0.2, random_state=42)

# Train a random forest classifier on the training set
clf = RandomForestClassifier(n_estimators=100, random_state=42)
clf.fit(X_train, y_train)

# Evaluate the accuracy of the classifier on the testing set
y_pred = clf.predict(X_test)
acc = accuracy_score(y_test, y_pred)
print(f"Accuracy on testing set: {acc}")

# Predict the label for a new record
new_record = pd.DataFrame([[0.2, 0.3, 0.5, 0.1, 0.6, 0.8, 0.4, 0.7, 0.9, 0.2, 0.3, 0.5, 0.1, 0.6, 0.8, 0.4, 0.5]], columns=df.columns[:-1])
new_label = clf.predict(new_record)
print(f"Predicted label for new record: {new_label}")

with open('C:/Users/Owner/PycharmProjects/pythonProject2/model.pkl', 'wb') as file:
    pickle.dump(clf, file)