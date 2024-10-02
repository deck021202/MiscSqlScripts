
--***********************************************************************
-- All numbers from 1 to 1,000,000
--***********************************************************************
SELECT (ones.n + (tens.n * 10) + (hundreds.n * 100) + (thousands.n * 1000) + (tenthousands.n * 10000) + (hundredthousands.n * 100000)) + 1 as [Num]
FROM  ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) ones(n)
    , ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) tens(n)
    , ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) hundreds(n)
    , ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) thousands(n)
    , ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) tenthousands(n)
    , ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) hundredthousands(n)
    order by 1

go

--***********************************************************************
-- All between two numbers 
-- ** Only positive integers between 1 and 1,000,000)
--***********************************************************************
declare @Start int = 73
declare @End int = 634
SELECT (ones.n + (tens.n * 10) + (hundreds.n * 100) + (thousands.n * 1000) + (tenthousands.n * 10000) + (hundredthousands.n * 100000)) + 1 as [Num]
FROM  ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) ones(n)
    , ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) tens(n)
    , ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) hundreds(n)
    , ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) thousands(n)
    , ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) tenthousands(n)
    , ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) hundredthousands(n)
	where (ones.n + (tens.n * 10) + (hundreds.n * 100) + (thousands.n * 1000) + (tenthousands.n * 10000) + (hundredthousands.n * 100000)) + 1 between @Start and @End
    order by 1

go




--***********************************************************************
-- All between two numbers using a nested CTE
--***********************************************************************
declare @Start int = -153;
declare @End int = 582;

with cte as 
(
    select @Start as [Num]
    union all
    select Num + 1 from cte where [Num] < @End
)
select 
[Num]
from cte 
option (maxrecursion 0);
go

