view: calendar {
  sql_table_name:`toolstation-data-storage.ts_finance.dim_date`;;

  dimension: date{
    group_label: "Dates Calendar"
    type: date
    primary_key: yes
    sql: ${TABLE}.fullDate ;;
    hidden: yes
  }

  dimension: calendar_quarter {
    group_label: "Dates"
    label: "Quarter (q)"
    type: number
    sql: ${TABLE}.calendarQuarter ;;
  }

  dimension: calendar_year {
    group_label: "Dates Calendar"
    type: number
    sql: ${TABLE}.calendarYear ;;
    hidden: yes
  }

  dimension: calendar_year_month {
    group_label: "Dates"
    label: "Year Month (yyyy-mm)"
    type: string
    sql: ${TABLE}.calendarYearMonth ;;
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
  }

  dimension: day_in_month {
    group_label: "Dates Calendar"
    type: number
    sql: ${TABLE}.dayInMonth ;;
    hidden: yes
  }

  dimension: day_in_week {
    group_label: "Dates"
    label: "Day in Week (ddd)"
    description:"First day of week is Sunday,Sun=1,Mon=2,Tue=3,Wed=4,Thu=5,Fri=6,Sat=7"
    type: number
    sql: ${TABLE}.dayInWeek ;;
  }

  dimension: day_in_year {
    group_label: "Dates Calendar"
    type: number
    sql: ${TABLE}.dayInYear ;;
    hidden: yes
  }

  dimension: day_name_in_week {
    group_label: "Dates Calendar"
    type: string
    sql: ${TABLE}.dayNameInWeek ;;
    hidden: yes
  }

  dimension: fiscal_month_of_year {
    group_label: "Dates Fiscal"
    type: number
    sql: ${TABLE}.fiscalMonthOfYear ;;
    hidden: yes
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
    type: string
    sql: ${TABLE}.fiscalYearWeek ;;
    can_filter: no
    hidden: yes
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
}
