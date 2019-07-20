## Joins
`The real power of SQL, comes from working with data from multiple tables at once.`

```sql
SELECT Language, CountryCode, Name
FROM countrylanguage
JOIN country ON (CountryCode = Code)
ORDER BY Name;
```
>returns list of languages spoken in each country