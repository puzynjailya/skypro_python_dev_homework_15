
-- Обновляем индекс в таблице animals (пригодится дальше при формировании нормализованных таблиц)
-- ВНИМАНИЕ!!! ЭТО ДЕЛАЕТСЯ ТОЛЬКО ОДИН РАЗ НА СЫРОЙ БАЗЕ

-- UPDATE animals
-- SET "index" = "index" + 1;

----------------------------------------------------------------------
/* Вставляем данные в таблицу age_upon_outcome */
INSERT INTO age_upon_outcome (age)
SELECT DISTINCT age_upon_outcome FROM animals;

----------------------------------------------------------------------
/* Вставляем данные в таблицу animal_type */
INSERT INTO animal_type (animal_type)
SELECT DISTINCT animal_type FROM animals;

----------------------------------------------------------------------
/* Вставляем данные в таблицу breed_type */
INSERT INTO breed_type (breed_name)
SELECT DISTINCT breed FROM animals;

----------------------------------------------------------------------
/* Вставляем данные в таблицу colors */
INSERT INTO colors (color_name)
SELECT DISTINCT TRIM(cat_color)
FROM(
SELECT DISTINCT color1 as cat_color
FROM animals
UNION ALL
SELECT DISTINCT color2
FROM animals);

----------------------------------------------------------------------
/* Вставляем данные в таблицу outcome_month */
INSERT INTO outcome_month (month)
SELECT DISTINCT outcome_month FROM animals
ORDER BY outcome_month;

----------------------------------------------------------------------
/* Вставляем данные в таблицу outcome_year */
INSERT INTO outcome_year (year)
SELECT DISTINCT outcome_year FROM animals;

----------------------------------------------------------------------
/* Вставляем данные в таблицу outcome_type */
INSERT INTO outcome_type (type_name)
SELECT DISTINCT outcome_type FROM animals
WHERE outcome_type NOT NULL;
----------------------------------------------------------------------
/* Вставляем данные в таблицу outcome_subtype */
INSERT INTO outcome_subtype (subtype_name)
SELECT DISTINCT outcome_subtype FROM animals
WHERE outcome_subtype NOT NULL;

----------------------------------------------------------------------
/* Вставляем данные в таблицу outcome (чтобы вынести все данные по смысловой категории outcome */
INSERT INTO outcome (
            outcome_type_id,
            outcome_subtype_id,
            outcome_month_id,
            outcome_year_id)
SELECT
       outcome_type.type_id as outcome_type_id,
       outcome_subtype.subtype_id as outcome_subtype_id,
       outcome_month.month_id as outcome_month_id,
       outcome_year.year_id as outcome_year_id
FROM animals
LEFT JOIN outcome_type ON outcome_type.type_name = animals.outcome_type
LEFT JOIN outcome_subtype ON outcome_subtype.subtype_name = animals.outcome_subtype
LEFT JOIN outcome_month ON outcome_month.month = animals.outcome_month
LEFT JOIN outcome_year ON outcome_year.year = animals.outcome_year;

----------------------------------------------------------------------
/* Добавляем данные в нормализованную табицу */
INSERT INTO normalized_animals
    (
    age_id,
    animal_id,
    animal_type_id,
    name,
    breed_id,
    main_color_id,
    secondary_color_id,
    date_of_birth,
    outcome_id
    )
SELECT
        apo.age_id AS age_id,
        animal_id,
        at.type_id AS animal_type_id,
        name,
        bt.breed_id AS breed_id,
        col1.id AS main_color_id,
        col2.id AS secondary_color_id,
        date_of_birth,
        outcome.id
FROM animals
LEFT JOIN age_upon_outcome apo ON animals.age_upon_outcome = apo.age
LEFT JOIN animal_type at ON animals.animal_type = at.animal_type
LEFT JOIN breed_type bt ON animals.breed = bt.breed_name
LEFT JOIN colors as col1 ON TRIM(animals.color1) = col1.color_name
LEFT JOIN colors as col2 ON TRIM(animals.color2) = col2.color_name
LEFT JOIN outcome ON animals."index" = outcome.id;





