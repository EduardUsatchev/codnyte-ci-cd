from flask import Flask, render_template

app = Flask(__name__)
name = "Eduard"

@app.route('/')
def hello_world():
    return f'Hello, World! {name}'


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)