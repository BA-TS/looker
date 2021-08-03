view: calendar {
  sql_table_name: `toolstation-data-storage.ts_finance.dim_date`
    ;;

  dimension: calendar_quarter {
    type: number
    sql: ${TABLE}.calendarQuarter ;;
  }

  dimension: calendar_year {
    type: number
    sql: ${TABLE}.calendarYear ;;
  }

  dimension: calendar_year_month {
    type: string
    sql: ${TABLE}.calendarYearMonth ;;
  }

  dimension: calendar_year_quarter {
    type: string
    sql: ${TABLE}.calendarYearQuarter ;;
  }

  dimension: date_key {
    type: number
    sql: ${TABLE}.dateKey ;;
  }

  dimension: date_name {
    type: string
    sql: ${TABLE}.dateName ;;
  }

  dimension: date_name_eu {
    type: string
    sql: ${TABLE}.dateNameEU ;;
  }

  dimension: date_name_usa {
    type: string
    sql: ${TABLE}.dateNameUSA ;;
  }

  dimension: day_in_month {
    type: number
    sql: ${TABLE}.dayInMonth ;;
  }

  dimension: day_in_week {
    type: number
    sql: ${TABLE}.dayInWeek ;;
  }

  dimension: day_in_year {
    type: number
    sql: ${TABLE}.dayInYear ;;
  }

  dimension: day_name_in_week {
    type: string
    sql: ${TABLE}.dayNameInWeek ;;
  }

  dimension: fiscal_month_of_year {
    type: number
    sql: ${TABLE}.fiscalMonthOfYear ;;
  }

  dimension: fiscal_quarter {
    type: number
    sql: ${TABLE}.fiscalQuarter ;;
  }

  dimension: fiscal_week_of_year {
    type: number
    sql: ${TABLE}.fiscalWeekOfYear ;;
  }

  dimension: fiscal_year {
    type: number
    sql: ${TABLE}.fiscalYear ;;
  }

  dimension: fiscal_year_month {
    type: string
    sql: ${TABLE}.fiscalYearMonth ;;
  }

  dimension: fiscal_year_quarter {
    type: string
    sql: ${TABLE}.fiscalYearQuarter ;;
  }

  dimension: fiscal_year_week {
    type: number
    sql: ${TABLE}.fiscalYearWeek ;;
    value_format: "#"
  }

  dimension: date{
    type: date
    primary_key: yes
    sql: ${TABLE}.fullDate ;;
  }

  dimension: holiday_name {
    type: string
    sql: ${TABLE}.holidayName ;;
  }

  dimension: holiday_name_scotland {
    type: string
    sql: ${TABLE}.holidayNameScotland ;;
  }

  dimension: is_holiday {
    type: number
    sql: ${TABLE}.isHoliday ;;
  }

  dimension: is_holiday_scotland {
    type: number
    sql: ${TABLE}.isHolidayScotland ;;
  }

  dimension: is_last_day_of_month {
    type: number
    sql: ${TABLE}.isLastDayOfMonth ;;
  }

  dimension: is_weekend {
    type: number
    sql: ${TABLE}.isWeekend ;;
  }

  dimension: month_in_year {
    type: number
    sql: ${TABLE}.monthInYear ;;
  }

  dimension: month_name_in_year {
    type: string
    sql: ${TABLE}.monthNameInYear ;;
  }

  dimension: week_in_year {
    type: number
    sql: ${TABLE}.weekInYear ;;
  }
}
