include: "/views/prod/date/fixed_PoP.view"

view: period_on_period_new {

  extension: required
  extends: [fixed_period_on_period,flexible_period_on_period]

  filter: master_pop {
    required_access_grants: [is_developer]
    view_label: "UNDER DEVELOPMENT"
    hidden: no # in always_where
    type: yesno
    sql:

    {%if fixed_in_query %}

        true

    {% else %}
      false

    {% endif %}

    ;;
  }

  filter: select_date_range {
    required_access_grants: [is_developer]
    view_label: "UNDER DEVELOPMENT"
    type: date
    convert_tz: yes
  }
  parameter: select_fixed_range {
    required_access_grants: [is_developer]
    view_label: "UNDER DEVELOPMENT"
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
    required_access_grants: [is_developer]
    view_label: "UNDER DEVELOPMENT"
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
    allowed_value: {
      label: "2 Years Ago"
      value: "2YearsAgo"
    }
    allowed_value: {
      label: "Previous 2 Years"
      value: "2 Year"
    }
    default_value: "Period"
  }
  parameter: select_number_of_periods {
    required_access_grants: [is_developer]
    view_label: "UNDER DEVELOPMENT"
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
  dimension: pivot_dimension {
    required_access_grants: [is_developer]
    view_label: "UNDER DEVELOPMENT"
    type: string
    # order_by_field:
    sql:

    {% if true %}
      "Hello"
    {% else %}
      "Goodbye"
    {% endif %}

    ;;
  }
}

view: flexible_period_on_period{

  extension: required

  dimension: flexible_in_query {
    required_access_grants: [is_developer]
    view_label: "UNDER DEVELOPMENT"
    type: yesno
    sql:

    {% if false %}
      true
    {% else %}
      false
    {% endif %}

    ;;
    hidden: no
  }

  filter: flexi_pop {
    required_access_grants: [is_developer]
    type: yesno
    sql:

    {% if transactions.current_date_range._is_filtered %}
     {% condition transactions.current_date_range %} ${transaction_date_coalesce_raw} {% endcondition %}

       {% if transactions.previous_date_range._is_filtered or transactions.compare_to._in_query %}
         {% if transactions.comparison_periods._parameter_value == "2" %}

            or ${transaction_date_coalesce_raw} between ${period_2_start} and ${period_2_end}

          {% elsif transactions.comparison_periods._parameter_value == "3" %}
             or ${transaction_date_coalesce_raw} between ${period_2_start} and ${period_2_end}
             or ${transaction_date_coalesce_raw} between ${period_3_start} and ${period_3_end}

         {% endif %}

       {% endif %}

    {% endif %}

    ;;
    hidden: yes
  }

}

view: fixed_period_on_period {

  extension: required

  dimension: fixed_in_query {
    required_access_grants: [is_developer]
    view_label: "UNDER DEVELOPMENT"
    type: yesno
    sql:

    {% if period_to_date._is_filtered or previous_period_to_date._is_filtered %}
      true
    {% else %}
      false
    {% endif %}

    ;;
    hidden: no
}

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
  dimension: __target_date__ {
    type: date
    datatype: date
    sql:

    DATE(${transaction_date_coalesce_raw})

    ;;
    hidden: yes
  }
  dimension: __target_year__ {
    required_access_grants: [is_developer]
    view_label: "UNDER DEVELOPMENT"
    group_label: "PoP Date"
    label: "Year"
    can_filter: no
    sql:

    EXTRACT(YEAR FROM ${__target_date__})

    ;;
    hidden: no
  }
  dimension: __target_week__ {
    required_access_grants: [is_developer]
    view_label: "UNDER DEVELOPMENT"
    group_label: "PoP Date"
    label: "Week"
    can_filter: no
    sql:

    EXTRACT(WEEK FROM ${__target_date__})

    ;;
  }

  dimension: previous_full_day {
    type: yesno
    sql:

    ${__target_date__} = ${__current_date__}

    ;;
    hidden: yes
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

  # dimension: current_period {
  #   type: yesno
  #   sql:

  #   ${__target_date__} >= DATE({%date_start __filtered_date__%}) and ${__target_date__} < DATE({%date_end __filtered_date__%})

  #   ;;
  #   hidden: yes
  # } #!
  # dimension: current_period_LY {
  #   type: yesno
  #   sql:

  #   ${current_period}
  #   OR
  #   (
  #     ${__target_date__} <= DATE({%date_end __filtered_date__%}) - ${__length_of_year__}
  #     AND ${__target_date__} >= DATE({% date_start __filtered_date__ %}) - ${__length_of_year__}
  #   )

  #   ;;
  #   hidden: yes
  # } #!
  # dimension: current_period_2LY {
  #   type: yesno
  #   sql:

  #   ${current_period}
  #   OR
  #   (
  #     ${__target_date__} <= DATE({%date_end __filtered_date__%}) - (${__length_of_year__} * 2)
  #     AND ${__target_date__} >= DATE({% date_start __filtered_date__ %}) - (${__length_of_year__} * 2)
  #   )

  #   ;;
  #   hidden: yes
  # } #!

  parameter: period_to_date{
    required_access_grants: [is_developer]
    view_label: "Period on Period"
    group_label: "Period Comparison"
    label: "Period to Date"
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
    # allowed_value: {
    #   label: "Custom Period (add filter)"
    #   value: "CP"
    # }
    # default_value: "PD"
  }
  parameter: previous_period_to_date {
    required_access_grants: [is_developer]
    view_label: "Period on Period"
    group_label: "Period Comparison"
    label: "Number of Period(s):"
    type: unquoted
    allowed_value: {
      label: "Last Week - PREVIOUS DAY ONLY"
      value: "LW"
    }
    allowed_value: {
      label: "Last Month - PREVIOUS DAY ONLY"
      value: "LM"
    }
    allowed_value: {
      label: "Current Year"
      value: "CY"
    }
    allowed_value: {
      label: "Last Year"
      value: "LY"
    }
    allowed_value: {
      label: "2 Years Ago"
      value: "2LY"
    }
    allowed_value: {
      label: "Last 2 Years"
      value: "LY2LY"
    }
    # default_value: "CY"
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

    {% if period_to_date._in_query %}

      {% if period_to_date._parameter_value == "PD" %}

        {% if previous_period_to_date._parameter_value == "CY" %}

          ${previous_full_day}

        {% elsif previous_period_to_date._parameter_value == "LY" %}

          ${previous_full_day_LY}

        {% elsif previous_period_to_date._parameter_value == "2LY" %}

          ${previous_full_day_2LY}

        {% elsif previous_period_to_date._parameter_value == "LY2LY" %}

          ${previous_full_day_LY} OR ${previous_full_day_2LY}

        {% else %}

          ${previous_full_day}

        {% endif %}

      {% elsif period_to_date._parameter_value == "WTD" %}

        {% if previous_period_to_date._parameter_value == "CY" %}

          ${week_to_date}

        {% elsif previous_period_to_date._parameter_value == "LY" %}

          ${week_to_date_LY}

        {% elsif previous_period_to_date._parameter_value == "2LY" %}

          ${week_to_date_2LY}

        {% elsif previous_period_to_date._parameter_value == "LY2LY" %}

          ${week_to_date_LY} OR ${week_to_date_2LY}

        {% else %}

          ${week_to_date}

        {% endif %}

      {% elsif period_to_date._parameter_value == "MTD" %}

        {% if previous_period_to_date._parameter_value == "CY" %}

          ${month_to_date}

        {% elsif previous_period_to_date._parameter_value == "LY" %}

          ${month_to_date_LY}

        {% elsif previous_period_to_date._parameter_value == "2LY" %}

          ${month_to_date_2LY}

        {% elsif previous_period_to_date._parameter_value == "LY2LY" %}

          ${month_to_date_LY} OR ${month_to_date_2LY}

        {% else %}

          ${month_to_date}

        {% endif %}

      {% elsif period_to_date._parameter_value == "YTD" %}

        {% if previous_period_to_date._parameter_value == "CY" %}

          ${year_to_date}

        {% elsif previous_period_to_date._parameter_value == "LY" %}

          ${year_to_date_LY}

        {% elsif previous_period_to_date._parameter_value == "2LY" %}

          ${year_to_date_2LY}

        {% elsif previous_period_to_date._parameter_value == "LY2LY" %}

          ${year_to_date_LY} OR ${year_to_date_2LY}

        {% else %}

          ${year_to_date}

        {% endif %}



    {% endif %}

    {% else %}

    true

    {%endif%}

    ;;
  }

  # {% elsif period_to_date._parameter_value == "CP" %}

  #       {% if __filtered_date__._is_filtered %}

  #         {% if previous_period_to_date._parameter_value == "CY" %}

  #           ${current_period}

  #         {% elsif previous_period_to_date._parameter_value == "LY" %}

  #           ${current_period_LY}

  #         {% elsif previous_period_to_date._parameter_value == "2LY" %}

  #           ${current_period_2LY}

  #         {% elsif previous_period_to_date._parameter_value == "LY2LY" %}

  #           ${current_period_LY} OR ${current_period_2LY}

  #         {% endif %}


}

# to combine both PoP eventually here
