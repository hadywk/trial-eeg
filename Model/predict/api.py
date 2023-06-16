from flask import Flask, request, jsonify
import joblib
import pandas as pd
import pickle
import json
app = Flask(__name__)

# Load the trained model
with open('C:/Users/Owner/development/projects/test1/lib/model.pkl', 'rb') as f:
    model = pickle.load(f)

# Define the predict endpoint
@app.route('/predict', methods=['POST','GET'])
def predict():
    # Get the EEG data from the request body
    eeg_data = request.json['eeg_data']
    print(eeg_data[0])
    # Convert the data into a pandas DataFrame
    df = pd.DataFrame(eeg_data)

    # Make a prediction with the model
    pred = model.predict(df)

    # Return the predicted label as a JSON response
    return jsonify({'label': pred.tolist()})
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)
