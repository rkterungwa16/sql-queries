## Joins
`The real power of SQL, comes from working with data from multiple tables at once.`

```sql
SELECT Language, CountryCode, Name
FROM countrylanguage
JOIN country ON (CountryCode = Code)
ORDER BY Name;
```
>returns list of languages spoken in each country worldwide

## Inner Joins

`When performing an inner join, rows from either table that are unmatched in the other table are not returned.`

` In the example, only countries that meet up specified criteria will be displayed.`
```sql
SELECT Language, CountryCode, Name
FROM countrylanguage
JOIN country ON (CountryCode = Code AND Continent = 'Africa')
```
>return list of languages spoken in each country in Africa

```sql
SELECT Language, CountryCode, Name
FROM countrylanguage
JOIN country ON (CountryCode = Code AND Name = 'Nigeria')
ORDER BY Name;
```
>return list of languages spoken in Nigeria