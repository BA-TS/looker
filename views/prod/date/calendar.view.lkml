include: "/views/prod/date/period_over_period.view"

view: calendar {
  derived_table: {
    sql:
    select distinct * except(fiscalYearWeek), cast(fiscalYearWeek as string) as fiscalYearWeek,
    fullDate as field_to_hide,
    current_date() as todayFullDate,
    (select dateName from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todayDateName,
    (select dateNameUSA from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaydateNameUSA,
    (select dateNameEU from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaydateNameEU,
    (select dayInWeek from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaydayInWeek,
    (select dayNameInWeek from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaydayNameInWeek,
    (select dayInMonth from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaydayInMonth,
    (select dayInYear from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaydayInYear,
    (select weekInYear from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todayweekInYear,

    (select monthNameInYear from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaymonthNameInYear,
    (select monthInYear from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaymonthInYear,
    (select calendarQuarter from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaycalendarQuarter,
    (select calendarYear from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaycalendarYear,
    (select calendarYearMonth from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaydaycalendarYearMonth,
    (select calendarYearQuarter from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todaycalendarYearQuarter,
    (select fiscalWeekOfYear from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todayfiscalWeekOfYear,
    (select fiscalMonthOfYear from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todayfiscalMonthOfYear,

    (select fiscalQuarter from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todayfiscalQuarter,
    (select fiscalYear from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todayfiscalYear,
    (select fiscalYearMonth from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todayfiscalYearMonth,
    (select fiscalYearQuarter from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todayfiscalYearQuarter,
    (select cast(fiscalYearWeek as string) from `toolstation-data-storage.ts_finance.dim_date` where fullDate = current_date()) as todayfiscalYearWeek
    from `toolstation-data-storage.ts_finance.dim_date`;;

    sql_trigger_value: SELECT EXTRACT(hour FROM CURRENT_DATEtime()) = 6;;
    }

  dimension: date{
    group_label: "Dates"
    label: "Date (dd/mm/yyyy)"
    type: date
    primary_key: yes
    sql: timestamp(${TABLE}.fullDate) ;;
    # html: {{ rendered_value | date: "%d/%m/%Y" }};;
  }

  dimension: date_first_day_month{
    group_label: "Dates"
    label: "Date (1st day of Month)"
    type: date
    sql: Date_trunc(date(${date}),MONTH);;
    hidden: yes
  }

  dimension: date_first_day_prev_month{
    required_access_grants: [lz_only]
    group_label: "Dates"
    label: "Date (1st day of Prev Month)"
    type: date
    sql: Date_sub(date(${date_first_day_month}),INTERVAL 1 MONTH);;
    hidden: yes
  }


  dimension: today_date{
    group_label: "Current Date"
    label: "Today (dd/mm/yyyy)"
    type: date
    sql: current_timestamp() ;;
    html: {{ rendered_value | date: "%d/%m/%Y" }};;
  }

  dimension: today_day_of_week{
    group_label: "Current Date"
    required_access_grants: [lz_only]
    label: "Today Day of Week"
    type: number
    sql: EXTRACT(DAYOFWEEK FROM current_date()) ;;
  }

  dimension: calendar_quarter {
    group_label: "Dates"
    label: "Quarter (q)"
    type: number
    sql: ${TABLE}.calendarQuarter ;;
  }

  dimension: today_calendar_quarter {
    group_label: "Today Dates"
    label: "today Quarter (q)"
    hidden: yes
    type: number
    sql: extract(quarter from (current_date());;
  }

  dimension: calendar_year {
    group_label: "Dates"
    label: "Year (yyyy)"
    type: number
    value_format: "0"
    sql: ${TABLE}.calendarYear ;;
  }

  measure: number_of_year {
    group_label: "Dates"
    type: count_distinct
    value_format: "0"
    sql: ${TABLE}.calendarYear ;;
  }

  dimension: today_calendar_year {
    group_label: "Today Dates"
    label: "Year (yyyy)"
    hidden: yes
    type: number
    sql: extract(year from (current_date());;
  }

  dimension: calendar_year_month {
    group_label: "Dates"
    label: "Year Month (yyyy-mm)"
    type: string
    sql: ${TABLE}.calendarYearMonth ;;
  }

  dimension: calendar_year_month2 {
    group_label: "Dates"
    description: "used in the retail explore"
    type: string
    sql: replace(${calendar_year_month},'-','') ;;
    hidden: yes
  }

  dimension: fulldate2 {
    group_label: "Dates"
    label: "full date2"
    type: string
    sql: replace(cast(${date} as string),'-','') ;;
    hidden: yes
  }


  dimension: today_calendar_year_month {
    group_label: "Today Dates"
    label: "Year Month (yyyy-mm)"
    required_access_grants: [lz_only]
    type: string
    sql: ${TABLE}.todaydaycalendarYearMonth;;
  }

  dimension: today_calendar_year_month2 {
    group_label: "Dates"
    description: "used in the retail explore"
    label: "Year Month (yyyy-mm) 2"
    type: string
    sql: replace(${today_calendar_year_month},'-','') ;;
    required_access_grants: [lz_only]
  }

  dimension: calendar_year_quarter {
    group_label: "Dates"
    label: "Year Quarter (yyyy-qq)"
    type: string
    sql: ${TABLE}.calendarYearQuarter ;;
  }

  dimension: month_in_year {
    group_label: "Dates"
    label: "Month (mm)"
    type: number
    sql: ${TABLE}.monthInYear ;;
  }

  dimension: today_month_in_year {
    group_label: "Today Dates"
    label: "Month (mm)"
    hidden: yes
    type: number
    sql: extract(month from current_date());;
  }

  dimension: month_name_in_year {
    group_label: "Dates"
    label: "Month name"
    type: string
    sql: ${TABLE}.monthNameInYear ;;
  }

  dimension: week_in_year {
    group_label: "Dates Calendar"
    type: number
    sql: ${TABLE}.weekInYear ;;
    hidden: yes
  }

  dimension: date_key {
    group_label: "Dates Calendar"
    type: number
    sql: ${TABLE}.dateKey ;;
    hidden: yes
  }

  dimension: date_name {
    group_label: "Dates Calendar"
    type: string
    sql: ${TABLE}.dateName ;;
    hidden: yes
  }

  dimension: date_name_eu {
    group_label: "Dates"
    label: "Date (dd/mm/yyyy)"
    type: string
    sql: ${TABLE}.dateNameEU ;;
    hidden: yes
  }

  dimension: day_in_month {
    group_label: "Dates"
    label: "Day of Month (dd)"
    type: number
    sql: ${TABLE}.dayInMonth ;;
  }


  dimension: today_day_in_month {
    group_label: "Current Date"
    label: "Day of Month (dd)"
    type: number
    sql: cast(ltrim(format_date("%d", current_date()), "0") as int64);;
  }

  dimension: day_in_week {
    group_label: "Dates"
    label: "Day of Week (d)"
    description:"First day of week is Sunday,Sun=1,Mon=2,Tue=3,Wed=4,Thu=5,Fri=6,Sat=7"
    type: number
    sql: ${TABLE}.dayInWeek ;;
  }

  dimension: today_day_in_week {
    group_label: "Current Date"
    label: "Day of Week (d)"
    description:"First day of week is Sunday,Sun=1,Mon=2,Tue=3,Wed=4,Thu=5,Fri=6,Sat=7"
    type: number
    sql: extract(dayofweek FROM current_date());;
  }

  dimension: day_in_year {
    group_label: "Dates"
    label: "Day of Year (ddd)"
    type: number
    sql: ${TABLE}.dayInYear ;;
  }

  dimension: today_day_in_year {
    group_label: "Current Date"
    label: "Day of Year (ddd)"
    type: number
    sql: extract(dayofyear FROM current_date()) ;;
  }


  dimension: day_name_in_week {
    group_label: "Dates Calendar"
    type: string
    sql: ${TABLE}.dayNameInWeek ;;
    hidden: yes
  }

  dimension: fiscal_month_of_year {
    group_label: "Dates Fiscal"
    label: "Fiscal Month (mm)"
    type: number
    sql: ${TABLE}.fiscalMonthOfYear ;;
    required_access_grants: [is_nigel_burch]
  }

  dimension: fiscal_quarter {
    group_label: "Dates Fiscal"
    type: number
    sql: ${TABLE}.fiscalQuarter ;;
    hidden: yes
  }

  dimension: fiscal_week_of_year {
    group_label: "Dates Fiscal"
    label: "Fiscal Week (ww)"
    type: number
    sql: ${TABLE}.fiscalWeekOfYear ;;
  }

  dimension: today_fiscal_week_of_year {
    group_label: "Dates Fiscal"
    label: "Today Fiscal Week (ww)"
    hidden: yes
    type: number
    sql: ${TABLE}.todayfiscalWeekOfYear;;
  }

  dimension: fiscal_year {
    group_label: "Dates Fiscal"
    type: number
    sql: ${TABLE}.fiscalYear ;;
  }

  dimension: fiscal_year_month {
    group_label: "Dates Fiscal"
    type: string
    sql: ${TABLE}.fiscalYearMonth ;;
    hidden: yes
  }

  dimension: fiscal_year_quarter {
    group_label: "Dates Fiscal"
    type: string
    sql: ${TABLE}.fiscalYearQuarter ;;
    hidden: yes
  }

  dimension: fiscal_year_week {
    group_label: "Dates Fiscal"
    label: "Fiscal Year Week (yyyyww)"
    type: string
    sql: ${TABLE}.fiscalYearWeek ;;
  }

  dimension: today_fiscal_year_week {
    group_label: "Dates Fiscal"
    label: "Today Fiscal Year Week (yyyyww)"
    # hidden: yes
    type: string
    sql: ${TABLE}.todayfiscalYearWeek;;
    required_access_grants: [lz_only]
  }

  dimension: ty_py_weeks_filter_1 {
    group_label: "Flags"
    label: "TY and PY Wk-1"
    type: yesno
    sql:
    case when ${today_day_of_week}=1 then
     cast(${fiscal_year_week} as int) IN (cast(${today_fiscal_year_week} as int),cast(${today_fiscal_year_week} as int)-100)
    else
         cast(${fiscal_year_week} as int) IN (cast(${today_fiscal_year_week} as int)-1,cast(${today_fiscal_year_week} as int)-101)
    end
    ;;
  }

  dimension: ty_py_weeks_filter_2 {
    group_label: "Flags"
    label: "TY Wk-1, Wk-2 and PY Wk-1"
    type: yesno
    sql:
    case when ${today_day_of_week}=1 then
      cast(${fiscal_year_week} as int) IN (cast(${today_fiscal_year_week} as int),cast(${today_fiscal_year_week} as int)-1,cast(${today_fiscal_year_week} as int)-100)
     else
      cast(${fiscal_year_week} as int) IN (cast(${today_fiscal_year_week} as int)-1,cast(${today_fiscal_year_week} as int)-2,cast(${today_fiscal_year_week} as int)-101)
     end
      ;;
  }

  dimension: holiday_name {
    group_label: "Holiday"
    type: string
    sql: ${TABLE}.holidayName ;;
  }

  dimension: holiday_name_scotland {
    group_label: "Holiday"
    type: string
    sql: ${TABLE}.holidayNameScotland ;;
    hidden: yes
  }

  dimension: is_holiday {
    group_label: "Holiday"
    type: yesno
    sql: ${TABLE}.isHoliday = 1;;
  }

  dimension: is_holiday_scotland {
    group_label: "Holiday"
    type: yesno
    sql: ${TABLE}.isHolidayScotland = 1;;
    hidden: yes
  }

  dimension: is_weekend {
    group_label: "Holiday"
    type: yesno
    sql: ${TABLE}.isWeekend = 1;;
  }

  dimension: is_last_day_of_month {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isLastDayOfMonth = 1 ;;
    hidden: yes
  }

  dimension: is_first_day_of_month {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.dayInMonth = 1 ;;
    hidden: yes
  }

  dimension: exclude_christmas_new_year{
    group_label: "Flags"
    label: "Exclude Christmas/New Year Weeks (Wks 1,51,52)"
    type: yesno
    sql: ${fiscal_week_of_year} NOT IN (1,51,52);;
  }

  measure: distinct_year_count {
    view_label: "Measures"
    group_label: "Other Metrics"
    label: "Number of Distinct Years"
    hidden: yes
    type: count_distinct
    sql: ${calendar_year} ;;
  }

  measure: distinct_year_month_count {
    view_label: "Measures"
    group_label: "Other Metrics"
    label: "Number of Distinct Year Months"
    hidden: yes
    type: count_distinct
    sql: ${calendar_year_month} ;;
  }

  measure: distinct_month_count {
    view_label: "Measures"
    group_label: "Other Metrics"
    label: "Number of Distinct Months"
    hidden: yes
    type: count_distinct
    sql: ${calendar_year_month} ;;
  }

  measure: distinct_week_count {
    view_label: "Measures"
    group_label: "Other Metrics"
    label: "Number of Distinct Weeks"
    hidden: yes
    type: count_distinct
    sql: ${week_in_year} ;;
  }

  dimension: field_to_hide {
    group_label: "Dates"
    label: "HIDE"
    hidden: yes
    type: date
    sql: timestamp(${TABLE}.field_to_hide) ;;
    #html: {{ rendered_value | date: "%d/%m/%Y" }};;
  }

  filter: filter_on_field_to_hide {
    #view_label: "Datetime (of event)"
    label: "Date"
    group_label: "Date Filter"
    hidden: yes

    type: date
    sql: {% condition filter_on_field_to_hide %} timestamp(field_to_hide) {% endcondition %} ;;
  }

  dimension: field_to_hide2 {
    group_label: "Dates"
    label: "HIDE"
    hidden: yes
    type: date
    sql: timestamp(${TABLE}.field_to_hide) ;;
    #html: {{ rendered_value | date: "%d/%m/%Y" }};;
  }

  filter: filter_on_field_to_hide2 {
    #view_label: "Datetime (of event)"
    label: "2nd Date"
    group_label: "Date Filter"
    hidden: yes

    type: date
    sql: {% condition filter_on_field_to_hide2 %} timestamp(field_to_hide) {% endcondition %} ;;
  }

}
