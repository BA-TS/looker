view: period_on_period {

  extension: required


# ██╗░░░██╗░█████╗░██████╗░██╗░█████╗░██████╗░██╗░░░░░███████╗░██████╗
# ██║░░░██║██╔══██╗██╔══██╗██║██╔══██╗██╔══██╗██║░░░░░██╔════╝██╔════╝
# ╚██╗░██╔╝███████║██████╔╝██║███████║██████╦╝██║░░░░░█████╗░░╚█████╗░
# ░╚████╔╝░██╔══██║██╔══██╗██║██╔══██║██╔══██╗██║░░░░░██╔══╝░░░╚═══██╗
# ░░╚██╔╝░░██║░░██║██║░░██║██║██║░░██║██████╦╝███████╗███████╗██████╔╝
# ░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝╚══════╝╚═════╝░

  dimension: __current_timestamp__ {
    type: date_time
    datatype: datetime
    sql:

    CURRENT_DATE() - 1

    ;;
    hidden: yes
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
  dimension: __target_timestamp__ {
    type: date
    datatype: datetime
    sql:

    ${transaction_date_coalesce}

    ;;
    hidden: yes
  }
  dimension: __target_date__ {
    type: date
    datatype: date
    sql:

    DATE(${transaction_date_coalesce})

    ;;
    hidden: yes
  }
  dimension: __target_year__ {
    view_label: "Calendar - Completed Date"
    group_label: "Transaction Date"
    label: "Year"
    can_filter: no
    sql:

    EXTRACT(YEAR FROM ${__target_date__})

    ;;
    hidden: no
  }


# ██╗░░██╗██╗██████╗░██████╗░███████╗███╗░░██╗
# ██║░░██║██║██╔══██╗██╔══██╗██╔════╝████╗░██║
# ███████║██║██║░░██║██║░░██║█████╗░░██╔██╗██║
# ██╔══██║██║██║░░██║██║░░██║██╔══╝░░██║╚████║
# ██║░░██║██║██████╔╝██████╔╝███████╗██║░╚███║
# ╚═╝░░╚═╝╚═╝╚═════╝░╚═════╝░╚══════╝╚═╝░░╚══╝

# ██████╗░██╗███╗░░░███╗███████╗███╗░░██╗░██████╗██╗░█████╗░███╗░░██╗░██████╗
# ██╔══██╗██║████╗░████║██╔════╝████╗░██║██╔════╝██║██╔══██╗████╗░██║██╔════╝
# ██║░░██║██║██╔████╔██║█████╗░░██╔██╗██║╚█████╗░██║██║░░██║██╔██╗██║╚█████╗░
# ██║░░██║██║██║╚██╔╝██║██╔══╝░░██║╚████║░╚═══██╗██║██║░░██║██║╚████║░╚═══██╗
# ██████╔╝██║██║░╚═╝░██║███████╗██║░╚███║██████╔╝██║╚█████╔╝██║░╚███║██████╔╝
# ╚═════╝░╚═╝╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

# PREVIOUS DAY

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
  dimension: previous_full_day_LW {
    type: yesno
    sql:

    ${previous_full_day}
    OR
    ${__target_date__} = (${__current_date__} - 7)

    ;;
    hidden: yes
  } # TODO
  dimension: previous_full_day_LM {
    type: yesno
    sql:

    ${previous_full_day}
    OR
    ${__target_date__} = (${__current_date__} - 0) -- TODO !

    ;;
    hidden: yes
  } # TODO

# WEEK TO DATE

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

# MONTH TO DATE

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

# YEAR TO DATE

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

# PREVIOUS PERIOD

  dimension: current_period {
    type: yesno
    sql:

    ${__target_date__} >= DATE({%date_start __filtered_date__%}) and ${__target_date__} < DATE({%date_end __filtered_date__%})

    ;;
    hidden: yes
  }
  dimension: current_period_LY {
    type: yesno
    sql:

    ${current_period}
    OR
    (
      ${__target_date__} <= DATE({%date_end __filtered_date__%}) - ${__length_of_year__}
      AND ${__target_date__} >= DATE({% date_start __filtered_date__ %}) - ${__length_of_year__}
    )

    ;;
    hidden: yes
  }
  dimension: current_period_2LY {
    type: yesno
    sql:

    ${current_period}
    OR
    (
      ${__target_date__} <= DATE({%date_end __filtered_date__%}) - (${__length_of_year__} * 2)
      AND ${__target_date__} >= DATE({% date_start __filtered_date__ %}) - (${__length_of_year__} * 2)
    )

    ;;
    hidden: yes
  }


# ██╗░░░██╗██╗░██████╗██╗██████╗░██╗░░░░░███████╗
# ██║░░░██║██║██╔════╝██║██╔══██╗██║░░░░░██╔════╝
# ╚██╗░██╔╝██║╚█████╗░██║██████╦╝██║░░░░░█████╗░░
# ░╚████╔╝░██║░╚═══██╗██║██╔══██╗██║░░░░░██╔══╝░░
# ░░╚██╔╝░░██║██████╔╝██║██████╦╝███████╗███████╗
# ░░░╚═╝░░░╚═╝╚═════╝░╚═╝╚═════╝░╚══════╝╚══════╝

# ██████╗░██╗███╗░░░███╗███████╗███╗░░██╗░██████╗██╗░█████╗░███╗░░██╗░██████╗
# ██╔══██╗██║████╗░████║██╔════╝████╗░██║██╔════╝██║██╔══██╗████╗░██║██╔════╝
# ██║░░██║██║██╔████╔██║█████╗░░██╔██╗██║╚█████╗░██║██║░░██║██╔██╗██║╚█████╗░
# ██║░░██║██║██║╚██╔╝██║██╔══╝░░██║╚████║░╚═══██╗██║██║░░██║██║╚████║░╚═══██╗
# ██████╔╝██║██║░╚═╝░██║███████╗██║░╚███║██████╔╝██║╚█████╔╝██║░╚███║██████╔╝
# ╚═════╝░╚═╝╚═╝░░░░░╚═╝╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

  dimension: period_comparator{
    view_label: "Calendar - Completed Date"
    group_label: "Transaction Date"
    label: "Period Comparator"
    type: string
    order_by_field: __target_year__
    can_filter: no
    hidden: yes # TO FIX THIS FIRST
    sql:

    {% if pivot_period._is_filtered %}

      {% if period_to_date._parameter_value == "PD" %}

        CASE

          WHEN ${__target_date__} < ${__current_date__} and ${__target_date__} > (${__current_date__} - 7)
            THEN "This Week"

          WHEN ${__target_date__} < ${__current_date__} - 7 and ${__target_date__} > (${__current_date__} - 14)
            THEN "Last Week"

          WHEN false -- TODO
            THEN "Last Month"

          WHEN EXTRACT(YEAR FROM ${__target_date__} + ${__length_of_year__}) = EXTRACT(YEAR FROM ${__current_date__})
            THEN "LY"

          WHEN EXTRACT(YEAR FROM ${__target_date__} + ${__length_of_year__} * 2) = EXTRACT(YEAR FROM ${__current_date__})
            THEN "2LY"

          ELSE "FAILED"

        END

      {% else %}

        CASE

          WHEN EXTRACT(YEAR FROM ${__target_date__}) = EXTRACT(YEAR FROM ${__current_date__})
          THEN "CY"

          WHEN EXTRACT(YEAR FROM ${__target_date__} + ${__length_of_year__}) = EXTRACT(YEAR FROM ${__current_date__})
          THEN "LY"

          WHEN EXTRACT(YEAR FROM ${__target_date__} + ${__length_of_year__} * 2) = EXTRACT(YEAR FROM ${__current_date__})
          THEN "2LY"

          ELSE "FAILED"

        END

      {% endif %}

    {%else%}

      NULL

    {%endif%}

    ;;
  }
  dimension: period_enabled_transaction_date {
    view_label: "Calendar - Completed Date"
    group_label: "Transaction Date"
    label: "Date"
    type: date
    can_filter: no
    hidden: no
    sql:

    {% if __target_year__._in_query %}

      CASE

        WHEN EXTRACT(YEAR FROM ${__target_date__}) = EXTRACT(YEAR FROM ${__current_date__}) - 1
        THEN ${__target_date__} + ${__length_of_year__}

        WHEN EXTRACT(YEAR FROM ${__target_date__}) = EXTRACT(YEAR FROM ${__current_date__}) - 2
        THEN ${__target_date__} + ${__length_of_year__} * 2

        ELSE ${__target_date__}

      END

    {% else %}

      ${__target_date__}

    {% endif %}

    ;; # if pivot on year, then merge dates otherwise keep to actual

    # need to include more validation i.e. return target_date unless LY, 2LY    # pivot_period._in_query and
    #  previous_period_to_date._parameter_value == "LY" or previous_period_to_date._parameter_value == "2LY" or previous_period_to_date._parameter_value == "LY2LY"
  }



# ██╗░░░██╗██╗░██████╗██╗██████╗░██╗░░░░░███████╗     ███████╗██╗██╗░░░░░████████╗███████╗██████╗░░██████╗
# ██║░░░██║██║██╔════╝██║██╔══██╗██║░░░░░██╔════╝     ██╔════╝██║██║░░░░░╚══██╔══╝██╔════╝██╔══██╗██╔════╝
# ╚██╗░██╔╝██║╚█████╗░██║██████╦╝██║░░░░░█████╗░░     █████╗░░██║██║░░░░░░░░██║░░░█████╗░░██████╔╝╚█████╗░
# ░╚████╔╝░██║░╚═══██╗██║██╔══██╗██║░░░░░██╔══╝░░     ██╔══╝░░██║██║░░░░░░░░██║░░░██╔══╝░░██╔══██╗░╚═══██╗
# ░░╚██╔╝░░██║██████╔╝██║██████╦╝███████╗███████╗     ██║░░░░░██║███████╗░░░██║░░░███████╗██║░░██║██████╔╝
# ░░░╚═╝░░░╚═╝╚═════╝░╚═╝╚═════╝░╚══════╝╚══════╝     ╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═════╝░

# ░█████╗░███╗░░██╗██████╗░  ██████╗░░█████╗░██████╗░░█████╗░███╗░░░███╗███████╗████████╗███████╗██████╗░░██████╗
# ██╔══██╗████╗░██║██╔══██╗  ██╔══██╗██╔══██╗██╔══██╗██╔══██╗████╗░████║██╔════╝╚══██╔══╝██╔════╝██╔══██╗██╔════╝
# ███████║██╔██╗██║██║░░██║  ██████╔╝███████║██████╔╝███████║██╔████╔██║█████╗░░░░░██║░░░█████╗░░██████╔╝╚█████╗░
# ██╔══██║██║╚████║██║░░██║  ██╔═══╝░██╔══██║██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝░░░░░██║░░░██╔══╝░░██╔══██╗░╚═══██╗
# ██║░░██║██║░╚███║██████╔╝  ██║░░░░░██║░░██║██║░░██║██║░░██║██║░╚═╝░██║███████╗░░░██║░░░███████╗██║░░██║██████╔╝
# ╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░  ╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═════╝░

  parameter: period_to_date{
    view_label: "Calendar - Completed Date"
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
    allowed_value: {
      label: "Custom Period (add filter)"
      value: "CP"
    }
    # default_value: "PD"
  }
  parameter: previous_period_to_date {
    view_label: "Calendar - Completed Date"
    group_label: "Period Comparison"
    label: "Number of Period(s):"
    type: unquoted
    # allowed_value: {
    #   label: "Last Week - PREVIOUS DAY ONLY"
    #   value: "LW"
    # }
    # allowed_value: {
    #   label: "Last Month - PREVIOUS DAY ONLY"
    #   value: "LM"
    # }
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
    view_label: "Calendar - Completed Date"
    group_label: "Period Comparison"
    label: "Run Filter"
    type:  yesno
    hidden: yes
    sql:

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

      {% elsif period_to_date._parameter_value == "CP" %}

        {% if __filtered_date__._is_filtered %}

          {% if previous_period_to_date._parameter_value == "CY" %}

            ${current_period}

          {% elsif previous_period_to_date._parameter_value == "LY" %}

            ${current_period_LY}

          {% elsif previous_period_to_date._parameter_value == "2LY" %}

            ${current_period_2LY}

          {% elsif previous_period_to_date._parameter_value == "LY2LY" %}

            ${current_period_LY} OR ${current_period_2LY}

          {% endif %}

        {% else %}

          false -- CUSTOM PERIOD FILTER REQUIRED / Calendar options handled here --

      {% endif %}

    {% endif %}

    ;;

    ## cannot fail on if
    # {% else %}

    #   {% if period_to_date._parameter_value == "CP" %}

    #   false



    #   {% elsif period_to_date._parameter_value == "PD" %}

    #     ${previous_full_day}

    #   {% elsif period_to_date._parameter_value == "WTD" %}

    #     ${week_to_date}

    #   {% elsif period_to_date._parameter_value == "MTD" %}

    #     ${month_to_date}

    #   {% elsif period_to_date._parameter_value == "YTD" %}

    #     ${year_to_date}

    #   {% endif %}


    # see `false`
    # {%  if __target_date__._in_query %}

    #       ${current_period}

    #     {% else %}

    #       false -- catch transaction date filter and apply (create new dimension to cover off)

    #     {% endif %}

    # PD removed
        # {% elsif previous_period_to_date._parameter_value == "LW" %}

        #   ${previous_full_day_LW}

        # {% elsif previous_period_to_date._parameter_value == "LM" %}

        #   ${previous_full_day_LM}
    }
  filter: __filtered_date__ {
    view_label: "Calendar - Completed Date"
    group_label: "Period Comparison"
    label: "Custom Period"
    type: date
    convert_tz: yes
  }


# ██████╗░███████╗███╗░░██╗██████╗░██╗███╗░░██╗░██████╗░
# ██╔══██╗██╔════╝████╗░██║██╔══██╗██║████╗░██║██╔════╝░
# ██████╔╝█████╗░░██╔██╗██║██║░░██║██║██╔██╗██║██║░░██╗░
# ██╔═══╝░██╔══╝░░██║╚████║██║░░██║██║██║╚████║██║░░╚██╗
# ██║░░░░░███████╗██║░╚███║██████╔╝██║██║░╚███║╚██████╔╝
# ╚═╝░░░░░╚══════╝╚═╝░░╚══╝╚═════╝░╚═╝╚═╝░░╚══╝░╚═════╝░

# ██████╗░███████╗███╗░░░███╗░█████╗░██╗░░░██╗░█████╗░██╗░░░░░
# ██╔══██╗██╔════╝████╗░████║██╔══██╗██║░░░██║██╔══██╗██║░░░░░
# ██████╔╝█████╗░░██╔████╔██║██║░░██║╚██╗░██╔╝███████║██║░░░░░
# ██╔══██╗██╔══╝░░██║╚██╔╝██║██║░░██║░╚████╔╝░██╔══██║██║░░░░░
# ██║░░██║███████╗██║░╚═╝░██║╚█████╔╝░░╚██╔╝░░██║░░██║███████╗
# ╚═╝░░╚═╝╚══════╝╚═╝░░░░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝░░╚═╝╚══════╝

}
