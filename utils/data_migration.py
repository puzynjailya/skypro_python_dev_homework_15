import sqlite3
from utils import *


def migrate_data():
    FILE_PATH = '../queries/data_migration.sql'
    DATABASE_PATH = '../static/database/animal.db'

    try:
        connection = sqlite3.connect(DATABASE_PATH)
        cursor = connection.cursor()
        print('Выполнено успешное подключение к БД')
        sql_query = get_query_from_file(FILE_PATH)

        cursor.executescript(sql_query)

        # Удаляем ли исходную таблицу?
        is_drop = input('Удалить исходную таблицу animals? Введите "ДА" или "НЕТ"')
        if is_drop.upper() == "ДА":
            drop_table_query = 'DROP TABLE animals'
            cursor.execute(drop_table_query)
            print('Таблица animals была успешно удалена!')

        connection.close()
        print('Скрипт выполнен! Таблицы наполнены данными!')

    except sqlite3.Error as error:
        print("Ошибка подключения к БД", error)


if __name__ == '__main__':
    migrate_data()
