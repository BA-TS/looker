view: calendar {
  derived_table: {
    sql:
    select distinct * except(fiscalYearWeek), cast(fiscalYearWeek as string) as fiscalYearWeek,
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
    }

  dimension: date{
    group_label: "Dates"
    label: "Date (dd/mm/yyyy)"
    type: date
    primary_key: yes
    sql: ${TABLE}.fullDate ;;
    html: {{ rendered_value | date: "%d/%m/%Y" }};;
  }

  dimension: today_date{
    group_label: "Current Date"
    label: "Today (dd/mm/yyyy)"
    type: date
    sql: ${TABLE}.todayFullDate ;;
    html: {{ rendered_value | date: "%d/%m/%Y" }};;
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
    sql: ${TABLE}.todaycalendarQuarter;;
  }

  dimension: calendar_year {
    group_label: "Dates"
    label: "Year (yyyy)"
    type: number
    sql: ${TABLE}.calendarYear ;;
  }

  dimension: today_calendar_year {
    group_label: "Today Dates"
    label: "Year (yyyy)"
    hidden: yes
    type: number
    sql: ${TABLE}.todaycalendarYear;;
  }

  dimension: calendar_year_month {
    group_label: "Dates"
    label: "Year Month (yyyy-mm)"
    type: string
    sql: ${TABLE}.calendarYearMonth ;;
  }

  dimension: today_calendar_year_month {
    group_label: "Today Dates"
    label: "Year Month (yyyy-mm)"
    hidden: yes
    type: string
    sql: ${TABLE}.todaydaycalendarYearMonth;;
  }

  dimension: calendar_year_quarter {
    group_label: "Dates Calendar"
    type: string
    sql: ${TABLE}.calendarYearQuarter ;;
    hidden: yes
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
    sql: ${TABLE}.todaymonthInYear;;
  }

  dimension: month_name_in_year {
    group_label: "Dates Calendar"
    type: string
    sql: ${TABLE}.monthNameInYear ;;
    hidden: yes
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
    sql: ${TABLE}.todaydayInMonth ;;
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
    sql: ${TABLE}.todaydayInWeek;;
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
    sql: ${TABLE}.todaydayInYear ;;
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
    hidden: yes
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
    hidden: yes
    type: string
    sql: ${TABLE}.todayfiscalYearWeek;;
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

  measure: unique_month_count {
    view_label: "Measures"
    group_label: "Core Metrics"
    label: "Number of Unique Months"
    required_access_grants: [lz_testing]
    type: count_distinct
    sql: ${calendar_year_month} ;;
  }

  measure: unique_week_count {
    view_label: "Measures"
    group_label: "Core Metrics"
    label: "Number of Unique Weeks"
    required_access_grants: [lz_testing]
    type: count_distinct
    sql: ${week_in_year} ;;
  }
}
