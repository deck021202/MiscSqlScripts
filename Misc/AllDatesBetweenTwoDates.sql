--*************************************************************************
-- All dates between two dates
--*************************************************************************
declare @Start date = '2015-01-01';
declare @End date = '2019-12-31';

with cte as 
(
    select @Start as [Date]
    union all
    select dateadd(day, 1, [Date]) from cte where [Date] < @End
)
select 
 [Date]
from cte 
option (maxrecursion 0);

go
--*************************************************************************
-- More efficient way of getting all dates between two dates
--*************************************************************************
declare @Start date = '2015-01-01'
declare @End date = '2019-12-31'

        SELECT --ones.n + (tens.n * 10) + (hundreds.n * 100) + (thousands.n * 1000) + (tenthousands.n * 10000) --+ (hundredthousands.n * 100000)
         dateadd(day, (ones.n + (tens.n * 10) + (hundreds.n * 100) + (thousands.n * 1000) + (tenthousands.n * 10000) + (hundredthousands.n * 100000)), @Start) as [dt]
        FROM  ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) ones(n)
            cross apply ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) tens(n)
            cross apply ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) hundreds(n)
            cross apply ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) thousands(n)
            cross apply ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) tenthousands(n)
            cross apply ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) hundredthousands(n)
            where dateadd(day, (ones.n + (tens.n * 10) + (hundreds.n * 100) + (thousands.n * 1000) + (tenthousands.n * 10000) + (hundredthousands.n * 100000)), @Start) <= @End
            order by 1
go