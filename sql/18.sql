/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
SELECT
    "rank",
    title,
    revenue,
    "total revenue",
    to_char(100*"total revenue"/(sum(revenue) OVER()), 'FM900.00') AS "percent revenue"
FROM (
    SELECT
        "rank",
        title,
        revenue,
        sum(revenue) OVER (ORDER BY revenue DESC) AS "total revenue"
    FROM (
        SELECT
            RANK () OVER (
                ORDER BY revenue DESC
            ) AS "rank",
            title,
            revenue
        FROM (
            SELECT
                title,
                sum(amount) AS revenue
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
        ) AS film_revenue
        ORDER BY "rank", title
    ) AS ranked_film_revenue
) AS ranked_film_total_revenue;
