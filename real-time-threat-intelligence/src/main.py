from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return "Threat Intelligence Platform API"

@app.route('/api/data')
def get_data():
    return jsonify({"message": "Threat Intelligence Data Coming Soon"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)