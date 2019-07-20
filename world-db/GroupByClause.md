## Group By Clause
`COUNT, AVG, and SUM have something in common: they all aggregate across the entire table. But what if you want to aggregate only part of a table?`

`GROUP BY allows you to separate data into groups, which can be aggregated independently of one another.`

```sql
SELECT Continent,
COUNT(*) AS Count
FROM country
GROUP BY Continent;
```
>returns the total number of countries in each continent