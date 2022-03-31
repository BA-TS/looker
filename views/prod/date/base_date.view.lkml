include: "/views/prod/date/period_over_period.view"

view: base {

  derived_table: {
    sql:

    select date
    from UNNEST(GENERATE_DATE_ARRAY('2015-01-01', date(extract(year from current_date), 12, 31))) date

    ;;
    datagroup_trigger: toolstation_core_datagroup
  }

  extends: [period_over_period]


  dimension: combined_day_name {
    view_label: "Date"
    group_label: "Dates"
    label: "Day Name"
    sql: ${dynamic_day_name} ;;
    can_filter: no
    hidden: no
  }

  dimension: combined_day_of_week {
    view_label: "Date"
    group_label: "Dates"
    label: "Day of Week"
    sql: ${dynamic_day_of_week} ;;
    can_filter: no
    hidden: no #! check this for fiscal/calendar switch
  }

  dimension: combined_month_name {
    view_label: "Date"
    group_label: "Dates"
    label: "Month Name"
    sql: ${dynamic_month_name} ;;
    can_filter: no
    hidden: no
  }

  # dimension: combined_month_number {
  #   group_label: "Dates"
  #   label: "Month Number"
  #   sql: ${dynamic_month_number} ;;
  #   can_filter: no
  #   hidden: no
  # }

  dimension: combined_week {
    view_label: "Date"
    group_label: "Dates"
    label: "Week"
    type: string
    sql: {% if select_date_type._parameter_value == "Calendar" %} ${dynamic_actual_week} {% else %} ${dynamic_fiscal_week} {% endif %} ;;
    hidden: no
  }

  dimension: combined_month {
    view_label: "Date"
    group_label: "Dates"
    label: "Month"
    type: string
    sql: {% if select_date_type._parameter_value == "Calendar" %} ${dynamic_actual_month} {% else %} ${dynamic_fiscal_month} {% endif %} ;;
    hidden: no
  }

  dimension: combined_quarter {
    view_label: "Date"
    group_label: "Dates"
    label: "Quarter"
    type: string
    sql: {% if select_date_type._parameter_value == "Calendar" %} ${dynamic_actual_quarter} {% else %} ${dynamic_fiscal_quarter} {% endif %} ;;
    hidden: no
  }

  dimension: combined_half {
    hidden: yes
  }

  dimension: combined_year {
    view_label: "Date"
    group_label: "Dates"
    label: "Year"
    type: number
    sql: {% if select_date_type._parameter_value == "Calendar" %} ${dynamic_actual_year} {% else %} ${dynamic_fiscal_year} {% endif %} ;;
    hidden: no
  }








































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
    group_label: "Calendar"
    label: "Day of Week"
    type: number
    sql: ${calendar_completed_date.day_in_week} ;;
    hidden: yes
  }
  dimension: dynamic_day_name {
    view_label: "Date"
    group_label: "Calendar"
    label: "Day Name"
    type: string
    sql: ${calendar_completed_date.day_name_in_week} ;;
    hidden: yes
  }
  dimension: dynamic_actual_week {
    view_label: "Date"
    group_label: "Calendar"
    label: "Week Number"
    type: number
    sql:

    {% if pivot_dimension._in_query %}
      ${dynamic_actual_year}
      ||
      LPAD(CAST(${calendar_completed_date.week_in_year} AS STRING), 2, "0")
    {% else %}
      ${calendar_completed_date.calendar_year}
      ||
      LPAD(CAST(${calendar_completed_date.week_in_year} AS STRING), 2, "0")
    {% endif %}
    ;;
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
    hidden: yes
  }
  dimension: dynamic_month_number {
    view_label: "Date"
    group_label: "Calendar"
    label: "Month Number"
    type: number
    sql: ${calendar_completed_date.month_in_year} ;;
    hidden: yes
  }
  dimension: dynamic_month_name {
    view_label: "Date"
    group_label: "Calendar"
    label: "Month Name"
    type: string
    sql: ${calendar_completed_date.month_name_in_year} ;;
    hidden: yes
  }

  dimension: dynamic_actual_month {
    view_label: "Date"
    group_label: "Calendar"
    label: "Year Month"
    type: string
    sql:

    {% if pivot_dimension._in_query  %}

      ${dynamic_actual_year}

        ||

      "-"

        ||

      LPAD(CAST(${calendar_completed_date.month_in_year} AS STRING),2,"0")

    {% else %}

      ${calendar_completed_date.calendar_year}

        ||

      "-"

        ||

      LPAD(CAST(${calendar_completed_date.month_in_year} AS STRING),2,"0")

    {% endif %}

    ;;
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

      LPAD(CAST(${calendar_completed_date.fiscal_month_of_year} AS STRING),2,"0")

    {% else %}

      ${calendar_completed_date.fiscal_year}

        ||

      "-"

        ||

      LPAD(CAST(${calendar_completed_date.fiscal_month_of_year} AS STRING),2,"0")

    {% endif %}

    ;;
    hidden: yes
  }
  dimension: dynamic_actual_quarter {
    view_label: "Date"
    group_label: "Calendar"
    label: "Quarter"
    type: number
    sql:

    {% if pivot_dimension._in_query %}
    ${dynamic_actual_year}
      ||
      "Q"
      ||
      LPAD(CAST(${calendar_completed_date.calendar_quarter} AS STRING), 2, "0")
    {% else %}
      ${calendar_completed_date.calendar_year}
      ||
      "Q"
      ||
      LPAD(CAST(${calendar_completed_date.calendar_quarter} AS STRING), 2, "0")

    {% endif %}

    ;;
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
    hidden: yes
  }



  dimension: dynamic_half_number {
    view_label: "Date"
    group_label: "Calendar"
    label: "Half"
    type: number
    hidden: yes
    sql:

    {% if pivot_dimension._in_query  %}

      ${dynamic_actual_year}

        ||

      "H"

        ||

      case when ${calendar_completed_date.calendar_quarter} in (1,2) then 1 else 2 end

    {% else %}

      ${calendar_completed_date.calendar_year}

        ||

      "H"

        ||

      case when ${calendar_completed_date.calendar_quarter} in (1,2) then 1 else 2 end

    {% endif %}



      ;;
  }
  dimension: dynamic_fiscal_half {
    view_label: "Date"
    group_label: "Fiscal"
    label: "Fiscal Half"
    type: string
    hidden: yes
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
    hidden: yes
  }

  dimension: dynamic_actual_year {
    view_label: "Date"
    group_label: "Calendar"
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
