view: pop {
#  label: "Period Comparison Fields"

  extension: required
  extends: [transactions]

  filter: current_date_range {
    view_label: "Calendar - Completed Date"
    label: "Date Filter"
    description: "Filter Transactions by Completed Date"
    type: date
    # datatype:
    hidden:  no
  }

  filter: previous_date_range {
    view_label: "Period Comparison Fields"
    label: "2b. Compare To (Custom):"
    description: "Use this if you want to specify a custom date range to compare to (limited to 2 comparison periods). Always use with '1. Date Range' filter (or it will error). Make sure any filter on Event Date covers this period, or is removed."
    type: date
    # datatype: date
    convert_tz: yes
    hidden:  yes
  }

  dimension_group: in_period {
    view_label: "Period Comparison Fields"
    type: duration
    intervals: [day]
    description: "Gives the number of days in the current period date range"
    sql_start: {% date_start current_date_range %} ;;
    sql_end: {% date_end current_date_range %} ;;
    # hidden:  yes
  }

  dimension: period_2_start {
    view_label: "Period Comparison Fields"
    description: "Calculates the start of the previous period"
    type: date_raw
    sql:
    {% if compare_to._in_query %}
      {% if compare_to._parameter_value == "Period" %}
        TIMESTAMP_SUB({% date_start current_date_range %} , INTERVAL ${days_in_period} DAY)
      {% elsif compare_to._parameter_value == "Year" %}
        TIMESTAMP_SUB({% date_start current_date_range %} , INTERVAL 364 DAY)
      {% else %}
        TIMESTAMP(DATETIME_SUB(DATETIME({% date_start current_date_range %}) , INTERVAL 1 {% parameter compare_to %}))
      {% endif %}
    {% else %}
      {% date_start previous_date_range %}
    {% endif %};;
    # hidden:  yes
  }

  dimension: period_2_end {
    view_label: "Period Comparison Fields"
    description: "Calculates the end of the previous period"
    type: date_raw
    sql:
    {% if compare_to._in_query %}
      {% if compare_to._parameter_value == "Period" %}
        TIMESTAMP_SUB({% date_start current_date_range %}, INTERVAL 1 DAY)
      {% elsif compare_to._parameter_value == "Year" %}
        TIMESTAMP_SUB({% date_end current_date_range %} , INTERVAL 364 DAY)
      {% else %}
        TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end current_date_range %}), INTERVAL 0 DAY), INTERVAL 1 {% parameter compare_to %}))
      {% endif %}
    {% else %}
      {% date_end previous_date_range %}
    {% endif %};;
    # hidden:  yes
  }

#have a look at adjusting this for same day last year (not date) and also account for leap year

  dimension: period_3_start {
    view_label: "Period Comparison Fields"
    description: "Calculates the start of 2 periods ago"
    type: date_raw
    sql:
    {% if compare_to._parameter_value == "Period" %}
      TIMESTAMP_SUB({% date_start current_date_range %}, INTERVAL 2*${days_in_period} DAY)
    {% elsif compare_to._parameter_value == "Year" %}
        TIMESTAMP_SUB({% date_start current_date_range %} , INTERVAL 364*2 DAY)
    {% else %}
      TIMESTAMP(DATETIME_SUB(DATETIME({% date_start current_date_range %}), INTERVAL 2 {% parameter compare_to %}))
    {% endif %};;
    hidden: no
  }

  dimension: period_3_end {
    view_label: "Period Comparison Fields"
    description: "Calculates the end of 2 periods ago"
    type: date_raw
    sql:
    {% if compare_to._parameter_value == "Period" %}
      TIMESTAMP_SUB(${period_2_start}, INTERVAL 1 DAY)
    {% elsif compare_to._parameter_value == "Year" %}
        TIMESTAMP_SUB({% date_end current_date_range %} , INTERVAL 364*2 DAY)
    {% else %}
      TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end current_date_range %}), INTERVAL 0 DAY), INTERVAL 2 {% parameter compare_to %}))
    {% endif %};;
    hidden: no
  }

  # dimension: period_4_start {
  #   view_label: "Period Comparison Fields"
  #   description: "Calculates the start of 4 periods ago"
  #   type: base_date_raw
  #   sql:
  #   {% if compare_to._parameter_value == "Period" %}
  #     TIMESTAMP_SUB({% date_start current_date_range %}, INTERVAL 3*${days_in_period} DAY)
  #   {% else %}
  #     TIMESTAMP(DATETIME_SUB(DATETIME({% date_start current_date_range %}), INTERVAL 3 {% parameter compare_to %}))
  #   {% endif %};;
  #   hidden: no
  # }

  # dimension: period_4_end {
  #   view_label: "Period Comparison Fields"
  #   description: "Calculates the end of 4 periods ago"
  #   type: base_date_raw
  #   sql:
  #     {% if compare_to._parameter_value == "Period" %}
  #       TIMESTAMP_SUB(${period_2_start}, INTERVAL 1 DAY)
  #     {% else %}
  #       TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end current_date_range %}), INTERVAL 1 DAY), INTERVAL 3 {% parameter compare_to %}))
  #     {% endif %};;
  #   hidden: no
  # }

  parameter: compare_to {
    view_label: "Calendar - Completed Date"
    group_label: "Period-Over-Period"
    label: "Comparison Period"
    description: "Choose the period you would like to compare to. Must be used with Current Date Range filter"
    type: unquoted
    allowed_value: {
      label: "Previous Period"
      value: "Period"
    }
    allowed_value: {
      label: "Previous Week"
      value: "Week"
    }
    allowed_value: {
      label: "Previous Month"
      value: "Month"
    }
    allowed_value: {
      label: "Previous Quarter"
      value: "Quarter"
    }
    allowed_value: {
      label: "Previous Year"
      value: "Year"
    }
    default_value: "Period"
  }

  parameter: comparison_periods {
    view_label: "Calendar - Completed Date"
    group_label: "Period-Over-Period"
    label: "Number of Periods"
    description: "Choose the number of periods you would like to compare - defaults to 2. Only works with templated periods from step 2."
    type: unquoted
    allowed_value: {
      label: "2"
      value: "2"
    }
    allowed_value: {
      label: "3"
      value: "3"
    }
    # allowed_value: {
    #   label: "4"
    #   value: "4"
    # }
    default_value: "2"
  }

  dimension: period {
    view_label: "Calendar - Completed Date"
    group_label: "Period-Over-Period"
    label: "Pivot This Field"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period', 'Previous Period' or '3 Periods Ago'"
    type: string
    order_by_field: order_for_period
    sql:
      {% if current_date_range._is_filtered %}
        CASE
          WHEN {% condition current_date_range %}  ${base_date_raw} {% endcondition %}
          THEN "This {% parameter compare_to %}"
          WHEN ${base_date_raw} >= ${period_2_start} and ${base_date_raw} < ${period_2_end}
          THEN "Last {% parameter compare_to %}"
          WHEN ${base_date_raw}  >= ${period_3_start} and ${base_date_raw} < ${period_3_end}
          THEN "2 {% parameter compare_to %}s Ago"

        END
      {% else %}
        NULL
      {% endif %}
      ;;
  }

  dimension: order_for_period {
    hidden: no
    view_label: "Period Comparison Fields"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period', 'Previous Period' or '3 Periods Ago'"
    type: string
    sql:
      {% if transactions.previous_date_range._is_filtered or transactions.compare_to._in_query %}
        CASE
          WHEN {% condition current_date_range %} ${base_date_raw} /*findme6*/{% endcondition %}
          THEN 1
          WHEN ${base_date_raw} >= ${period_2_start} and ${base_date_raw} < ${period_2_end}
          THEN 2
          WHEN ${base_date_raw} >= ${period_3_start} and ${base_date_raw} < ${period_3_end}
          THEN 3
        END
      {% endif %}
      ;;
  }

  dimension_group: date {
    view_label: "Calendar - Completed Date"
    group_label: "Date/Time"
    label: ""
    # label: "Completed"
    description: "Use this as your date dimension when comparing periods. Aligns the all previous periods onto the current period"
    type: time
    sql:
      {% if transactions.previous_date_range._is_filtered or transactions.compare_to._in_query %}
        TIMESTAMP_ADD({% date_start current_date_range %},INTERVAL (${day_in_period}) -1 DAY)
      {% else %}
        ${transactions.base_date_raw}
      {% endif %};;
    timeframes: [date]
    hidden:  no
  }

  dimension: day_in_period {
    view_label: "Period Comparison Fields"
    description: "Gives the number of days since the start of each periods. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
    {% if transactions.previous_date_range._is_filtered or transactions.compare_to._in_query %}
      CASE
        WHEN {% condition current_date_range %} ${base_date_raw} {% endcondition %}
        THEN TIMESTAMP_DIFF(${base_date_raw},{% date_start current_date_range %},DAY)+1

        WHEN ${base_date_raw} >= ${period_2_start} and ${base_date_raw} < ${period_2_end}
        THEN TIMESTAMP_DIFF(${base_date_raw}, ${period_2_start},DAY)+1

        WHEN ${base_date_raw} >= ${period_3_start} and ${base_date_raw} < ${period_3_end}
        THEN TIMESTAMP_DIFF(${base_date_raw}, ${period_3_start},DAY)+1

      END
    {% endif %}
    ;;
    hidden: no
  }
}
