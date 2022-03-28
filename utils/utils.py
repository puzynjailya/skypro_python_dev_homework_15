import sys
import sqlite3


def get_query_from_file(path):
    """
    Функция получающая текст SQL запроса из файла SQL
    :param path: str - путь к файлу
    :return: sql_query: str - считанные данные из файла
    """
    with open(path, 'r', encoding='utf-8') as f:
        try:
            sql_query = f.read()
        except FileNotFoundError:
            print(f"Файл {path} не найден!")
            sys.exit(1)
        except OSError as error:
            print(f"Ошибка OS при открытии файла {path}", error)
            sys.exit(1)
    return sql_query


def get_cat_info(animal_id):
    """
    Функция получения данных о котэ из нормализованной базы
    :param animal_id: str - значение animal_id для поиска
    :return: output: tuple - кортеж значений
    """
    FILE_PATH = './queries/animal_info.sql'
    DATABASE_PATH = './static/database/animal.db'

    # Подготавливаем скрипт SQL
    # 1. Открываем файл
    sql_query = get_query_from_file(FILE_PATH)
    # 2. Заменяем в нем параметр для поиска
    sql_query = sql_query.replace('parameter_for_search', animal_id)

    # Подключаемся к базе
    try:
        connection = sqlite3.connect(DATABASE_PATH)
        cursor = connection.cursor()
        cursor.execute(sql_query)

        # Получаем данные по запросу
        output = cursor.fetchall()

        connection.close()
        return output

    except sqlite3.Error as error:
        print("Ошибка подключения к БД", error)


def get_json_output(sql_output):
    """
    Функция преобразования данных из запроса к словарю
    :param sql_output: полученный кортеж с данными после sql запроса
    :return: json_output: dict - словарь с данными
    """
    json_output = []
    for result in sql_output:
        data = {"animal_id": result[0],
                "name": result[1],
                "age": result[2],
                "animal_type": result[3],
                "breed": result[4],
                "main_color": result[5],
                "secondary_color": result[6],
                "outcome_type": result[7],
                "outcome_subtype": result[8],
                "outcome_month": result[9],
                "outcome_age": result[10]
                }
        json_output.append(data)

    return json_output
