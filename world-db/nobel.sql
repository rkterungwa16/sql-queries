-- Combining results for two queries
-- Method 1
SELECT *
FROM nobel
WHERE (subject = "Physics" AND yr = '1980') OR (subject = 'Chemistry' AND yr = 1984)

-- Method 2
SELECT *
FROM nobel 
WHERE subject='Physics' AND yr=1980
UNION
SELECT *
FROM nobel WHERE subject='Chemistry' AND yr=1984