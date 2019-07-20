## HAVING Clause
`Use HAVING clause when it is not enough just to know aggregated stats by column (e.g continent). You might want to put a specific condition for the type of column (MAX(Population) > 100000).`

`WHERE clause won't work for this because it doesn't allow you to filter on aggregate columns`

```sql
SELECT continent
FROM world
GROUP BY continent
HAVING sum(population) >= 100000000
```
>returns list of continents that have a total population of at least 100 million.

`Query clause order`
```sql
1. SELECT
2. FROM
3. WHERE
4. GROUP BY
5. HAVING
6. ORDER BY
```