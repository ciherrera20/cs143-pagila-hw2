/*
 * Create a report that shows the total number of rentals per year and month.
 *
 * HINT:
 * The ROLLUP clause is a convenient syntactic sugar for complicated combinations of GROUP BY and UNION clauses.
 * Although we won't cover this syntax in class, there is a great tutorial at
 * <https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rollup/>.
 * The tutorial is based off of the pagila database's rental table,
 * and contains a query that almost solves this problem.
 */
SELECT
    date_part('year', rental_date) AS "Year",
    date_part('month', rental_date) AS "Month",
    count(rental_id) AS "Total Rentals"
FROM rental
GROUP BY ROLLUP("Year", "Month")
ORDER BY "Year", "Month";
