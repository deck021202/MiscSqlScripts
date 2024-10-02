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
, convert(nvarchar(12), [Date], 107) as [DateDescr]
, convert(nvarchar(20), datename(month        , [Date]) + substring(convert(nvarchar(20), [Date], 107),4,9)) as [DateDescrLong]
, convert(nvarchar(30), datename(weekday      , [Date]) + ', ' + datename(month        , [Date]) + substring(convert(nvarchar(20), [Date], 107),4,9)) as [DateDescrReallyLong]


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


