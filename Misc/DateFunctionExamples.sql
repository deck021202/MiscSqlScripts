

-- Current Date/Time
select GETDATE() as [GETDATE]                 -- Milliseconds
     , SYSDATETIME() as [SYSDATETIME]         -- Microseconds
     , GETUTCDATE() as [GETUTCDATE]
     , SYSUTCDATETIME() as [SYSUTCDATETIME]
     , CURRENT_TIMESTAMP as [CURRENT_TIMESTAMP]
     , DATE_BUCKET(month, 7, getdate())  --???????????


-- Datename
select datename(year       , getdate()) as [year]        --yy,yyyy
     , datename(quarter    , getdate()) as [quarter]     --qq, q
     , datename(month      , getdate()) as [month]       --mm, m
     , datename(dayofyear  , getdate()) as [dayofyear]   --dy, y
     , datename(day        , getdate()) as [day]         --dd, d
     , datename(week       , getdate()) as [week]        -- wk, ww
     , datename(weekday    , getdate()) as [weekday]     -- dw, w
     , datename(hour       , getdate()) as [hour]        -- hh
     , datename(minute     , getdate()) as [minute]      -- mi, n
     , datename(second     , getdate()) as [second]      -- ss, s
     , datename(millisecond, getdate()) as [millisecond] -- ms
     , datename(microsecond, getdate()) as [microsecond] -- mcs
     , datename(nanosecond , getdate()) as [nanosecond]  -- ns
     , datename(ISO_WEEK   , getdate()) -- ISOWK, ISOWW
--     , datename(TZoffset   , getdate()) -- tz

-- Datepart
select
  datepart(year         , getdate()) -- yy, yyyy
, datepart(quarter      , getdate()) -- qq, q
, datepart(month        , getdate()) -- mm, m
, datepart(dayofyear    , getdate()) -- dy, y
, datepart(day          , getdate()) -- dd, d
, datepart(week         , getdate()) -- wk, ww
, datepart(weekday      , getdate()) -- dw
, datepart(hour         , getdate()) -- hh
, datepart(minute       , getdate()) -- mi, n
, datepart(second       , getdate()) -- ss, s
, datepart(millisecond  , getdate()) -- ms
, datepart(microsecond  , getdate()) -- mcs
, datepart(nanosecond   , getdate()) -- ns
, datepart(iso_week     , getdate()) -- isowk, isoww
, day(getdate())
, month(getdate())
, year(getdate())
--, datepart(tzoffset     , getdate()) -- tz


select 
  DATETRUNC(year, SYSDATETIME())        as [year]
, DATETRUNC(quarter, SYSDATETIME())     as [quarter]
, DATETRUNC(month, SYSDATETIME())       as [month]
, DATETRUNC(dayofyear, SYSDATETIME())   as [dayofyear]  -- dayofyear is truncated in the same manner as day
, DATETRUNC(day, SYSDATETIME())         as [day]        -- day is truncated in the same manner as dayofyear
, DATETRUNC(week, SYSDATETIME())        as [week]       -- Truncate to the first day of the week. In T-SQL, the first day of the week is defined by the @@DATEFIRST T-SQL setting. For a U.S. English environment, @@DATEFIRST defaults to 7 (Sunday).
, DATETRUNC(iso_week, SYSDATETIME())    as [iso_week]   -- Truncate to the first day of an ISO Week. The first day of the week in the ISO8601 calendar system is Monday.
, DATETRUNC(HOUR, SYSDATETIME())        as [hour]
, DATETRUNC(MINUTE, SYSDATETIME())      as [minute]
, DATETRUNC(SECOND, SYSDATETIME())      as [second]
, DATETRUNC(MILLISECOND, SYSDATETIME()) as [millisecond]
, DATETRUNC(MICROSECOND, SYSDATETIME()) as [microsecond]


select datefromparts(2024, 7, 15) -- ( year, month, day )
, DATETIMEFROMPARTS(2024, 7, 15, 13, 23, 16, 597) -- ( year, month, day, hours, minutes, seconds, milliseconds)
, DATETIME2FROMPARTS(2024, 7, 15, 13, 23, 16, 1234567, 7) -- ( year, month, day, hours, minutes, seconds, microseconds, precision)
, DATETIMEOFFSETFROMPARTS (2024, 7, 15, 13, 23, 16, 1234567, 0, 7, 7)   -- ( year, month, day, hour, minute, seconds, fractions, hour_offset, minute_offset, precision )  
, SMALLDATETIMEFROMPARTS ( 2024, 7, 15, 13, 23 ) -- ( year, month, day, hour, minute )
, TIMEFROMPARTS (13, 23, 16, 1234567, 7 ) -- ( hour, minute, seconds, fractions, precision ) 


select 
  datediff(year       , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   y, yy, yyyy
, datediff(quarter    , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   qq, q
, datediff(month      , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   mm, m
, datediff(dayofyear  , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   dy
, datediff(day        , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   dd, d
, datediff(week       , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   wk, ww
, datediff(weekday    , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   dw, w
, datediff(hour       , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   hh
, datediff(minute     , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   mi, n
, datediff(second     , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   ss, s
, datediff(millisecond, '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   ms
, datediff(microsecond, '2024-07-15 01:15:23.983', '2024-07-15 01:37:23.343') --   mcs
, datediff(nanosecond , '2024-07-15 01:15:23.983', '2024-07-15 01:15:23.985') --   ns

, datediff_big(year       , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   y, yy, yyyy
, datediff_big(quarter    , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   qq, q
, datediff_big(month      , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   mm, m
, datediff_big(dayofyear  , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   dy
, datediff_big(day        , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   dd, d
, datediff_big(week       , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   wk, ww
, datediff_big(weekday    , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   dw, w
, datediff_big(hour       , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   hh
, datediff_big(minute     , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   mi, n
, datediff_big(second     , '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   ss, s
, datediff_big(millisecond, '2024-07-15 01:15:23.983', '2024-07-23 17:37:23.343') --   ms
, datediff_big(microsecond, '2024-07-15 01:15:23.983', '2024-07-15 01:37:23.343') --   mcs
, datediff_big(nanosecond , '2024-07-15 01:15:23.983', '2024-07-15 01:15:23.985') --   ns


select
  dateadd(year        , 10, SYSDATETIME()) --yy, yyyy
, dateadd(quarter     , 10, SYSDATETIME()) --qq, q
, dateadd(month       , 10, SYSDATETIME()) --mm, m
, dateadd(dayofyear   , 10, SYSDATETIME()) --dy, y
, dateadd(day         , 10, SYSDATETIME()) --dd, d
, dateadd(week        , 10, SYSDATETIME()) --wk, ww
, dateadd(weekday     , 10, SYSDATETIME()) --dw, w
, dateadd(hour        , 10, SYSDATETIME()) --hh
, dateadd(minute      , 10, SYSDATETIME()) --mi, n
, dateadd(second      , 10, SYSDATETIME()) --ss, s
, dateadd(millisecond , 10, SYSDATETIME()) --ms
, dateadd(microsecond , 10, SYSDATETIME()) --mcs
, dateadd(nanosecond  , 10, SYSDATETIME()) --ns


select eomonth(getdate())
, eomonth(getdate(), 4)


select @@datefirst -- Shows the DATEFIRST setting.
SET DATEFIRST 2;  -- Sets the first day of the week to a number from 1 through 7.  1=Mon, 2=Tue, 3=Wed, 4=Thu, 5=Fri, 6=Sat, 7=Sun
select datepart(weekday, getdate());
SET DATEFIRST 7;  -- Sets the first day of the week to a number from 1 through 7.  1=Mon, 2=Tue, 3=Wed, 4=Thu, 5=Fri, 6=Sat, 7=Sun
select datepart(weekday, getdate());


select isdate(getdate())
, isdate('nebraska')
, isdate('2024-07-15')
, isdate('2024-07-35')
, isdate('2024-07-15 25:02:17')
, isdate('2024-07-15 23:02:17')



select
  convert(nvarchar(50), SYSDATETIME(), 0)    as [0]      -- Jul 31 2024 10:59AM
, convert(nvarchar(50), SYSDATETIME(), 100)  as [100]    -- Jul 31 2024 10:59AM
, convert(nvarchar(50), SYSDATETIME(), 1)    as [1]      -- 07/31/24
, convert(nvarchar(50), SYSDATETIME(), 101)  as [101]    -- 07/31/2024
, convert(nvarchar(50), SYSDATETIME(), 2)    as [2]      -- 24.07.31
, convert(nvarchar(50), SYSDATETIME(), 102)  as [102]    -- 2024.07.31
, convert(nvarchar(50), SYSDATETIME(), 3)    as [3]      -- 31/07/24
, convert(nvarchar(50), SYSDATETIME(), 103)  as [103]    -- 31/07/2024
, convert(nvarchar(50), SYSDATETIME(), 4)    as [4]      -- 31.07.24
, convert(nvarchar(50), SYSDATETIME(), 104)  as [104]    -- 31.07.2024
, convert(nvarchar(50), SYSDATETIME(), 5)    as [5]      -- 31-07-24
, convert(nvarchar(50), SYSDATETIME(), 105)  as [105]    -- 31-07-2024
, convert(nvarchar(50), SYSDATETIME(), 6)    as [6]      -- 31 Jul 24
, convert(nvarchar(50), SYSDATETIME(), 106)  as [106]    -- 31 Jul 2024
, convert(nvarchar(50), SYSDATETIME(), 7)    as [7]      -- Jul 31, 24
, convert(nvarchar(50), SYSDATETIME(), 107)  as [107]    -- Jul 31, 2024
, convert(nvarchar(50), SYSDATETIME(), 8)    as [8]      -- 10:59:39
, convert(nvarchar(50), SYSDATETIME(), 108)  as [108]    -- 10:59:39
, convert(nvarchar(50), SYSDATETIME(), 24)   as [24]     -- 10:59:39
, convert(nvarchar(50), SYSDATETIME(), 9)    as [9]      -- Jul 31 2024 10:59:39.1506987AM
, convert(nvarchar(50), SYSDATETIME(), 109)  as [109]    -- Jul 31 2024 10:59:39.1506987AM
, convert(nvarchar(50), SYSDATETIME(), 10)   as [10]     -- 07-31-24
, convert(nvarchar(50), SYSDATETIME(), 110)  as [110]    -- 07-31-2024
, convert(nvarchar(50), SYSDATETIME(), 11)   as [11]     -- 24/07/31
, convert(nvarchar(50), SYSDATETIME(), 111)  as [111]    -- 2024/07/31
, convert(nvarchar(50), SYSDATETIME(), 12)   as [12]     -- 240731
, convert(nvarchar(50), SYSDATETIME(), 112)  as [112]    -- 20240731
, convert(nvarchar(50), SYSDATETIME(), 13)   as [13]     -- 31 Jul 2024 10:59:39.1506987
, convert(nvarchar(50), SYSDATETIME(), 113)  as [113]    -- 31 Jul 2024 10:59:39.1506987
, convert(nvarchar(50), SYSDATETIME(), 14)   as [14]     -- 10:59:39.1506987
, convert(nvarchar(50), SYSDATETIME(), 114)  as [114]    -- 10:59:39.1506987
, convert(nvarchar(50), SYSDATETIME(), 20)   as [20]     -- 2024-07-31 10:59:39
, convert(nvarchar(50), SYSDATETIME(), 120)  as [120]    -- 2024-07-31 10:59:39
, convert(nvarchar(50), SYSDATETIME(), 21)   as [21]     -- 2024-07-31 10:59:39.1506987
, convert(nvarchar(50), SYSDATETIME(), 25)   as [25]     -- 2024-07-31 10:59:39.1506987
, convert(nvarchar(50), SYSDATETIME(), 121)  as [121]    -- 2024-07-31 10:59:39.1506987
, convert(nvarchar(50), SYSDATETIME(), 22)   as [22]     -- 07/31/24 10:59:39 AM
, convert(nvarchar(50), SYSDATETIME(), 23)   as [23]     -- 2024-07-31
, convert(nvarchar(50), SYSDATETIME(), 126)  as [126]    -- 2024-07-31T10:59:39.1506987
, convert(nvarchar(50), SYSDATETIME(), 127)  as [127]    -- 2024-07-31T10:59:39.1506987
, convert(nvarchar(50), SYSDATETIME(), 130)  as [130]    -- 
, convert(nvarchar(50), SYSDATETIME(), 131)  as [131]    -- 25/01/1446 10:59:39.1506987AM



go
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
declare @End date = '2024-12-31'

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



--*************************************************************************
-- Create Dates Table
--*************************************************************************
declare @Start date = '2015-01-01';
declare @End date = '2024-12-31';

with cte as 
(
    select @Start as [Date]
    union all
    select dateadd(day, 1, [Date]) from cte where [Date] < @End
)
select 
  convert(int, replace(convert(nvarchar(10), [Date], 121), '-', '')) as [DateKey]
, [Date]
, datepart(year         , [Date]) as [Year]                                                  -- The numerical calendar year
, datepart(quarter      , [Date]) as [Quarter]                                               -- The numerical calendar quarter
, datepart(month        , [Date]) as [Month]                                                 -- The numerical calendar month
, convert(nvarchar(9), datename(month        , [Date])) as [MonthName]                       -- The full name of the calendar month
, convert(nvarchar(3), substring(datename(month        , [Date]),1,3)) as [MonthNameShort]   -- The abbreviated name of the calendar month
, convert(smallint, datepart(dayofyear    , [Date])) as [DayOfYear]                          -- The numerical day of the year based on Jan 1st being the first day of the year
, datediff(day,dateadd(quarter,datediff(quarter,0,[Date]),0),[Date]) + 1 as [DayOfQuarter]  -- The numerical day of the quarter
, convert(tinyint, datepart(day          , [Date])) as [DayOfMonth]                          -- The numerical calendar day of the month
, convert(tinyint, datepart(week         , [Date])) as [Week]                                -- The numerical week number of the year based on the first day of the week being whatever day is set in the DATEFIRST setting.  You can check this by: select case @@datefirst when 1 then 'Monday' when 2 then 'Tuesday' when 3 then 'Wednesday' when 4 then 'Thursday' when 5 then 'Friday' when 6 then 'Saturday' when 7 then 'Sunday' end
, datepart(weekday      , [Date]) as [Weekday]                                               -- The numerical day of the week based on the first day of the week being whatever day is set in the DATEFIRST setting.  You can check this by: select case @@datefirst when 1 then 'Monday' when 2 then 'Tuesday' when 3 then 'Wednesday' when 4 then 'Thursday' when 5 then 'Friday' when 6 then 'Saturday' when 7 then 'Sunday' end
, convert(nvarchar(10), case @@datefirst when 1 then 'Monday' when 2 then 'Tuesday' when 3 then 'Wednesday' when 4 then 'Thursday' when 5 then 'Friday' when 6 then 'Saturday' when 7 then 'Sunday' end) as [FirstDayOfWeek] -- The DATEFIRST setting effects the first day of the week.  Default is Sunday

-- ISO --
, datepart(iso_week     , [Date]) as [Iso_Week]                                              -- The numerical week number of the year based on the first day of the week always being Monday
, case when @@datefirst = 1 then datepart(weekday      , [Date])
            when @@datefirst = 2 then case when datepart(weekday      , [Date]) >= 7 then datepart(weekday      , [Date]) - 6 else datepart(weekday      , [Date]) + 1 end
            when @@datefirst = 3 then case when datepart(weekday      , [Date]) >= 6 then datepart(weekday      , [Date]) - 5 else datepart(weekday      , [Date]) + 2 end
            when @@datefirst = 4 then case when datepart(weekday      , [Date]) >= 5 then datepart(weekday      , [Date]) - 4 else datepart(weekday      , [Date]) + 3 end
            when @@datefirst = 5 then case when datepart(weekday      , [Date]) >= 4 then datepart(weekday      , [Date]) - 3 else datepart(weekday      , [Date]) + 4 end
            when @@datefirst = 6 then case when datepart(weekday      , [Date]) >= 3 then datepart(weekday      , [Date]) - 2 else datepart(weekday      , [Date]) + 5 end
            when @@datefirst = 7 then case when datepart(weekday      , [Date]) >= 2 then datepart(weekday      , [Date]) - 1 else datepart(weekday      , [Date]) + 6 end
        end as [Iso_Weekday]                                                                 -- The Iso_Week always starts on Monday.  The datepart(weekday, [Date]) function could return a different value based on the DATEFIRST setting.  This case statement accounts for that.
, convert(nvarchar(10), 'Monday') as [Iso_FirstDayOfWeek]

, convert(tinyint, ceiling((datepart(dayofyear    , [Date]) / 7.0))) as [Absolute_Week]      -- The numerical week number of the year ASSUMING that the first week of the year is ALWAYS composed of the first 7 days of the year REGARDLESS of which day of the week Jan 1st falls on

, convert(nvarchar(10), datename(weekday      , [Date])) as [WeekdayName]                    -- The full name of the day of the week
, convert(nvarchar(3), substring(datename(weekday      , [Date]),1,3)) as [WeekdayNameShort] -- The abbreviated name of the day of the week
, convert(nvarchar(7), case when convert(nvarchar(10), datename(weekday      , [Date])) in ('Saturday', 'Sunday') then 'WEEKEND' else 'WEEKDAY' end) as [Weekend_Weekday] -- WEEKEND or WEEKDAY
, convert(nvarchar(7), [Date], 121) as [YYYY-MM]                                             -- Character string representing YYYY-MM
, convert(nvarchar(10), [Date], 121) as [YYYY-MM-DD]                                         -- Character string representing YYYY-MM-DD
, convert(nvarchar(6), replace(convert(nvarchar(7), [Date], 121), '-', '')) as [YYYYMM]      -- Character string representing YYYYMM
, substring(datename(month        , [Date]),1,3) + ' ' + convert(nvarchar(4), datepart(year         , [Date])) as [MMM-YYYY] -- Character string representing [Abbreviated Month Name] YYYY
, convert(nvarchar(12), [Date], 107) as [DateDescr]                                                                                                                            -- Jan 01, 2015
, convert(nvarchar(20), datename(month        , [Date]) + substring(convert(nvarchar(20), [Date], 107),4,9)) as [DateDescrLong]                                                -- January 01, 2015
, convert(nvarchar(3), substring(datename(weekday      , [Date]),1,3)) + ', ' + convert(nvarchar(12), [Date], 107) as [DateDescrLonger]                                        -- Thu, Jan 01, 2015
, convert(nvarchar(30), datename(weekday      , [Date]) + ', ' + datename(month        , [Date]) + substring(convert(nvarchar(20), [Date], 107),4,9)) as [DateDescrReallyLong] -- Thursday, January 01, 2015


from cte 
option (maxrecursion 0);

go






--*************************************************************************
-- Create Dates Table using the more efficient way
--*************************************************************************
declare @Start date = '2015-01-01';
declare @End date = '2024-12-31';

with cte as 
(
        SELECT --ones.n + (tens.n * 10) + (hundreds.n * 100) + (thousands.n * 1000) + (tenthousands.n * 10000) --+ (hundredthousands.n * 100000)
         dateadd(day, (ones.n + (tens.n * 10) + (hundreds.n * 100) + (thousands.n * 1000) + (tenthousands.n * 10000) + (hundredthousands.n * 100000)), @Start) as [Date]
        FROM  ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) ones(n)
            cross apply ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) tens(n)
            cross apply ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) hundreds(n)
            cross apply ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) thousands(n)
            cross apply ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) tenthousands(n)
            cross apply ( VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9) ) hundredthousands(n)
            where dateadd(day, (ones.n + (tens.n * 10) + (hundreds.n * 100) + (thousands.n * 1000) + (tenthousands.n * 10000) + (hundredthousands.n * 100000)), @Start) <= @End
)
select 
  convert(int, replace(convert(nvarchar(10), [Date], 121), '-', '')) as [DateKey]
, [Date]
, datepart(year         , [Date]) as [Year]                                                  -- The numerical calendar year
, datepart(quarter      , [Date]) as [Quarter]                                               -- The numerical calendar quarter
, datepart(month        , [Date]) as [Month]                                                 -- The numerical calendar month
, convert(nvarchar(9), datename(month        , [Date])) as [MonthName]                       -- The full name of the calendar month
, convert(nvarchar(3), substring(datename(month        , [Date]),1,3)) as [MonthNameShort]   -- The abbreviated name of the calendar month
, convert(smallint, datepart(dayofyear    , [Date])) as [DayOfYear]                          -- The numerical day of the year based on Jan 1st being the first day of the year
, datediff(day,dateadd(quarter,datediff(quarter,0,[Date]),0),[Date]) + 1 as [DayOfQuarter]  -- The numerical day of the quarter
, convert(tinyint, datepart(day          , [Date])) as [DayOfMonth]                          -- The numerical calendar day of the month
, convert(tinyint, datepart(week         , [Date])) as [Week]                                -- The numerical week number of the year based on the first day of the week being whatever day is set in the DATEFIRST setting.  You can check this by: select case @@datefirst when 1 then 'Monday' when 2 then 'Tuesday' when 3 then 'Wednesday' when 4 then 'Thursday' when 5 then 'Friday' when 6 then 'Saturday' when 7 then 'Sunday' end
, datepart(weekday      , [Date]) as [Weekday]                                               -- The numerical day of the week based on the first day of the week being whatever day is set in the DATEFIRST setting.  You can check this by: select case @@datefirst when 1 then 'Monday' when 2 then 'Tuesday' when 3 then 'Wednesday' when 4 then 'Thursday' when 5 then 'Friday' when 6 then 'Saturday' when 7 then 'Sunday' end
, convert(nvarchar(10), case @@datefirst when 1 then 'Monday' when 2 then 'Tuesday' when 3 then 'Wednesday' when 4 then 'Thursday' when 5 then 'Friday' when 6 then 'Saturday' when 7 then 'Sunday' end) as [FirstDayOfWeek] -- The DATEFIRST setting effects the first day of the week.  Default is Sunday

-- ISO --
, datepart(iso_week     , [Date]) as [Iso_Week]                                              -- The numerical week number of the year based on the first day of the week always being Monday
, case when @@datefirst = 1 then datepart(weekday      , [Date])
            when @@datefirst = 2 then case when datepart(weekday      , [Date]) >= 7 then datepart(weekday      , [Date]) - 6 else datepart(weekday      , [Date]) + 1 end
            when @@datefirst = 3 then case when datepart(weekday      , [Date]) >= 6 then datepart(weekday      , [Date]) - 5 else datepart(weekday      , [Date]) + 2 end
            when @@datefirst = 4 then case when datepart(weekday      , [Date]) >= 5 then datepart(weekday      , [Date]) - 4 else datepart(weekday      , [Date]) + 3 end
            when @@datefirst = 5 then case when datepart(weekday      , [Date]) >= 4 then datepart(weekday      , [Date]) - 3 else datepart(weekday      , [Date]) + 4 end
            when @@datefirst = 6 then case when datepart(weekday      , [Date]) >= 3 then datepart(weekday      , [Date]) - 2 else datepart(weekday      , [Date]) + 5 end
            when @@datefirst = 7 then case when datepart(weekday      , [Date]) >= 2 then datepart(weekday      , [Date]) - 1 else datepart(weekday      , [Date]) + 6 end
        end as [Iso_Weekday]                                                                 -- The Iso_Week always starts on Monday.  The datepart(weekday, [Date]) function could return a different value based on the DATEFIRST setting.  This case statement accounts for that.
, convert(nvarchar(10), 'Monday') as [Iso_FirstDayOfWeek]

, convert(tinyint, ceiling((datepart(dayofyear    , [Date]) / 7.0))) as [Absolute_Week]      -- The numerical week number of the year ASSUMING that the first week of the year is ALWAYS composed of the first 7 days of the year REGARDLESS of which day of the week Jan 1st falls on

, convert(nvarchar(10), datename(weekday      , [Date])) as [WeekdayName]                    -- The full name of the day of the week
, convert(nvarchar(3), substring(datename(weekday      , [Date]),1,3)) as [WeekdayNameShort] -- The abbreviated name of the day of the week
, convert(nvarchar(7), case when convert(nvarchar(10), datename(weekday      , [Date])) in ('Saturday', 'Sunday') then 'WEEKEND' else 'WEEKDAY' end) as [Weekend_Weekday] -- WEEKEND or WEEKDAY
, convert(nvarchar(7), [Date], 121) as [YYYY-MM]                                             -- Character string representing YYYY-MM
, convert(nvarchar(10), [Date], 121) as [YYYY-MM-DD]                                         -- Character string representing YYYY-MM-DD
, convert(nvarchar(6), replace(convert(nvarchar(7), [Date], 121), '-', '')) as [YYYYMM]      -- Character string representing YYYYMM
, substring(datename(month        , [Date]),1,3) + ' ' + convert(nvarchar(4), datepart(year         , [Date])) as [MMM-YYYY] -- Character string representing [Abbreviated Month Name] YYYY
, convert(nvarchar(12), [Date], 107) as [DateDescr]                                                                                                                            -- Jan 01, 2015
, convert(nvarchar(20), datename(month        , [Date]) + substring(convert(nvarchar(20), [Date], 107),4,9)) as [DateDescrLong]                                                -- January 01, 2015
, convert(nvarchar(3), substring(datename(weekday      , [Date]),1,3)) + ', ' + convert(nvarchar(12), [Date], 107) as [DateDescrLonger]                                        -- Thu, Jan 01, 2015
, convert(nvarchar(30), datename(weekday      , [Date]) + ', ' + datename(month        , [Date]) + substring(convert(nvarchar(20), [Date], 107),4,9)) as [DateDescrReallyLong] -- Thursday, January 01, 2015


from cte 
order by [Date] asc
go


