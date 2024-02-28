/*
 * Compute the total revenue for each film.
 */
SELECT
    title,
    CASE WHEN sum(amount) IS NULL THEN 0.00 ELSE sum(amount) END AS revenue
FROM film
    LEFT JOIN inventory USING (film_id)
    LEFT JOIN rental USING (inventory_id)
    LEFT JOIN payment USING (rental_id)
GROUP BY title
ORDER BY revenue DESC;
