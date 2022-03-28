from utils.utils import get_cat_info, get_json_output
from flask import Flask, jsonify

app = Flask(__name__)


@app.route('/<animal_id>')
def display_cat_info(animal_id):
    output = get_cat_info(animal_id)
    if len(output) == 0:
        return f'<h3>К сожалению котика =^_^= с ID {animal_id} не найдено. Попробуйте еще раз</h3>'
    else:
        json_output = get_json_output(output)
        return jsonify(json_output)


if __name__ == '__main__':
    app.run()

