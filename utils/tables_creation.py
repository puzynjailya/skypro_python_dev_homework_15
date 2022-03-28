import sqlite3
from utils import *


def create_tables():

    FILE_PATH = '../queries/tables_creating.sql'
    DATABASE_PATH = '../static/database/animal.db'

    try:
        connection = sqlite3.connect(DATABASE_PATH)
        cursor = connection.cursor()
        print('Выполнено успешное подключение к БД')
        sql_query = get_query_from_file(FILE_PATH)

        cursor.executescript(sql_query)
        connection.close()
        print('Скрипт выполнен! Таблицы созданы!')

    except sqlite3.Error as error:
        print("Ошибка подключения к БД", error)


if __name__ == '__main__':
    create_tables()
