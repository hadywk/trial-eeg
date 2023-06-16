from flask import Flask, request, jsonify
import joblib
import pandas as pd
import pickle
import numpy as np
import json
app = Flask(__name__)

with open('C:/Users/Owner/PycharmProjects/pythonProject2/helmy/model2.pkl', 'rb') as f:
    model = pickle.load(f)

@app.route('/predict2', methods=['POST','GET'])
def predict():
    # Get the EEG data from the request body
    eeg_data = request.json['eeg_data']
    print(eeg_data[0])
    # Convert the data into a pandas DataFrame
    df = pd.DataFrame(eeg_data)

    # Make a prediction with the model
    pred = model.predict(df)
    class_labels = ['Positive', 'Neutral', 'Negative']
    predicted_class = class_labels[np.argmax(pred)]
    # Return the predicted label as a JSON response
    return jsonify({'label': predicted_class})
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8001, debug=True)