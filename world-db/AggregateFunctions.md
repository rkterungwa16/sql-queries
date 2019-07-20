## Aggregate Functions
`COUNT() function returns the number of rows in a particular column.
 COUNT simply counts the total number of non-null rows, not the distinct values.
`
```sql
SELECT * FROM world
```
>returns the total number of countries in the world

`SUM() function returns the total sum of a numeric values of a column.`
```sql
SELECT SUM(population) FROM world
```
>returns total of world population

`AVG() function returns the average value of a numeric column.`
```sql
SELECT continent,
AVG(population)
FROM country
GROUP BY continent;
```
>returns average populations for each continent

`MAX()/MIN() function returns the largest or lowest value in a column`

```sql
SELECT name, population FROM country WHERE population = (SELECT MAX(Population) FROM country);
```
>Find the country with largest population in the world

```sql
SELECT name, population
FROM country
WHERE population IN (
    SELECT MAX(Population)
    FROM country
    GROUP BY continent);
```
>Find the countries with the largest population in each continent