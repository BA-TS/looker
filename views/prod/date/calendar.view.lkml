view: calendar {
  sql_table_name:

  `toolstation-data-storage.ts_finance.dim_date`

  ;;

  dimension: date{
    type: date
    primary_key: yes
    hidden:  yes
    sql: ${TABLE}.fullDate ;;
  }
  dimension: calendar_quarter {
    group_label: "Calendar"
    type: number
    sql: ${TABLE}.calendarQuarter ;;
    hidden: yes
  }
  dimension: calendar_year {
    group_label: "Calendar"
    type: number
    sql: ${TABLE}.calendarYear ;;
    hidden: yes
  }
  dimension: calendar_year_month {
    group_label: "Calendar"
    type: string
    sql: ${TABLE}.calendarYearMonth ;;
    hidden: yes
  }
  dimension: calendar_year_quarter {
    group_label: "Calendar"
    type: string
    sql: ${TABLE}.calendarYearQuarter ;;
    hidden: yes
  }
  dimension: date_key {
    group_label: "Date"
    type: number
    sql: ${TABLE}.dateKey ;;
    hidden: yes
  }
  dimension: date_name {
    group_label: "Date"
    type: string
    sql: ${TABLE}.dateName ;;
    hidden: yes
  }
  dimension: date_name_eu {
    group_label: "Date"
    type: string
    sql: ${TABLE}.dateNameEU ;;
    hidden: yes
  }
  dimension: date_name_usa {
    group_label: "Date"
    type: string
    sql: ${TABLE}.dateNameUSA ;;
    hidden: yes
  }
  dimension: day_in_month {
    group_label: "Day"
    type: number
    sql: ${TABLE}.dayInMonth ;;
    hidden: yes
  }
  dimension: day_in_week {
    group_label: "Day"
    type: number
    sql: ${TABLE}.dayInWeek ;;
    hidden: yes
  }
  dimension: day_in_year {
    group_label: "Day"
    type: number
    sql: ${TABLE}.dayInYear ;;
    hidden: yes
  }
  dimension: day_name_in_week {
    group_label: "Day"
    type: string
    sql: ${TABLE}.dayNameInWeek ;;
    hidden: yes
  }
  dimension: fiscal_month_of_year {
    group_label: "Fiscal"
    type: number
    sql: ${TABLE}.fiscalMonthOfYear ;;
    hidden:  yes
  }
  dimension: fiscal_quarter {
    group_label: "Fiscal"
    type: number
    sql: ${TABLE}.fiscalQuarter ;;
    hidden:  yes
  }
  dimension: fiscal_week_of_year {
    group_label: "Fiscal"
    type: number
    sql: ${TABLE}.fiscalWeekOfYear ;;
    hidden:  yes
  }
  dimension: fiscal_year {
    group_label: "Fiscal"
    type: number
    sql: ${TABLE}.fiscalYear ;;
    hidden: yes
  }
  dimension: fiscal_year_month {
    group_label: "Fiscal"
    type: string
    sql: ${TABLE}.fiscalYearMonth ;;
    hidden:  yes
  }
  dimension: fiscal_year_quarter {
    group_label: "Fiscal"
    type: string
    sql: ${TABLE}.fiscalYearQuarter ;;
    hidden:  yes
  }
  dimension: fiscal_year_week {
    label: "Fiscal Week"
    type: number
    sql: ${TABLE}.fiscalYearWeek ;;
    value_format: "#"
    can_filter: no
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
  }
  dimension: is_holiday {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isHoliday = 1;;
  }
  dimension: is_holiday_scotland {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isHolidayScotland = 1;;
  }
  dimension: is_last_day_of_month {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isLastDayOfMonth = 1 ;;
  }
  dimension: is_first_day_of_month {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.dayInMonth = 1 ;;
  }
  dimension: is_weekend {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isWeekend = 1;;
  }
  dimension: month_in_year {
    group_label: "Calendar"
    type: number
    sql: ${TABLE}.monthInYear ;;
    hidden: yes
  }
  dimension: month_name_in_year {
    group_label: "Calendar"
    type: string
    sql: ${TABLE}.monthNameInYear ;;
    hidden: yes
  }
  dimension: week_in_year {
    group_label: "Calendar"
    type: number
    sql: ${TABLE}.weekInYear ;;
    hidden:  yes
  }

}
