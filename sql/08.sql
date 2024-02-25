/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */
SELECT title
FROM (
    SELECT title, rating, UNNEST(special_features) AS feature
    FROM film
) AS film_unnested
WHERE
    rating = mpaa_rating('G') AND
    feature LIKE 'Trailers%'
ORDER BY title;
