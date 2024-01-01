from flask import Flask, request, jsonify

app = Flask(__name__)

logging.getLogger('werkzeug').setLevel(logging.WARNING)


@app.route('/echo/', methods=['POST'])
def echo():
    # Echo back the received data
    data = request.json
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
