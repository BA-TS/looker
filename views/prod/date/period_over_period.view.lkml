# include: "/views/prod/date/fixed_PoP.view"

view: period_on_period_new {

  extension: required

  filter: period_over_period {
    required_access_grants: [is_developer]
    hidden: yes
    type: yesno
    sql:

      {% if select_date_range._is_filtered %}

        ${flexi_pop}

    {% elsif select_fixed_range._is_filtered %}

        ${pivot_period}

    {% else %}

      false

    {% endif %}

    ;;
  }

  filter: select_date_range {
    label: "Date Range"
    group_label: "Range"
    view_label: "Date"
    type: date
    convert_tz: yes
  }
  parameter: select_fixed_range {
    label: "Fixed Range"
    group_label: "Range"
    view_label: "Date"
    description: "Developer only option."
    type: unquoted
    allowed_value: {
      label: "Previous Day"
      value: "PD"
    }
    allowed_value: {
      label: "Week to Date (WTD)"
      value: "WTD"
    }
    allowed_value: {
      label: "Month to Date (MTD)"
      value: "MTD"
    }
    allowed_value: {
      label: "Year to Date (YTD)"
      value: "YTD"
    }
  }
  parameter: select_comparison_period {
    label: "Comparison Period"
    group_label: "Comparison"
    view_label: "Date"
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
      label: "Previous Year"
      value: "Year"
    }
    allowed_value: {
      label: "Previous 2 Year"
      value: "2YearsAgo"
    }
    default_value: "Period"
  }
  parameter: select_number_of_periods {
    label: "Number of Period(s)"
    group_label: "Comparison"
    view_label: "Date"
    type: unquoted
    allowed_value: {
      label: "1 Period Ago"
      value: "2"
    }
    allowed_value: {
      label: "2 Periods Ago"
      value: "3"
    }
    default_value: "2"
  }



  dimension_group: date {
    view_label: "Date"
    group_label: ""
    label: ""
    description: "Use this as your date dimension when comparing periods. Aligns the all previous periods onto the current period"
    type: time
    sql:

      {% if pivot_dimension._in_query %}
        {% if select_fixed_range._in_query %}

          {% if select_fixed_range._parameter_value == "PD" and (select_comparison_period._parameter_value == "Week" or select_comparison_period._parameter_value == "Month") %}
            ${__current_date__}

          {% else %}

            CASE

              WHEN EXTRACT(YEAR FROM ${__target_date__}) = EXTRACT(YEAR FROM ${__current_date__}) - 1
              THEN ${__target_date__} + ${__length_of_year__}

              WHEN EXTRACT(YEAR FROM ${__target_date__}) = EXTRACT(YEAR FROM ${__current_date__}) - 2
              THEN ${__target_date__} + ${__length_of_year__} * 2

              ELSE ${__target_date__}

            END

          {% endif %}

        {% elsif select_date_range._in_query %}
        TIMESTAMP_ADD({% date_start select_date_range %}, INTERVAL (${day_in_period}) - 1 DAY)
        {% else %}
        ${base_date_raw}
        {% endif %}
      {% else %}
        ${base_date_raw}
      {% endif %}

      ;;
    timeframes: [date, month, year, month_name, day_of_month, day_of_year]
    can_filter: no
    hidden:  no
    allow_fill: no
  }

  dimension: pivot_dimension {
    view_label: "Date"
    label: "Period for Pivot"
    description: "Pivot this to view direct date comparisons."
    type: string
    order_by_field: order_for_period
    sql:

     {% if select_date_range._is_filtered %}

        CASE
          WHEN {% condition select_date_range %}  ${base_date_raw} {% endcondition %}
          THEN "This {% parameter select_comparison_period %}"

          WHEN ${base_date_raw} >= ${period_2_start} and ${base_date_raw} < ${period_2_end}
          THEN "Last {% parameter select_comparison_period %}"

          WHEN ${base_date_raw}  >= ${period_3_start} and ${base_date_raw} < ${period_3_end}
          THEN "2 {% parameter select_comparison_period %}s Ago"

        END

      {% elsif select_fixed_range._is_filtered %}

      CASE
          WHEN
            {% if select_fixed_range._parameter_value == "PD" %}
              CASE WHEN ${previous_full_day} THEN true ELSE false END
            {% elsif select_fixed_range._parameter_value == "WTD" %}
              CASE WHEN ${week_to_date} THEN true ELSE false END
            {% elsif select_fixed_range._parameter_value == "MTD" %}
              CASE WHEN ${month_to_date} THEN true ELSE false END
            {% elsif select_fixed_range._parameter_value == "YTD" %}
              CASE WHEN ${year_to_date} THEN true ELSE false END
            {% else %}
              false
            {% endif %}
          THEN "This {% parameter select_comparison_period %}"

          WHEN
          {% if select_fixed_range._parameter_value == "PD" %}
              CASE WHEN ${previous_full_day_LY} THEN true WHEN ${previous_full_day_LW} THEN true WHEN ${previous_full_day_LM} THEN true ELSE false END
            {% elsif select_fixed_range._parameter_value == "WTD" %}
              CASE WHEN ${week_to_date_LY} THEN true ELSE false END
            {% elsif select_fixed_range._parameter_value == "MTD" %}
              CASE WHEN ${month_to_date_LY} THEN true ELSE false END
            {% elsif select_fixed_range._parameter_value == "YTD" %}
              CASE WHEN ${year_to_date_LY} THEN true ELSE false END
            {% else %}
              false
            {% endif %}
          THEN "Last {% parameter select_comparison_period %}"

          WHEN
          {% if select_fixed_range._parameter_value == "PD" %}
              CASE WHEN ${previous_full_day_2LY} THEN true ELSE true END
            {% elsif select_fixed_range._parameter_value == "WTD" %}
              CASE WHEN ${week_to_date_2LY} THEN true ELSE false END
            {% elsif select_fixed_range._parameter_value == "MTD" %}
              CASE WHEN ${month_to_date_2LY} THEN true ELSE false END
            {% elsif select_fixed_range._parameter_value == "YTD" %}
              CASE WHEN ${year_to_date_2LY} THEN true ELSE false END
            {% else %}
              false
            {% endif %}
          THEN "2 {% parameter select_comparison_period %}s Ago"

          ELSE "UNKNOWN PERIOD!"

      END

      {% else %}
        NULL
      {% endif %}

    ;;
    can_filter: no
  }

# FLEXIBLE PERIOD ON PERIOD

  filter: flexi_pop {
    required_access_grants: [is_developer]
    type: yesno
    sql:

    {% condition base.select_date_range %} ${base.base_date_raw} {% endcondition %}

      {% if base.select_date_range._is_filtered and select_number_of_periods._in_query %}
        {% if select_number_of_periods._parameter_value == "2" %}

            or ${base.base_date_raw} >= ${period_2_start} and ${base.base_date_raw} < ${period_2_end}

          {% elsif select_number_of_periods._parameter_value == "3" %}
            or ${base.base_date_raw} >= ${period_2_start} and ${base.base_date_raw} < ${period_2_end}
            or ${base.base_date_raw} >= ${period_3_start} and ${base.base_date_raw} < ${period_3_end}

        {% endif %}

      {% endif %}

    ;;
    hidden: yes
  }


  dimension_group: in_period {
    type: duration
    intervals: [day]
    description: "Gives the number of days in the current period date range"
    sql_start: {% date_start select_date_range %} ;;
    sql_end: {% date_end select_date_range %} ;;
    hidden:  yes
  }


  dimension: day_in_period {
    view_label: "Period Comparison Fields"
    description: "Gives the number of days since the start of each periods. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:

    {% if select_number_of_periods._is_filtered or select_comparison_period._in_query %}
      CASE
        WHEN {% condition select_date_range %} ${base_date_raw} {% endcondition %}
        THEN TIMESTAMP_DIFF(${base_date_raw},{% date_start select_date_range %},DAY)+1

        WHEN ${base_date_raw} >= ${period_2_start} and ${base_date_raw} < ${period_2_end}
        THEN TIMESTAMP_DIFF(${base_date_raw}, ${period_2_start},DAY)+1

        WHEN ${base_date_raw} >= ${period_3_start} and ${base_date_raw} < ${period_3_end}
        THEN TIMESTAMP_DIFF(${base_date_raw}, ${period_3_start},DAY)+1

      END
    {% endif %}

    ;;
    hidden: yes
  }

  dimension: period_2_start {
    description: "Calculates the start of the previous period"
    type: date_raw
    sql:

    {% if select_date_range._in_query %}
      {% if select_comparison_period._parameter_value == "Period" %}
        TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL ${days_in_period} DAY)
      {% elsif select_comparison_period._parameter_value == "Year" %}
        TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL 364 DAY)
      {% else %}
        TIMESTAMP(DATETIME_SUB(DATETIME({% date_start select_date_range %}) , INTERVAL 1 {% parameter select_comparison_period %}))
      {% endif %}
    {% else %}
      {% date_start select_date_range %}
    {% endif %}

    ;;
    hidden:  yes
    }

    dimension: period_2_end {
      description: "Calculates the end of the previous period"
      type: date_raw
      sql:

          {% if select_date_range._in_query %}
            {% if select_comparison_period._parameter_value == "Period" %}
              TIMESTAMP_SUB({% date_start select_date_range %}, INTERVAL 0 DAY)
            {% elsif select_comparison_period._parameter_value == "Year" %}
              TIMESTAMP_SUB({% date_end select_date_range %} , INTERVAL 364 DAY)
            {% else %}
              TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end select_date_range %}), INTERVAL 0 DAY), INTERVAL 1 {% parameter select_comparison_period %}))
            {% endif %}
          {% else %}
            {% date_end select_date_range %}
          {% endif %}

          ;;
          hidden:  yes
      }

      dimension: period_3_start {
        description: "Calculates the start of 2 periods ago"
        type: date_raw
        sql:

            {% if select_comparison_period._parameter_value == "Period" %}
              TIMESTAMP_SUB({% date_start select_date_range %}, INTERVAL 2*${days_in_period} DAY)
            {% elsif select_comparison_period._parameter_value == "Year" %}
                TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL 364*2 DAY)
            {% else %}
              TIMESTAMP(DATETIME_SUB(DATETIME({% date_start select_date_range %}), INTERVAL 2 {% parameter select_comparison_period %}))
            {% endif %}

            ;;
        hidden: yes
      }

      dimension: period_3_end {
        description: "Calculates the end of 2 periods ago"
        type: date_raw
        sql:


            {% if select_comparison_period._parameter_value == "Period" %}
              TIMESTAMP_SUB(${period_2_start}, INTERVAL 0 DAY)
            {% elsif select_comparison_period._parameter_value == "Year" %}
                TIMESTAMP_SUB({% date_end select_date_range %} , INTERVAL 364*2 DAY)
            {% else %}
              TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end select_date_range %}), INTERVAL 0 DAY), INTERVAL 2 {% parameter select_comparison_period %}))
            {% endif %}

            ;;
        hidden: yes
      }

      # FIXED PERIOD ON PERIOD

      dimension: __current_date__ {
        type: date
        datatype: date
        sql:

            CURRENT_DATE() - 1

            ;;
        hidden: yes
      }
      dimension: __length_of_year__ {
        type: number
        sql:

            364

            ;;
        hidden: yes
      }
  dimension: __length_of_week__ {
    type: number
    sql:

            7

            ;;
    hidden: yes
  }

      dimension: __target_raw__ {
        type: date
        datatype: datetime
        sql:

            ${base.base_date_raw}

            ;;
            hidden: yes
      }

      dimension: __target_date__ {
        type: date
        datatype: date
        sql:

            ${__target_raw__}

            ;;
        hidden: yes
      }







  dimension: order_for_period {
    hidden: yes
    view_label: "Period Comparison Fields"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period', 'Previous Period' or '3 Periods Ago'"
    type: string
    sql:

      {% if select_number_of_periods._is_filtered or select_comparison_period._in_query and select_date_range._in_query %}
        CASE
          WHEN {% condition select_date_range %} ${base_date_raw} /*findme6*/{% endcondition %}
          THEN 1
          WHEN ${base_date_raw} >= ${period_2_start} and ${base_date_raw} < ${period_2_end}
          THEN 2
          WHEN ${base_date_raw} >= ${period_3_start} and ${base_date_raw} < ${period_3_end}
          THEN 3
        END

      {% else %}

        ${base_date_raw}

      {% endif %}

      ;;
  }

      dimension: previous_full_day {
        type: yesno
        sql:

            ${__target_date__} = ${__current_date__}

            ;;
        hidden: yes
      }
      dimension: previous_full_day_LW {
        type: yesno
        sql:

        ${__target_date__} = ${__current_date__} - ${__length_of_week__}

        ;;
        hidden: yes
      }
      dimension: previous_full_day_LM {
        type: yesno
        sql:

        ${__target_date__} = ${__current_date__} - 29

        ;;
        hidden: yes
      }
      dimension: previous_full_day_LY {
        type: yesno
        sql:

            ${__target_date__} = ${__current_date__} - ${__length_of_year__}

            ;;
        hidden: yes
      }
      dimension: previous_full_day_2LY {
        type: yesno
        sql:

            ${__target_date__} = ${__current_date__} - (${__length_of_year__} * 2)

            ;;
        hidden: yes
      }
      dimension: week_to_date {
        type: yesno
        sql:

            EXTRACT(DAYOFWEEK FROM ${__target_date__}) <= EXTRACT(DAYOFWEEK FROM ${__current_date__})
            AND (${__target_date__} > ${__current_date__} - 7) AND (${__target_date__} <= ${__current_date__})

            ;;
        hidden: yes
      }
      dimension: week_to_date_LY {
        type:  yesno
        sql:

            (
              EXTRACT(DAYOFWEEK FROM ${__target_date__}) <= EXTRACT(DAYOFWEEK FROM (${__current_date__} - (${__length_of_year__} + 6)))
              AND ${__target_date__} > ${__current_date__} - (${__length_of_year__} + 6) -- ${__length_of_year__} + 6 (DUE TO BEING AT MOST 6 DAYS PRIOR FOR EQUIVALENT WTD)
              AND ${__target_date__} <= ${__current_date__} - ${__length_of_year__} -- ${__length_of_year__} AS COULD NOT BE ANY 'NEWER' THAN 6 DAYS DUE TO WTD
            )

            ;;
        hidden: yes
      }
      dimension: week_to_date_2LY {
        type: yesno
        sql:

            (
              EXTRACT(DAYOFWEEK FROM ${__target_date__}) <= EXTRACT(DAYOFWEEK FROM (${__current_date__} - ((${__length_of_year__} * 2) + 6)))
              AND ${__target_date__} > ${__current_date__} - ((${__length_of_year__} * 2) + 6) -- ${__length_of_year__} + 6 (DUE TO BEING AT MOST 6 DAYS PRIOR FOR EQUIVALENT WTD)
              AND ${__target_date__} <= ${__current_date__} - (${__length_of_year__} * 2) -- ${__length_of_year__} AS COULD NOT BE ANY 'NEWER' THAN 6 DAYS DUE TO WTD
            )

            ;;
        hidden: yes
      }
      dimension: month_to_date {
        type: yesno
        sql:

            ${__target_date__} > ${__current_date__} - EXTRACT(DAY FROM ${__current_date__}) AND ${__target_date__} <= ${__current_date__}

            ;;
        hidden: yes
      }
      dimension: month_to_date_LY {
        type: yesno
        sql:

            (
              ${__target_date__} <= ${__current_date__} - ${__length_of_year__}
              AND ${__target_date__} > DATE(${__current_date__} - (EXTRACT(DAY FROM ${__current_date__}) + 0)) - ${__length_of_year__}
            )

            ;;
        hidden: yes
      }
      dimension: month_to_date_2LY {
        type: yesno
        sql:

            (
              ${__target_date__} <= ${__current_date__} - (${__length_of_year__} * 2)
              AND ${__target_date__} > DATE(${__current_date__} - (EXTRACT(DAY FROM ${__current_date__}) + 0)) - (${__length_of_year__} * 2)
            )

            ;;
        hidden: yes
      }

      # TODO _ quarter_to_date

      dimension: year_to_date {
        type: yesno
        sql:

            (${__target_date__} >= DATE(EXTRACT(YEAR FROM ${__current_date__}), 1, 1))  AND (${__target_date__} <= ${__current_date__})

            ;;
        hidden: yes

      }
      dimension: year_to_date_LY {
        type: yesno
        sql:

            (
              ${__target_date__} <= ${__current_date__} - ${__length_of_year__}
              AND ${__target_date__} >= DATE(EXTRACT(YEAR FROM ${__current_date__}), 1, 1) - ${__length_of_year__}
            )

            ;;
        hidden: yes
      }
      dimension: year_to_date_2LY {
        type: yesno
        sql:

            ${year_to_date}
            OR
            (
              ${__target_date__} <= ${__current_date__} - (${__length_of_year__} * 2)
              AND ${__target_date__} >= DATE(EXTRACT(YEAR FROM ${__current_date__}), 1, 1) - (${__length_of_year__} * 2)
            )

            ;;
        hidden: yes
      }

      filter: pivot_period {
        required_access_grants: [is_developer]
        type:  yesno
        hidden: yes
        sql:

        {% if select_fixed_range._in_query %}

          {% if select_fixed_range._parameter_value == "PD" %}

            {% if select_comparison_period._parameter_value == "Period" %}
                ${previous_full_day}
            {% elsif select_comparison_period._parameter_value == "Week" %}
              ${previous_full_day} OR ${previous_full_day_LW}
            {% elsif select_comparison_period._parameter_value == "Month" %}
              ${previous_full_day} OR ${previous_full_day_LM}
            {% elsif select_comparison_period._parameter_value == "Quarter" %}
            {% elsif select_comparison_period._parameter_value == "Year" %}

              {% if select_number_of_periods._parameter_value == "3" %}
              ${previous_full_day} OR ${previous_full_day_LY} OR ${previous_full_day_2LY}
              {% else %}
                ${previous_full_day} OR ${previous_full_day_LY}
              {% endif %}

            {% elsif select_comparison_period._parameter_value == "2YearsAgo" %}
              ${previous_full_day} OR ${previous_full_day_2LY}
            {% else %}
              ${previous_full_day}
            {% endif %}

          {% elsif select_fixed_range._parameter_value == "WTD" %}

            {% if select_comparison_period._parameter_value == "Period" %}
                ${week_to_date}
            {% elsif select_comparison_period._parameter_value == "Week" %}
            {% elsif select_comparison_period._parameter_value == "Month" %}
            {% elsif select_comparison_period._parameter_value == "Quarter" %}
            {% elsif select_comparison_period._parameter_value == "Year" %}

              {% if select_number_of_periods._parameter_value == "3" %}
                ${week_to_date} OR ${week_to_date_LY} OR ${week_to_date_2LY}
              {% else %}
                ${week_to_date} OR ${week_to_date_LY}
              {% endif %}

            {% elsif select_comparison_period._parameter_value == "2YearsAgo" %}
              ${week_to_date} OR ${week_to_date_2LY}
            {% else %}
              ${week_to_date}
            {% endif %}

          {% elsif select_fixed_range._parameter_value == "MTD" %}

            {% if select_comparison_period._parameter_value == "Period" %}
                ${month_to_date}
            {% elsif select_comparison_period._parameter_value == "Week" %}
            {% elsif select_comparison_period._parameter_value == "Month" %}
            {% elsif select_comparison_period._parameter_value == "Quarter" %}
            {% elsif select_comparison_period._parameter_value == "Year" %}

              {% if select_number_of_periods._parameter_value == "3" %}
                ${month_to_date} OR ${month_to_date_LY} OR ${month_to_date_2LY}
              {% else %}
                ${month_to_date} OR ${month_to_date_LY}
              {% endif %}

            {% elsif select_comparison_period._parameter_value == "2YearsAgo" %}
              ${month_to_date} OR ${month_to_date_2LY}
            {% else %}
              ${week_to_date}
            {% endif %}
          {% elsif select_fixed_range._parameter_value == "YTD" %}

            {% if select_comparison_period._parameter_value == "Period" %}
                ${year_to_date}
            {% elsif select_comparison_period._parameter_value == "Week" %}
            {% elsif select_comparison_period._parameter_value == "Month" %}
            {% elsif select_comparison_period._parameter_value == "Quarter" %}
            {% elsif select_comparison_period._parameter_value == "Year" %}

              {% if select_number_of_periods._parameter_value == "3" %}
                ${year_to_date} OR ${year_to_date_LY} OR ${year_to_date_2LY}
              {% else %}
                ${year_to_date} OR ${year_to_date_LY}
              {% endif %}

            {% elsif select_comparison_period._parameter_value == "2YearsAgo" %}
              ${year_to_date} OR ${year_to_date_2LY}
            {% else %}
              ${year_to_date}
            {% endif %}

          {% else %}
          false
          {% endif %}

        {% else %}
          false
        {% endif %}

            ;;

    }
  }
