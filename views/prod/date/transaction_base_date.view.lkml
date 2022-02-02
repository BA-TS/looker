include: "/views/prod/date/period_over_period.view"

view: base {

  derived_table: {
    sql:

    select date
    from UNNEST(GENERATE_DATE_ARRAY('2015-01-01', date(extract(year from current_date), 12, 31))) date

    ;;
    datagroup_trigger: toolstation_transactions_datagroup
  }

  extends: [period_on_period_new]

  dimension_group: base_date {
    type: time
    timeframes: [raw, date, year]
    sql:

    timestamp(${TABLE}.date)

    ;;
    hidden: yes
  }

  dimension: base_date_pk {
    primary_key: yes
    type: date
    sql:

    date(${TABLE}.date)

    ;;
    hidden: yes
  }

  # DATE v2 #

  dimension: dynamic_day_of_week {
    view_label: "Date"
    group_label: "TBC"
    label: "Day of Week"
    type: number
    sql: ${calendar_completed_date.day_in_week} ;;
    hidden: yes
  }
  dimension: dynamic_day_name {
    view_label: "Date"
    group_label: "TBC"
    label: "Day Name"
    type: string
    sql: ${calendar_completed_date.day_name_in_week} ;;
    hidden: yes
  }
  dimension: dynamic_week_number {
    view_label: "Date"
    group_label: "TBC"
    label: "Week Number"
    type: number
    sql: ${calendar_completed_date.week_in_year} ;;
    hidden: yes
  }
  dimension: dynamic_fiscal_week {
    view_label: "Date"
    group_label: "Fiscal"
    label: "Fiscal Week"
    type: string
    sql:

    {% if pivot_dimension._in_query  %}

      ${dynamic_fiscal_year}

        ||

      LPAD(CAST(${calendar_completed_date.fiscal_week_of_year} AS STRING),2,"0")

    {% else %}

      ${calendar_completed_date.fiscal_year}

        ||

      LPAD(CAST(${calendar_completed_date.fiscal_week_of_year} AS STRING),2,"0")

    {% endif %}

    ;;
  }
  dimension: dynamic_month_number {
    view_label: "Date"
    group_label: "TBC"
    label: "Month Number"
    type: number
    sql: ${calendar_completed_date.month_in_year} ;;
    hidden: yes
  }
  dimension: dynamic_month_name {
    view_label: "Date"
    group_label: "TBC"
    label: "Month Name"
    type: string
    sql: ${calendar_completed_date.month_name_in_year} ;;
    hidden: yes
  }
  dimension: dynamic_fiscal_month {
    view_label: "Date"
    group_label: "Fiscal"
    label: "Fiscal Month"
    type: string
    sql:

    {% if pivot_dimension._in_query  %}

      ${dynamic_fiscal_year}

        ||

      "-"

        ||

      LPAD(CAST(${calendar_completed_date.month_in_year} AS STRING),2,"0")

    {% else %}

      ${calendar_completed_date.fiscal_year}

        ||

      "-"

        ||

      LPAD(CAST(${calendar_completed_date.month_in_year} AS STRING),2,"0")

    {% endif %}

    ;;
  }
  dimension: dynamic_quarter_number {
    view_label: "Date"
    group_label: "TBC"
    label: "Quarter"
    type: number
    sql: ${calendar_completed_date.calendar_quarter} ;;
    hidden: yes
  }
  dimension: dynamic_fiscal_quarter {
    view_label: "Date"
    group_label: "Fiscal"
    label: "Fiscal Quarter"
    type: string
    sql:

    {% if pivot_dimension._in_query  %}

      ${dynamic_fiscal_year}

        ||

      "Q"

        ||

      LPAD(CAST(${calendar_completed_date.calendar_quarter} AS STRING),2,"0")

    {% else %}

      ${calendar_completed_date.fiscal_year}

        ||

      "Q"

        ||

      LPAD(CAST(${calendar_completed_date.calendar_quarter} AS STRING),2,"0")

    {% endif %}


    ;;
  }



  dimension: dynamic_half_number {
    view_label: "Date"
    group_label: "TBC"
    label: "Half"
    type: number
    sql: case when ${calendar_completed_date.calendar_quarter} in (1,2) then 1 else 2 end  ;;
    hidden: yes
  }
  dimension: dynamic_fiscal_half {
    view_label: "Date"
    group_label: "Fiscal"
    label: "Fiscal Half"
    type: string
    sql:

    {% if pivot_dimension._in_query  %}


      ${dynamic_fiscal_year}

        ||

      "H"

        ||

      ${dynamic_half_number}

    {% else %}

      ${calendar_completed_date.fiscal_year}

        ||

      "H"

        ||

      ${dynamic_half_number}

    {% endif %}


    ;;
  }

  dimension: dynamic_fiscal_year {
    view_label: "Date"
    group_label: "Fiscal"
    label: "Fiscal Year"
    type: number
    sql:

    ${calendar_completed_date.fiscal_year}

    {% if pivot_dimension._in_query  %}
          +
        CASE
          WHEN ${calendar_completed_date.fiscal_year} = EXTRACT(YEAR FROM CURRENT_DATE() - 1) - 1
            THEN 1
          WHEN ${calendar_completed_date.fiscal_year} = EXTRACT(YEAR FROM CURRENT_DATE() - 1) - 2
            THEN 2
          ELSE 0
        END
    {% endif %}

    ;;
  }

  dimension: dynamic_actual_year {
    view_label: "Date"
    group_label: "TBC"
    label: "Year"
    type: number
    sql:

    ${base_date_year}
    {% if pivot_dimension._in_query  %}
      +
    CASE
      WHEN ${base_date_year} = EXTRACT(YEAR FROM CURRENT_DATE() - 1) - 1
        THEN 1
      WHEN ${base_date_year} = EXTRACT(YEAR FROM CURRENT_DATE() - 1) - 2
        THEN 2
      ELSE 0
    END
    {% endif %}

    ;;
    hidden: yes
  }







  measure: count_of_dates {
    type: count_distinct
    sql: ${base_date_date} ;;
    hidden: yes # only used by Data Tests
  }

}
