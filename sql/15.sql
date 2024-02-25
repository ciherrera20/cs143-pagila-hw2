/*
 * Compute the total revenue for each film.
 */
SELECT title, sum(amount) AS revenue
FROM film
    JOIN inventory USING (film_id)
    JOIN rental USING (inventory_id)
    JOIN payment USING (rental_id)
GROUP BY title
UNION ALL
SELECT title, 0.00 AS revenue
FROM film
WHERE film_id NOT IN (
    SELECT film_id
    FROM inventory
)
ORDER BY revenue DESC, title;
