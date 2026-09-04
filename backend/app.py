from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/', methods=['GET'])
def status_api():
    return jsonify({
        "status": "sucesso",
        "projeto": "CEEP+",
        "mensagem": "API do CEEP+ rodando com sucesso no servidor local!",
        "versao": "1.0.0"
    })

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
