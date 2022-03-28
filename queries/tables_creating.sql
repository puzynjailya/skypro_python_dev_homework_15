-- Убираем двойные значения в столбце breed
-- Добавляем уникальные значения из столбца breed по id
CREATE TABLE breed_type(
            breed_id INTEGER PRIMARY KEY AUTOINCREMENT,
            breed_name VARCHAR(50) NOT NULL
            );

----------------------------------------------------------------------
-- Убираем повторяющиеся записи возраста животного из таблицы в отдельную таблицу
CREATE TABLE age_upon_outcome(
            age_id INTEGER PRIMARY KEY AUTOINCREMENT,
            age VARCHAR(100) NOT NULL
            );

----------------------------------------------------------------------
-- Убираем тип животного в отдельную таблицу
CREATE TABLE animal_type(
            type_id INTEGER PRIMARY KEY AUTOINCREMENT,
            animal_type VARCHAR (50) NOT NULL
            );

----------------------------------------------------------------------
-- Убираем столбцы цвета, вместо них будет id
CREATE TABLE colors(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            color_name VARCHAR (100)
            CONSTRAINT DF_color DEFAULT 'Undefined'
            );

----------------------------------------------------------------------
--- Создаем таблицы с данными по текущему состоянию котэ
CREATE TABLE outcome_type(
            type_id INTEGER PRIMARY KEY AUTOINCREMENT,
            type_name VARCHAR (100)
            );

CREATE TABLE outcome_subtype(
            subtype_id INTEGER PRIMARY KEY AUTOINCREMENT,
            subtype_name VARCHAR (100)
            CONSTRAINT DF_subtype DEFAULT 'Undefined'
            );

CREATE TABLE outcome_month(
            month_id INTEGER PRIMARY KEY AUTOINCREMENT,
            month INTEGER NOT NULL
            );

CREATE TABLE outcome_year(
            year_id INTEGER PRIMARY KEY AUTOINCREMENT,
            year INTEGER NOT NULL
            );

CREATE TABLE outcome(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            outcome_type_id INTEGER,
            outcome_subtype_id INTEGER,
            outcome_month_id INTEGER NOT NULL,
            outcome_year_id INTEGER NOT NULL,
            FOREIGN KEY (outcome_type_id) REFERENCES outcome_type (type_id),
            FOREIGN KEY (outcome_subtype_id) REFERENCES outcome_subtype (subtype_id),
            FOREIGN KEY (outcome_month_id) REFERENCES outcome_month (month_id),
            FOREIGN KEY (outcome_year_id) REFERENCES outcome_year (year_id)
            );

----------------------------------------------------------------------
CREATE TABLE normalized_animals(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    age_id INTEGER NOT NULL,
    animal_id VARCHAR (10),
    animal_type_id INTEGER NOT NULL,
    name VARCHAR(50) CONSTRAINT DF_name DEFAULT 'Unnamed kitty',
    breed_id INTEGER NOT NULL,
    main_color_id INTEGER NOT NULL,
    secondary_color_id INTEGER,
    date_of_birth TEXT NOT NULL,
    outcome_id INTEGER NOT NULL,
    FOREIGN KEY (age_id) REFERENCES age_upon_outcome (age_id),
    FOREIGN KEY (animal_type_id) REFERENCES animal_type (type_id),
    FOREIGN KEY (main_color_id) REFERENCES colors (id),
    FOREIGN KEY (secondary_color_id) REFERENCES colors (id),
    FOREIGN KEY (outcome_id) REFERENCES outcome (id),
    FOREIGN KEY (breed_id) REFERENCES breed_type (breed_id)
);