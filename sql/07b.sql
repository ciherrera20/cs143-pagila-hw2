/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT title
FROM film
    JOIN inventory USING (film_id)
    LEFT JOIN (
        SELECT DISTINCT inventory_id, country
        FROM rental
            JOIN customer USING (customer_id)
            JOIN address USING (address_id)
            JOIN city USING (city_id)
            JOIN country USING (country_id)
        WHERE country LIKE 'United States%'
    ) AS rented_films USING (inventory_id)
GROUP BY title
HAVING count(country) = 0
ORDER BY title;
