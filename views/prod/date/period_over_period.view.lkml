# include: "/views/prod/date/fixed_PoP.view"

view: period_on_period_new {

  extension: required

  filter: period_over_period {
    required_access_grants: [is_developer]
    view_label: "UNDER DEVELOPMENT"
    hidden: yes # in always_where
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
    view_label: "Date - DEV"
    type: date
    convert_tz: yes
  }
  parameter: select_fixed_range {
    required_access_grants: [is_developer]
    view_label: "Date - DEV"
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
    # allowed_value: {
    #   label: "Quarter to Date (QTD)"
    #   value: "QTD"
    # }
    allowed_value: {
      label: "Year to Date (YTD)"
      value: "YTD"
    }
  }
  parameter: select_comparison_period {
    view_label: "Date - DEV"
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
    # allowed_value: {
    #   label: "Previous 2 Year"
    #   value: "2YearsAgo"
    # }
    # allowed_value: {
    #   label: "Previous 2 Years"
    #   value: "2 Year"
    # }
    default_value: "Period"
  }
  parameter: select_number_of_periods {
    view_label: "Date - DEV"
    type: unquoted
    # allowed_value: {
    #   label: "Current Period"
    #   value: "1"
    # }
    allowed_value: {
      label: "1 Period Ago"
      value: "2"
    }
    allowed_value: {
      label: "2 Periods Ago"
      value: "3"
    }
    # allowed_value: {
    #   label: "4"
    #   value: "4"
    # }

    default_value: "2"
  }
  dimension: pivot_dimension {
    view_label: "Date - DEV"
    type: string
    # order_by_field:
    sql:

     {% if select_date_range._is_filtered %}
        CASE
          WHEN {% condition select_date_range %}  ${base_date_raw} {% endcondition %}
          THEN "This {% parameter select_fixed_range %}"
          WHEN ${base_date_raw} >= ${period_2_start} and ${base_date_raw} < ${period_2_end}
          THEN "Last {% parameter select_fixed_range %}"
          WHEN ${base_date_raw}  >= ${period_3_start} and ${base_date_raw} < ${period_3_end}
          THEN "2 {% parameter select_fixed_range %}s Ago"

        END
      {% elsif select_fixed_range._is_filtered %}
        "TBC"
      {% else %}
        NULL
      {% endif %}

    ;;
  }

# FLEXIBLE PERIOD ON PERIOD

  filter: flexi_pop {
    required_access_grants: [is_developer]
    type: yesno
    sql:

    {% condition base.select_date_range %} ${base.base_date_raw} {% endcondition %}

      {% if base.select_date_range._is_filtered or base.select_fixed_range._in_query %}
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
    view_label: "Period Comparison Fields"
    type: duration
    intervals: [day]
    description: "Gives the number of days in the current period date range"
    sql_start: {% date_start select_date_range %} ;;
    sql_end: {% date_end select_date_range %} ;;
    # hidden:  yes
  }



  dimension: period_2_start {
    view_label: "Period Comparison Fields"
    description: "Calculates the start of the previous period"
    type: date_raw
    sql:
    {% if select_fixed_range._in_query %}
      {% if select_fixed_range._parameter_value == "Period" %}
        TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL ${days_in_period} DAY)
      {% elsif select_fixed_range._parameter_value == "Year" %}
        TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL 364 DAY)
      {% else %}
        TIMESTAMP(DATETIME_SUB(DATETIME({% date_start select_date_range %}) , INTERVAL 1 {% parameter select_fixed_range %}))
      {% endif %}
    {% else %}
      {% date_start select_date_range %}
    {% endif %};;
    # hidden:  yes
    }

    dimension: period_2_end {
      view_label: "Period Comparison Fields"
      description: "Calculates the end of the previous period"
      type: date_raw
      sql:
          {% if select_fixed_range._in_query %}
            {% if select_fixed_range._parameter_value == "Period" %}
              TIMESTAMP_SUB({% date_start select_date_range %}, INTERVAL 1 DAY)
            {% elsif select_fixed_range._parameter_value == "Year" %}
              TIMESTAMP_SUB({% date_end select_date_range %} , INTERVAL 364 DAY)
            {% else %}
              TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end select_date_range %}), INTERVAL 0 DAY), INTERVAL 1 {% parameter select_fixed_range %}))
            {% endif %}
          {% else %}
            {% date_end select_date_range %}
          {% endif %};;
          # hidden:  yes
      }

      dimension: period_3_start {
        view_label: "Period Comparison Fields"
        description: "Calculates the start of 2 periods ago"
        type: date_raw
        sql:
            {% if select_fixed_range._parameter_value == "Period" %}
              TIMESTAMP_SUB({% date_start select_date_range %}, INTERVAL 2*${days_in_period} DAY)
            {% elsif select_fixed_range._parameter_value == "Year" %}
                TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL 364*2 DAY)
            {% else %}
              TIMESTAMP(DATETIME_SUB(DATETIME({% date_start select_date_range %}), INTERVAL 2 {% parameter select_fixed_range %}))
            {% endif %};;
        hidden: no
      }

      dimension: period_3_end {
        view_label: "Period Comparison Fields"
        description: "Calculates the end of 2 periods ago"
        type: date_raw
        sql:
            {% if select_fixed_range._parameter_value == "Period" %}
              TIMESTAMP_SUB(${period_2_start}, INTERVAL 1 DAY)
            {% elsif select_fixed_range._parameter_value == "Year" %}
                TIMESTAMP_SUB({% date_end select_date_range %} , INTERVAL 364*2 DAY)
            {% else %}
              TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end select_date_range %}), INTERVAL 0 DAY), INTERVAL 2 {% parameter select_fixed_range %}))
            {% endif %};;
        hidden: no
      }

      # FIXED PERIOD ON PERIOD

      dimension: __current_date__ {
        type: date
        datatype: date
        sql:

            DATE(CURRENT_DATE() - 1)

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
      }

      dimension: __target_date__ {
        type: date
        datatype: date
        sql:

            ${__target_raw__}

            ;;
        hidden: yes
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

        ${__target_date__} = ${__current_date__} - __length_of_week__

        ;;
      }
      dimension: previous_full_day_LY {
        type: yesno
        sql:

            ${previous_full_day}
            OR
            ${__target_date__} = ${__current_date__} - ${__length_of_year__}

            ;;
        hidden: yes
      }
      dimension: previous_full_day_2LY {
        type: yesno
        sql:

            ${previous_full_day}
            OR
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

            ${week_to_date}
            OR
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

            ${week_to_date}
            OR
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

            ${month_to_date}
            OR
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

            ${month_to_date}
            OR
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

            ${year_to_date}
            OR
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
        view_label: "Period on Period"
        group_label: "Period Comparison"
        label: "Run Filter"
        description: "Must be included to enable PoP."
        type:  yesno
        hidden: no
        sql:

        {% if select_fixed_range._in_query %}

          {% if select_fixed_range._parameter_value == "PD" %}

            {% if select_comparison_period._parameter_value == "Period" %}
                ${previous_full_day}
            {% elsif select_comparison_period._parameter_value == "Week" %}
            {% elsif select_comparison_period._parameter_value == "Month" %}
            {% elsif select_comparison_period._parameter_value == "Quarter" %}
            {% elsif select_comparison_period._parameter_value == "Year" %}

              {% if select_number_of_periods._parameter_value == "3" %}
                ${previous_full_day_LY} OR ${previous_full_day_2LY}
              {% else %}
                ${previous_full_day_LY}
              {% endif %}

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
                ${week_to_date_LY} OR ${week_to_date_2LY}
              {% else %}
                ${week_to_date_LY}
              {% endif %}

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
                ${month_to_date_LY} OR ${month_to_date_2LY}
              {% else %}
                ${month_to_date_LY}
              {% endif %}

            {% else %}
              ${week_to_date}
            {% endif %}
          {% elsif select_fixed_range._parameter_value == "QTD" %}
          {% elsif select_fixed_range._parameter_value == "YTD" %}

            {% if select_comparison_period._parameter_value == "Period" %}
                ${week_to_date}
            {% elsif select_comparison_period._parameter_value == "Week" %}
            {% elsif select_comparison_period._parameter_value == "Month" %}
            {% elsif select_comparison_period._parameter_value == "Quarter" %}
            {% elsif select_comparison_period._parameter_value == "Year" %}

              {% if select_number_of_periods._parameter_value == "3" %}
                ${year_to_date_LY} OR ${year_to_date_2LY}
              {% else %}
                ${year_to_date_LY}
              {% endif %}

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
