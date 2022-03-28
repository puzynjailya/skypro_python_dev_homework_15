SELECT
       animal_id,
       name,
       auo.age AS age,
       at.animal_type AS animal_type,
       bt.breed_name AS breed,
       cl1.color_name AS color_1,
       cl2.color_name AS color_2,
       date_of_birth,
       ot.type_name AS outcome_type,
       os.subtype_name AS outcome_subtype,
       om.month AS outcome_month,
       oy.year AS outcome_year
FROM normalized_animals na
LEFT JOIN age_upon_outcome auo ON na.age_id = auo.age_id
LEFT JOIN animal_type at ON na.animal_type_id = at.type_id
LEFT JOIN breed_type bt ON na.breed_id = bt.breed_id
LEFT JOIN colors cl1 ON na.main_color_id = cl1.id
LEFT JOIN colors cl2 ON na.secondary_color_id = cl2.id
LEFT JOIN outcome ON na.outcome_id = outcome.id
LEFT JOIN outcome_type ot on outcome.outcome_type_id = ot.type_id
LEFT JOIN outcome_subtype os on outcome.outcome_subtype_id = os.subtype_id
LEFT JOIN outcome_month om on outcome.outcome_month_id = om.month_id
LEFT JOIN outcome_year oy on outcome.outcome_year_id = oy.year_id
WHERE animal_id = "parameter_for_search"