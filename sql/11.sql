/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */
SELECT DISTINCT (first_name || ' ' || last_name) AS "Actor Name"
FROM actor
    JOIN film_actor USING (actor_id)
    JOIN (
        SELECT film_id
        FROM film
        WHERE 'Behind the Scenes' = ANY(special_features)
    ) AS film_bts USING (film_id)
ORDER BY "Actor Name";
