# app.py
import joblib
import pandas as pd
from flask import Flask, request, jsonify
import logging

app = Flask(__name__)

# # Set up basic configuration for logging
# logging.basicConfig(filename='app.log', level=logging.DEBUG,
#                     format='%(asctime)s %(levelname)s %(name)s %(threadName)s : %(message)s')

# logger = logging.getLogger(__name__)

# Load the model
df = pd.read_csv('salaries.csv')
model = joblib.load('model.pkl')
column_names = ["work_year","experience_level","employment_type","job_title","salary_currency","employee_residence","remote_ratio","company_location","company_size"]

experience_level_list = list(set(df.experience_level.values.tolist()))
employment_type_list = list(set(df.employment_type.values.tolist()))
job_title_list = list(set(df.job_title.values.tolist()))
salary_currency_list = list(set(df.salary_currency.values.tolist()))
employee_residence_list = list(set(df.employee_residence.values.tolist()))
company_location_list = list(set(df.company_location.values.tolist()))
company_size_list = list(set(df.company_size.values.tolist()))

@app.route('/experience_level')
def experience_level():
    return jsonify({"experience_level_list": experience_level_list})
    
@app.route('/employment_type')
def employment_type():
    return jsonify({"employment_type_list": employment_type_list})
    
@app.route('/job_title')
def job_title():
    return jsonify({"job_title_list": job_title_list})
 
@app.route('/salary_currency')
def salary_currency():
    return jsonify({"salary_currency_list": salary_currency_list})
    
@app.route('/employee_residence')
def employee_residence():
    return jsonify({"employee_residence_list": employee_residence_list})
    
@app.route('/company_location')
def company_location():
    return jsonify({"company_location_list": company_location_list})
    
@app.route('/company_size')
def company_size():
    return jsonify({"company_size_list": company_size_list})

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json
    input_data = pd.DataFrame([data['features']], columns=column_names)
    prediction = model.predict(input_data)
    # logger.info(f"features = {input_data.values}, prediction = {prediction.tolist()[0]}")
    print(f"features = {input_data.values}, prediction = {prediction.tolist()[0]}")
    return jsonify({'prediction': prediction.tolist()[0]})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)