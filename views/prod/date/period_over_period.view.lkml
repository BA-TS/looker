view: period_over_period {
  extension: required

  parameter: select_date_type {
    label: "Date Type"
    view_label: "Date"
    type: unquoted
    allowed_value: {
      label: "Calendar"
      value: "Calendar"
    }
    allowed_value: {
      label: "Fiscal"
      value: "Fiscal"
    }
    default_value: "Calendar"
    hidden: yes
  }

  parameter: select_date_reference {
    label:
    "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Date Reference
      {% endif %}"
    view_label: "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Date
      {% endif %}"
    type: unquoted
    allowed_value: {
      label: "Placed Date"
      value: "Placed"
    }
    allowed_value: {
      label: "Transaction Date"
      value: "Transaction"
    }
    default_value: "Transaction"
  }

# ██████╗░██╗░░░██╗███╗░░██╗░█████╗░███╗░░░███╗██╗░█████╗░░░░░█████╗░░█████╗░███╗░░██╗░██████╗████████╗░█████╗░███╗░░██╗████████╗░██████╗
# ██╔══██╗╚██╗░██╔╝████╗░██║██╔══██╗████╗░████║██║██╔══██╗░░░██╔══██╗██╔══██╗████╗░██║██╔════╝╚══██╔══╝██╔══██╗████╗░██║╚══██╔══╝██╔════╝
# ██║░░██║░╚████╔╝░██╔██╗██║███████║██╔████╔██║██║██║░░╚═╝░░░██║░░╚═╝██║░░██║██╔██╗██║╚█████╗░░░░██║░░░███████║██╔██╗██║░░░██║░░░╚█████╗░
# ██║░░██║░░╚██╔╝░░██║╚████║██╔══██║██║╚██╔╝██║██║██║░░██╗░░░██║░░██╗██║░░██║██║╚████║░╚═══██╗░░░██║░░░██╔══██║██║╚████║░░░██║░░░░╚═══██╗
# ██████╔╝░░░██║░░░██║░╚███║██║░░██║██║░╚═╝░██║██║╚█████╔╝░░░╚█████╔╝╚█████╔╝██║░╚███║██████╔╝░░░██║░░░██║░░██║██║░╚███║░░░██║░░░██████╔╝
# ╚═════╝░░░░╚═╝░░░╚═╝░░╚══╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝░╚════╝░░░░░╚════╝░░╚════╝░╚═╝░░╚══╝╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝░░░╚═╝░░░╚═════╝░

  dimension: __current_date__ {
    type: date
    datatype: date
    sql: CURRENT_DATE() - 1;;
    hidden: yes
  }

  dimension: __target_raw__ {
    type: date
    datatype: datetime
    sql:
    ${base.base_date_raw}
    /*CASE ${select_date_reference}
      WHEN "Placed"
        THEN 0
      ELSE ${base.base_date_raw}
    END*/;;
    hidden: yes
  }

  dimension: __target_date__ {
    type: date
    datatype: date
    sql: ${__target_raw__} ;;
    hidden: yes
  }

# █▀▄ ▄▀█ █▄█
# █▄▀ █▀█ ░█░

  dimension: __day_LW__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__current_date__}, INTERVAL 1 WEEK) ;;
    hidden: yes
  }

  dimension: __day_2LW__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__current_date__}, INTERVAL 2 WEEK) ;;
    hidden: yes
  }

  dimension: __day_LM__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__current_date__}, INTERVAL 1 MONTH) ;;
    hidden: yes
  }

  dimension: __day_2LM__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__current_date__}, INTERVAL 2 MONTH) ;;
    hidden: yes
  }

  dimension: __day_LQ__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__current_date__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __day_2LQ__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__day_LQ__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __day_LH__ {
    type: date
    datatype: date
    sql: ${__day_2LQ__} ;;
    hidden: yes
  }

  dimension: __day_2LH__ {
    type: date
    datatype: date
    sql: ${__day_LY__} ;;
    hidden: yes
  }

  dimension: __day_LY__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__current_date__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __day_2LY__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__day_LY__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }


# █░█░█ █▀▀ █▀▀ █▄▀
# ▀▄▀▄▀ ██▄ ██▄ █░█

  dimension: __week_start__ {
    type: date
    datatype: date
    sql: DATE_TRUNC(${__week_end__}, WEEK);;
    hidden: yes
  }

  dimension: __week_end__ {
    type: date
    datatype: date
    sql: ${__current_date__} ;;
    hidden: yes
  }

  dimension: __week_LW_start__ {
    type: date
    datatype: date
    sql: DATE_TRUNC(${__week_LW_end__}, WEEK) ;;
    hidden: yes
  }

  dimension: __week_LW_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_end__}, INTERVAL 1 WEEK) ;;
    hidden: yes
  }

  dimension: __week_2LW_start__ {
    type: date
    datatype: date
    sql: DATE_TRUNC(${__week_2LW_end__}, WEEK) ;;
    hidden: yes
  }

  dimension: __week_2LW_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_LW_end__}, INTERVAL 1 WEEK) ;;
    hidden: yes
  }

  dimension: __week_LM_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_start__}, INTERVAL ${__length_of_month__} DAY) ;;
    hidden: yes
  }

  dimension: __week_LM_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_end__}, INTERVAL ${__length_of_month__} DAY) ;;
    hidden: yes
  }

  dimension: __week_2LM_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_LM_start__}, INTERVAL ${__length_of_month__} DAY) ;;
    hidden: yes
  }

  dimension: __week_2LM_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_LM_end__}, INTERVAL ${__length_of_month__} DAY) ;;
    hidden: yes
  }

  dimension: __week_LQ_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_start__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __week_LQ_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_end__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __week_2LQ_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_LQ_start__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __week_2LQ_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_LQ_end__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __week_LH_start__ {
    type: date
    datatype: date
    sql: ${__week_2LQ_start__} ;;
    hidden: yes
  }

  dimension: __week_LH_end__ {
    type: date
    datatype: date
    sql: ${__week_2LQ_end__} ;;
    hidden: yes
  }

  dimension: __week_2LH_start__ {
    type: date
    datatype: date
    sql: ${__week_LY_start__} ;;
    hidden: yes
  }

  dimension: __week_2LH_end__ {
    type: date
    datatype: date
    sql: ${__week_LY_end__} ;;
    hidden: yes
  }

  dimension: __week_LY_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_start__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __week_LY_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_end__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __week_2LY_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_LY_start__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __week_2LY_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__week_LY_end__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

# █▀▄▀█ █▀█ █▄░█ ▀█▀ █░█
# █░▀░█ █▄█ █░▀█ ░█░ █▀█

  dimension: __month_start__ {
    type: date
    datatype: date
    sql: DATE_TRUNC(${__current_date__}, MONTH) ;;
    hidden: yes
  }

  dimension: __month_end__ {
    type: date
    datatype: date
    sql: ${__current_date__} ;;
    hidden: yes
  }

  dimension: __month_LM_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_start__}, INTERVAL 1 MONTH) ;;
    hidden: yes
  }

  dimension: __month_LM_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_end__}, INTERVAL 1 MONTH) ;;
    hidden: yes
  }

  dimension: __month_2LM_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_LM_start__}, INTERVAL 1 MONTH) ;;
    hidden: yes
  }

  dimension: __month_2LM_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_LM_end__}, INTERVAL 1 MONTH) ;;
    hidden: yes
  }

  dimension: __month_LQ_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_start__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __month_LQ_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_end__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __month_2LQ_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_LQ_start__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __month_2LQ_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_LQ_end__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __month_LH_start__ {
    type: date
    datatype: date
    sql: ${__month_2LQ_start__} ;;
    hidden: yes
  }

  dimension: __month_LH_end__ {
    type: date
    datatype: date
    sql: ${__month_2LQ_end__} ;;
    hidden: yes
  }

  dimension: __month_2LH_start__ {
    type: date
    datatype: date
    sql: ${__month_LY_start__}  ;;
    hidden: yes
  }

  dimension: __month_2LH_end__ {
    type: date
    datatype: date
    sql: ${__month_LY_end__} ;;
    hidden: yes
  }

  dimension: __month_LY_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_start__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __month_LY_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_end__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __month_2LY_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_LY_start__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __month_2LY_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__month_LY_end__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }


# █▀█ █░█ ▄▀█ █▀█ ▀█▀ █▀▀ █▀█
# ▀▀█ █▄█ █▀█ █▀▄ ░█░ ██▄ █▀▄

  dimension: __quarter_start__ {
    type: date
    datatype: date
    sql: DATE_TRUNC(${__current_date__}, QUARTER) ;;
    hidden: yes
  }

  dimension: __quarter_end__ {
    type: date
    datatype: date
    sql: ${__current_date__} ;;
    hidden: yes
  }

  dimension: __quarter_LM_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_start__}, INTERVAL 1 MONTH) ;;
    hidden: yes
  }

  dimension: __quarter_LM_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_end__}, INTERVAL 1 MONTH) ;;
    hidden: yes
  }

  dimension: __quarter_2LM_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_LM_start__}, INTERVAL 1 MONTH) ;;
    hidden: yes
  }

  dimension: __quarter_2LM_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_LM_end__}, INTERVAL 1 QUARTER) ;;
    hidden: yes
  }

  dimension: __quarter_LQ_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_start__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __quarter_LQ_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_end__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __quarter_2LQ_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_LQ_start__}, INTERVAL ${__length_of_quarter__} DAY) ;;
    hidden: yes
  }

  dimension: __quarter_2LQ_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_LQ_end__}, INTERVAL ${__length_of_quarter__} DAY);;
    hidden: yes
  }

  dimension: __quarter_LH_start__ {
    type: date
    datatype: date
    sql: ${__quarter_2LQ_start__} ;;
    hidden: yes
  }

  dimension: __quarter_LH_end__ {
    type: date
    datatype: date
    sql: ${__quarter_2LQ_end__} ;;
    hidden: yes
  }

  dimension: __quarter_2LH_start__ {
    type: date
    datatype: date
    sql: ${__quarter_LY_start__} ;;
    hidden: yes
  }

  dimension: __quarter_2LH_end__ {
    type: date
    datatype: date
    sql: ${__quarter_LY_end__} ;;
    hidden: yes
  }

  dimension: __quarter_LY_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_start__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __quarter_LY_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_end__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __quarter_2LY_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_LY_start__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __quarter_2LY_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__quarter_LY_end__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }


# █░█ ▄▀█ █░░ █▀▀
# █▀█ █▀█ █▄▄ █▀░

  dimension: __half_start__ {
    type: date
    datatype: date
    sql: DATE_TRUNC(${__current_date__}, QUARTER) ;; # !!!
    hidden: yes
  }

  dimension: __half_end__ {
    type: date
    datatype: date
    sql: ${__current_date__} ;;
    hidden: yes
  }

  dimension: __half_LH_start__ {
    type: date
    datatype: date
    sql: DATE_TRUNC(DATE_ADD(${__half_LH_end__}, INTERVAL -1 QUARTER), QUARTER) ;;
    hidden: yes
  }

  dimension: __half_LH_end__ {
    type: date
    datatype: date
    sql: DATE_ADD(${__half_end__}, INTERVAL -2 QUARTER) ;;
    hidden: yes
  }

  dimension: __half_2LH_start__ {
    type: date
    datatype: date
    sql: DATE_TRUNC(${__half_2LH_end__}, QUARTER) ;;
    hidden: yes
  }

  dimension: __half_2LH_end__ {
    type: date
    datatype: date
    sql: ${__half_LY_end__} ;;
    hidden: yes
  }

  dimension: __half_LY_start__ {
    type: date
    datatype: date
    sql: DATE_TRUNC(${__half_LY_end__}, QUARTER) ;;
    hidden: yes
  }

  dimension: __half_LY_end__ {
    type: date
    datatype: date
    sql: DATE_ADD(${__half_end__}, INTERVAL -(${__length_of_year__} + 1) DAY) ;;
    hidden: yes
  }

  dimension: __half_2LY_start__ {
    type: date
    datatype: date
    sql: DATE_TRUNC(${__half_2LY_end__}, QUARTER) ;;
    hidden: yes
  }

  dimension: __half_2LY_end__ {
    type: date
    datatype: date
    sql: DATE_ADD(${__half_end__}, INTERVAL - ((2 * (${__length_of_year__} + 1))+1) DAY) ;;
    hidden: yes
  }


# █▄█ █▀▀ ▄▀█ █▀█
# ░█░ ██▄ █▀█ █▀▄

  dimension: __year_start__ {
    type: date
    datatype: date
    sql: DATE_TRUNC(${__current_date__}, YEAR) ;;
    hidden: yes
  }

  dimension: __year_end__ {
    type: date
    datatype: date
    sql: ${__current_date__} ;;
    hidden: yes
  }

  dimension: __year_LY_start__ {
    type: date
    datatype: date
    sql:  DATE_SUB(${__year_start__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __year_LY_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__year_end__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __year_2LY_start__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__year_LY_start__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

  dimension: __year_2LY_end__ {
    type: date
    datatype: date
    sql: DATE_SUB(${__year_LY_end__}, INTERVAL ${__length_of_year__} DAY) ;;
    hidden: yes
  }

# ███████╗██╗██╗░░██╗███████╗██████╗░░░░█████╗░░█████╗░███╗░░██╗░██████╗████████╗░█████╗░███╗░░██╗████████╗░██████╗
# ██╔════╝██║╚██╗██╔╝██╔════╝██╔══██╗░░██╔══██╗██╔══██╗████╗░██║██╔════╝╚══██╔══╝██╔══██╗████╗░██║╚══██╔══╝██╔════╝
# █████╗░░██║░╚███╔╝░█████╗░░██║░░██║░░██║░░╚═╝██║░░██║██╔██╗██║╚█████╗░░░░██║░░░███████║██╔██╗██║░░░██║░░░╚█████╗░
# ██╔══╝░░██║░██╔██╗░██╔══╝░░██║░░██║░░██║░░██╗██║░░██║██║╚████║░╚═══██╗░░░██║░░░██╔══██║██║╚████║░░░██║░░░░╚═══██╗
# ██║░░░░░██║██╔╝╚██╗███████╗██████╔╝░░╚█████╔╝╚█████╔╝██║░╚███║██████╔╝░░░██║░░░██║░░██║██║░╚███║░░░██║░░░██████╔╝
# ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚══════╝╚═════╝░░░░╚════╝░░╚════╝░╚═╝░░╚══╝╚═════╝░░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚══╝░░░╚═╝░░░╚═════╝░

  dimension: __length_of_week__ {
    type: number
    sql: 7;;
    hidden: yes
  }

  dimension: __length_of_month__ {
    type: number
    sql: 30;;
    hidden: yes
  }

  dimension: __length_of_quarter__ {
    type: number
    sql: 91;;
    hidden: yes
  }

  dimension: __length_of_half__ {
    type: number
    description: "Currently unused."
    sql: 182;;
    hidden: yes
  }

  dimension: __length_of_year__ {
    type: number
    sql: 364;;
    hidden: yes
  }

# ░█████╗░██╗░░░░░░██╗░░░░░░░██╗░█████╗░██╗░░░██╗░██████╗░░░░░░░██╗░░░░░░░██╗██╗░░██╗███████╗██████╗░███████╗
# ██╔══██╗██║░░░░░░██║░░██╗░░██║██╔══██╗╚██╗░██╔╝██╔════╝░░░░░░░██║░░██╗░░██║██║░░██║██╔════╝██╔══██╗██╔════╝
# ███████║██║░░░░░░╚██╗████╗██╔╝███████║░╚████╔╝░╚█████╗░█████╗░╚██╗████╗██╔╝███████║█████╗░░██████╔╝█████╗░░
# ██╔══██║██║░░░░░░░████╔═████║░██╔══██║░░╚██╔╝░░░╚═══██╗╚════╝░░████╔═████║░██╔══██║██╔══╝░░██╔══██╗██╔══╝░░
# ██║░░██║███████╗░░╚██╔╝░╚██╔╝░██║░░██║░░░██║░░░██████╔╝░░░░░░░░╚██╔╝░╚██╔╝░██║░░██║███████╗██║░░██║███████╗
# ╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝░░░╚═╝░░░╚═════╝░░░░░░░░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚══════╝

  filter: period_over_period {
    hidden: yes
    type: yesno
    sql:
    {% if select_date_range._is_filtered %}
      ${flexible_pop}
    {% elsif select_fixed_range._is_filtered %}
      ${fixed_pop}
    {% elsif
      dynamic_fiscal_year._is_filtered or dynamic_fiscal_half._is_filtered or
      dynamic_fiscal_quarter._is_filtered or dynamic_fiscal_month._is_filtered or
      dynamic_actual_year._is_filtered or catalogue.catalogue_name._is_filtered or catalogue.extra_name._is_filtered or
      combined_week._is_filtered or combined_month._is_filtered or combined_quarter._is_filtered or combined_year._is_filtered or separate_month._is_filtered %}
        true
    {% else %}
      false
    {% endif %};;
    }

# ███████╗██╗██╗░░░░░████████╗███████╗██████╗░░██████╗
# ██╔════╝██║██║░░░░░╚══██╔══╝██╔════╝██╔══██╗██╔════╝
# █████╗░░██║██║░░░░░░░░██║░░░█████╗░░██████╔╝╚█████╗░
# ██╔══╝░░██║██║░░░░░░░░██║░░░██╔══╝░░██╔══██╗░╚═══██╗
# ██║░░░░░██║███████╗░░░██║░░░███████╗██║░░██║██████╔╝
# ╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═════╝░

    filter: select_date_range {
      label: "
      {% if _explore._name == 'GA4_test' %}
      Date Filter
      {% else %}
      Date Range
      {% endif %}"
      group_label: "
      {% if _explore._name == 'GA4_test' %}
      Date
      {% else %}
      Date Filter
      {% endif %}"
      view_label: "
      {% if _explore._name == 'GA4_test' %}
      Trends
      {% else %}
      Date
      {% endif %}"
      type: date
      convert_tz: yes
    }

    parameter: select_fixed_range {
      label:
      "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Fixed Range
      {% endif %}"
      group_label:
      "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Date Filter
      {% endif %}"
      view_label:
      "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Date
      {% endif %}"
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
        label: "Quarter to Date (QTD)"
        value: "QTD"
      }
      allowed_value: {
        label: "Year to Date (YTD)"
        value: "YTD"
      }

      allowed_value: {
        label: "Year to Last Month"
        value: "YLM"
      }
    }

    parameter: select_comparison_period {
      #label: "Comparison Period"
      label: "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Comparison Period
      {% endif %}"
      group_label: "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Comparison
      {% endif %}"
      view_label: "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Date
      {% endif %}"
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
        label: "Previous 2 Year"
        value: "2YearsAgo"
      }
      default_value: "Period"
    }

    parameter: select_number_of_periods {
      label:
      "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Number of Period(s)
      {% endif %}"
      group_label:
      "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Comparison
      {% endif %}"
      view_label:
      "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Date
      {% endif %}"
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

# ██████╗░░█████╗░████████╗███████╗
# ██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
# ██║░░██║███████║░░░██║░░░█████╗░░
# ██║░░██║██╔══██║░░░██║░░░██╔══╝░░
# ██████╔╝██║░░██║░░░██║░░░███████╗
# ╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚══════╝

    dimension_group: date {
      view_label: "Date"
      group_label: "Dates"
      label: ""
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
      {% endif %};;
      timeframes: [date]
      can_filter: no
      allow_fill: no
      hidden: yes
    }

# ░█████╗░░█████╗░███╗░░░███╗██████╗░░█████╗░██████╗░░█████╗░████████╗░█████╗░██████╗░
# ██╔══██╗██╔══██╗████╗░████║██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗
# ██║░░╚═╝██║░░██║██╔████╔██║██████╔╝███████║██████╔╝███████║░░░██║░░░██║░░██║██████╔╝
# ██║░░██╗██║░░██║██║╚██╔╝██║██╔═══╝░██╔══██║██╔══██╗██╔══██║░░░██║░░░██║░░██║██╔══██╗
# ╚█████╔╝╚█████╔╝██║░╚═╝░██║██║░░░░░██║░░██║██║░░██║██║░░██║░░░██║░░░╚█████╔╝██║░░██║
# ░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝

  dimension: pivot_dimension {
      view_label:
      "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Date
      {% endif %}"
      label:
      "
      {% if _explore._name == 'GA4_test' %}
      {% else %}
      Compare Period
      {% endif %}"
      description: "Pivot this to apply comparative PoP."
      type: string
      order_by_field: __comparator_order__
      sql:
           {% if select_date_range._is_filtered %}
              CASE
                WHEN {% condition select_date_range %}  ${base_date_raw} {% endcondition %}
                  THEN "This {% parameter select_comparison_period %}"
                WHEN ${base_date_raw} >= ${period_2_start} and ${base_date_raw} < ${period_2_end}
                  THEN "Last {% parameter select_comparison_period %}"
                WHEN ${base_date_raw} >= ${period_3_start} and ${base_date_raw} < ${period_3_end}
                  THEN "2 {% parameter select_comparison_period %}s Ago"
              END
            {% elsif select_fixed_range._is_filtered %}
            CASE
                WHEN
                  {% if select_fixed_range._parameter_value == "PD" %}
                    ${previous_full_day}
                  {% elsif select_fixed_range._parameter_value == "WTP" %}
                    ${week_to_date}
                  {% elsif select_fixed_range._parameter_value == "MTD" %}
                    ${month_to_date}
                  {% elsif select_fixed_range._parameter_value == "QTD" %}
                    ${quarter_to_date}
                  {% elsif select_fixed_range._parameter_value == "HTD" %}
                    ${half_to_date}
                  {% elsif select_fixed_range._parameter_value == "YTD" %}
                    ${year_to_date}
                    {% elsif select_fixed_range._parameter_value == "YLM" %}
                    ${year_to_LM}
                  {% else %}
                    false
                  {% endif %}
                THEN "This {% parameter select_comparison_period %}"
                WHEN
                {% if select_fixed_range._parameter_value == "PD" %}
                  ${previous_full_day_LW} OR ${previous_full_day_LM} OR ${previous_full_day_LQ} OR ${previous_full_day_LH} OR ${previous_full_day_LY}
                {% elsif select_fixed_range._parameter_value == "WTD" %}
                  ${week_to_date_LW} OR ${week_to_date_LM} OR ${week_to_date_LQ} OR ${week_to_date_LH} OR ${week_to_date_LY}
                {% elsif select_fixed_range._parameter_value == "MTD" %}
                  ${month_to_date_LM} OR ${month_to_date_LQ} OR ${month_to_date_LH} OR ${month_to_date_LY}
                {% elsif select_fixed_range._parameter_value == "QTD" %}
                  ${quarter_to_date_LQ} OR ${quarter_to_date_LH} OR ${quarter_to_date_LY}
                {% elsif select_fixed_range._parameter_value == "HTD" %}
                  ${half_to_date_LH} OR ${half_to_date_LY}
                {% elsif select_fixed_range._parameter_value == "YTD" %}
                  ${year_to_date_LY}
                  {% elsif select_fixed_range._parameter_value == "YLM" %}
                  ${year_to_LM_LY}
                {% else %}
                  false
                  {% endif %}
                THEN "Last {% parameter select_comparison_period %}"
                WHEN
                {% if select_fixed_range._parameter_value == "PD" %}
                  ${previous_full_day_2LW} OR ${previous_full_day_2LM} OR ${previous_full_day_2LQ} OR ${previous_full_day_2LH} OR ${previous_full_day_2LY}
                {% elsif select_fixed_range._parameter_value == "WTD" %}
                  ${week_to_date_2LW} OR ${week_to_date_2LM} OR ${week_to_date_2LQ} OR ${week_to_date_2LH} OR ${week_to_date_2LY}
                {% elsif select_fixed_range._parameter_value == "MTD" %}
                  ${month_to_date_2LM} OR ${month_to_date_2LQ} OR ${month_to_date_2LH} OR ${month_to_date_2LY}
                {% elsif select_fixed_range._parameter_value == "QTD" %}
                  ${quarter_to_date_2LQ} OR ${quarter_to_date_2LH} OR ${quarter_to_date_2LY}
                {% elsif select_fixed_range._parameter_value == "HTD" %}
                  ${half_to_date_LH} OR ${half_to_date_LY}
                {% elsif select_fixed_range._parameter_value == "YTD" %}
                  ${year_to_date_2LY}
                  {% elsif select_fixed_range._parameter_value == "YLM" %}
                  ${year_to_LM_2LY}
                {% else %}
                  false
                {% endif %}
                THEN "2 {% parameter select_comparison_period %}s Ago"
                ELSE "UNKNOWN PERIOD"
            END
            {% else %}
              NULL
            {% endif %};; # need to look at this further
      can_filter: no
    }

    dimension: __comparator_order__ {
      hidden: yes
      type: string
      sql:
      {% if select_number_of_periods._is_filtered and select_date_range._in_query %}
        CASE
          WHEN {% condition select_date_range %} ${base_date_raw} {% endcondition %}
          THEN 1
          WHEN ${base_date_raw} >= ${period_2_start} and ${base_date_raw} < ${period_2_end}
          THEN 2
          WHEN ${base_date_raw} >= ${period_3_start} and ${base_date_raw} < ${period_3_end}
          THEN 3
          ELSE 4
        END
      {% else %}
        ${base_date_raw}
      {% endif %};;
    }

# ███████╗██╗░░░░░███████╗██╗░░██╗██╗██████╗░██╗░░░░░███████╗░░░░██████╗░░█████╗░██████╗░
# ██╔════╝██║░░░░░██╔════╝╚██╗██╔╝██║██╔══██╗██║░░░░░██╔════╝░░░░██╔══██╗██╔══██╗██╔══██╗
# █████╗░░██║░░░░░█████╗░░░╚███╔╝░██║██████╦╝██║░░░░░█████╗░░░░░░██████╔╝██║░░██║██████╔╝
# ██╔══╝░░██║░░░░░██╔══╝░░░██╔██╗░██║██╔══██╗██║░░░░░██╔══╝░░░░░░██╔═══╝░██║░░██║██╔═══╝░
# ██║░░░░░███████╗███████╗██╔╝╚██╗██║██████╦╝███████╗███████╗░░░░██║░░░░░╚█████╔╝██║░░░░░
# ╚═╝░░░░░╚══════╝╚══════╝╚═╝░░╚═╝╚═╝╚═════╝░╚══════╝╚══════╝░░░░╚═╝░░░░░░╚════╝░╚═╝░░░░░

    filter: flexible_pop {
      type: yesno
      sql:
          {% condition base.select_date_range %} ${base.base_date_raw} {% endcondition %}
          {% if base.select_date_range._is_filtered and (select_number_of_periods._in_query or select_comparison_period._in_query) %}
            {% if select_number_of_periods._parameter_value == "2" %}
              or ${base.base_date_raw} >= ${period_2_start} and ${base.base_date_raw} < ${period_2_end}
            {% elsif select_number_of_periods._parameter_value == "3" %}
              or ${base.base_date_raw} >= ${period_2_start} and ${base.base_date_raw} < ${period_2_end}
              or ${base.base_date_raw} >= ${period_3_start} and ${base.base_date_raw} < ${period_3_end}
            {% endif %}
          {% endif %};;
      hidden: yes
    }

    dimension_group: in_period {
      type: duration
      intervals: [day]
      sql_start: {% date_start select_date_range %} ;;
      sql_end: {% date_end select_date_range %} ;;
      hidden:  yes
    }

    dimension: day_in_period {
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
          {% endif %} ;;
      hidden: yes
    }

    dimension: period_2_start {
      type: date_raw
      sql:
          {% if select_date_range._in_query %}
            {% if select_comparison_period._parameter_value == "Period" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL ${days_in_period} DAY)
            {% elsif select_comparison_period._parameter_value == "Week" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL ${__length_of_week__} DAY)
            {% elsif select_comparison_period._parameter_value == "Month" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL ${__length_of_month__} DAY)
            {% elsif select_comparison_period._parameter_value == "Quarter" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL ${__length_of_quarter__} DAY)
            {% elsif select_comparison_period._parameter_value == "Year" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL ${__length_of_year__} DAY)
            {% else %}
              TIMESTAMP(DATETIME_SUB(DATETIME({% date_start select_date_range %}) , INTERVAL 1 {% parameter select_comparison_period %}))
            {% endif %}
          {% else %}
            {% date_start select_date_range %}
          {% endif %};;
      hidden:  yes
    }
    # changed from 2 * to nil

    dimension: period_2_end {
      type: date_raw
      sql:
          {% if select_date_range._in_query %}
            {% if select_comparison_period._parameter_value == "Period" %}
              TIMESTAMP_SUB({% date_start select_date_range %}, INTERVAL 0 DAY)
            {% elsif select_comparison_period._parameter_value == "Week" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL ${__length_of_week__} DAY)
            {% elsif select_comparison_period._parameter_value == "Month" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL ${__length_of_month__} DAY)
            {% elsif select_comparison_period._parameter_value == "Quarter" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL ${__length_of_quarter__} DAY)
            {% elsif select_comparison_period._parameter_value == "Year" %}
              TIMESTAMP_SUB({% date_end select_date_range %} , INTERVAL ${__length_of_year__} DAY)
            {% else %}
              TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end select_date_range %}), INTERVAL 0 DAY), INTERVAL 1 {% parameter select_comparison_period %}))
            {% endif %}
          {% else %}
            {% date_end select_date_range %}
          {% endif %};;
      hidden:  yes
    }
    # changed from 2 * to nil

    dimension: period_3_start {
      type: date_raw
      sql:
            {% if select_comparison_period._parameter_value == "Period" %}
              TIMESTAMP_SUB({% date_start select_date_range %}, INTERVAL (2 * ${days_in_period}) DAY)
            {% elsif select_comparison_period._parameter_value == "Week" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL (2 * ${__length_of_week__}) DAY)
            {% elsif select_comparison_period._parameter_value == "Month" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL (2 * ${__length_of_month__}) DAY)
            {% elsif select_comparison_period._parameter_value == "Quarter" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL (2 * ${__length_of_quarter__}) DAY)
            {% elsif select_comparison_period._parameter_value == "Year" %}
                TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL (2 * ${__length_of_year__}) DAY)
            {% else %}
              TIMESTAMP(DATETIME_SUB(DATETIME({% date_start select_date_range %}), INTERVAL 2 {% parameter select_comparison_period %}))
            {% endif %};;
      hidden: yes
    }
    # changed from 3 * to 2 *

    dimension: period_3_end {
      type: date_raw
      sql:
            {% if select_comparison_period._parameter_value == "Period" %}
              TIMESTAMP_SUB(${period_2_start}, INTERVAL 0 DAY)
            {% elsif select_comparison_period._parameter_value == "Week" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL (2 * ${__length_of_week__}) DAY)
            {% elsif select_comparison_period._parameter_value == "Month" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL (2 * ${__length_of_month__}) DAY)
            {% elsif select_comparison_period._parameter_value == "Quarter" %}
              TIMESTAMP_SUB({% date_start select_date_range %} , INTERVAL (2 * ${__length_of_quarter__}) DAY)
            {% elsif select_comparison_period._parameter_value == "Year" %}
                TIMESTAMP_SUB({% date_end select_date_range %} , INTERVAL (2 * ${__length_of_year__}) DAY)
            {% else %}
              TIMESTAMP(DATETIME_SUB(DATETIME_SUB(DATETIME({% date_end select_date_range %}), INTERVAL 0 DAY), INTERVAL 2 {% parameter select_comparison_period %}))
            {% endif %};;
      hidden: yes
    }
    # changed from 3 * to 2 *

# ███████╗██╗██╗░░██╗███████╗██████╗░░░██████╗░░█████╗░██████╗░
# ██╔════╝██║╚██╗██╔╝██╔════╝██╔══██╗░░██╔══██╗██╔══██╗██╔══██╗
# █████╗░░██║░╚███╔╝░█████╗░░██║░░██║░░██████╔╝██║░░██║██████╔╝
# ██╔══╝░░██║░██╔██╗░██╔══╝░░██║░░██║░░██╔═══╝░██║░░██║██╔═══╝░
# ██║░░░░░██║██╔╝╚██╗███████╗██████╔╝░░██║░░░░░╚█████╔╝██║░░░░░
# ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚══════╝╚═════╝░░░╚═╝░░░░░░╚════╝░╚═╝░░░░░

  filter: fixed_pop {
      type:  yesno
      sql:
          {% if select_fixed_range._in_query %}
            {% if select_fixed_range._parameter_value == "PD" %}
              {% if select_comparison_period._parameter_value == "Period" %}
                ${previous_full_day}
              {% elsif select_comparison_period._parameter_value == "Week" %}
                ${previous_full_day} OR ${previous_full_day_LW}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${previous_full_day_2LW}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Month" %}
                ${previous_full_day} OR ${previous_full_day_LM}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${previous_full_day_2LM}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Quarter" %}
                ${previous_full_day} OR ${previous_full_day_LQ}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${previous_full_day_2LQ}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Half" %}
                ${previous_full_day} OR ${previous_full_day_LH}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${previous_full_day_2LH}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Year" %}
                ${previous_full_day} OR ${previous_full_day_LY}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${previous_full_day_2LY}
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
                ${week_to_date} OR ${week_to_date_LW}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${week_to_date_2LW}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Month" %}
                ${week_to_date} OR ${week_to_date_LM}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${week_to_date_2LM}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Quarter" %}
                ${week_to_date} OR ${week_to_date_LQ}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${week_to_date_2LQ}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Half" %}
                ${week_to_date} OR ${week_to_date_LH}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${week_to_date_2LH}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Year" %}
                ${week_to_date} OR ${week_to_date_LY}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${week_to_date_2LY}
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
                ${month_to_date}
              {% elsif select_comparison_period._parameter_value == "Month" %}
                ${month_to_date} OR ${month_to_date_LM}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${month_to_date_2LM}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Quarter" %}
                ${month_to_date} OR ${month_to_date_LQ}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${month_to_date_2LQ}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Half" %}
                ${month_to_date} OR ${month_to_date_LH}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${month_to_date_2LH}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Year" %}
                ${month_to_date} OR ${month_to_date_LY}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${month_to_date_2LY}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "2YearsAgo" %}
                ${month_to_date} OR ${month_to_date_2LY}
              {% else %}
                ${month_to_date}
              {% endif %}
            {% elsif select_fixed_range._parameter_value == "QTD" %}
              {% if select_comparison_period._parameter_value == "Period" %}
                ${quarter_to_date}
              {% elsif select_comparison_period._parameter_value == "Week" %}
                ${quarter_to_date}
              {% elsif select_comparison_period._parameter_value == "Month" %}
                ${quarter_to_date}
              {% elsif select_comparison_period._parameter_value == "Quarter" %}
                ${quarter_to_date} OR ${quarter_to_date_LQ}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${quarter_to_date_2LQ}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Half" %}
                ${quarter_to_date} OR ${quarter_to_date_LH}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${quarter_to_date_2LH}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Year" %}
                ${quarter_to_date} OR ${quarter_to_date_LY}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${quarter_to_date_2LY}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "2YearsAgo" %}
                ${quarter_to_date} OR ${quarter_to_date_2LY}
              {% else %}
                ${quarter_to_date}
              {% endif %}
            {% elsif select_fixed_range._parameter_value == "HTD" %}
              {% if select_comparison_period._parameter_value == "Period" %}
                ${half_to_date}
              {% elsif select_comparison_period._parameter_value == "Week" %}
                ${half_to_date}
              {% elsif select_comparison_period._parameter_value == "Month" %}
                ${half_to_date}
              {% elsif select_comparison_period._parameter_value == "Quarter" %}
                ${half_to_date}
              {% elsif select_comparison_period._parameter_value == "Half" %}
                ${half_to_date} OR ${half_to_date_LH}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${half_to_date_2LH}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "Year" %}
                ${half_to_date} OR ${half_to_date_LY}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${half_to_date_2LY}
                {% endif %}
              {% elsif select_comparison_period._parameter_value == "2YearsAgo" %}
                ${half_to_date} OR ${half_to_date_2LY}
              {% else %}
                ${half_to_date}
              {% endif %}
            {% elsif select_fixed_range._parameter_value == "YTD" %}
              {% if select_comparison_period._parameter_value == "Period" %}
                ${year_to_date}
              {% elsif select_comparison_period._parameter_value == "Week" %}
                ${year_to_date}
              {% elsif select_comparison_period._parameter_value == "Month" %}
                ${year_to_date}
              {% elsif select_comparison_period._parameter_value == "Quarter" %}
                ${year_to_date}
              {% elsif select_comparison_period._parameter_value == "Half" %}
                ${year_to_date}
              {% elsif select_comparison_period._parameter_value == "Year" %}
                ${year_to_date} OR ${year_to_date_LY}
                {% if select_number_of_periods._parameter_value == "3" %}
                  OR ${year_to_date_2LY}
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
          {% endif %};;
      hidden: yes
    }

# █▀▄ ▄▀█ █▄█
# █▄▀ █▀█ ░█░

    dimension: previous_full_day {
      type: yesno
      sql: ${__target_date__} = ${__current_date__} ;;
      hidden: yes
    }

    dimension: previous_full_day_LW {
      type: yesno
      sql: ${__target_date__} = ${__day_LW__} ;;
      hidden: yes
    }

    dimension: previous_full_day_2LW {
      type: yesno
      sql: ${__target_date__} = ${__day_2LW__} ;;
      hidden: yes
    }

    dimension: previous_full_day_LM {
      type: yesno
      sql: ${__target_date__} = ${__day_LM__} ;;
      hidden: yes
    }

    dimension: previous_full_day_2LM {
      type: yesno
      sql: ${__target_date__} = ${__day_2LM__} ;;
      hidden: yes
    }

    dimension: previous_full_day_LQ {
      type: yesno
      sql: ${__target_date__} = ${__day_LQ__} ;;
      hidden: yes
    }

    dimension: previous_full_day_2LQ {
      type: yesno
      sql: ${__target_date__} = ${__day_2LQ__} ;;
      hidden: yes
    }

    dimension: previous_full_day_LH {
      type: yesno
      sql: ${__target_date__} = ${__day_LH__} ;;
      hidden: yes
    }

    dimension: previous_full_day_2LH {
      type: yesno
      sql: ${__target_date__} = ${__day_2LH__} ;;
      hidden: yes
    }

    dimension: previous_full_day_LY {
      type: yesno
      sql: ${__target_date__} = ${__day_LY__} ;;
      hidden: yes
    }

    dimension: previous_full_day_2LY {
      type: yesno
      sql: ${__target_date__} = ${__day_2LY__} ;;
      hidden: yes
    }


# █░█░█ █▀▀ █▀▀ █▄▀
# ▀▄▀▄▀ ██▄ ██▄ █░█

    dimension: week_to_date {
      type: yesno
      sql:  ${__target_date__} BETWEEN ${__week_start__} AND ${__week_end__}  ;;
      hidden: yes
    }

    dimension: week_to_date_LW {
      type: yesno
      sql:  ${__target_date__} BETWEEN ${__week_LW_start__} AND ${__week_LW_end__};;
      hidden: yes
    }

    dimension: week_to_date_2LW {
      type: yesno
      sql:  ${__target_date__} BETWEEN ${__week_2LW_start__} AND ${__week_2LW_end__}  ;;
      hidden: yes
    }

    dimension: week_to_date_LM {
      type: yesno
      sql:  ${__target_date__} BETWEEN ${__week_LM_start__} AND ${__week_LM_end__}  ;;
      hidden: yes
    }

    dimension: week_to_date_2LM {
      type: yesno
      sql:  ${__target_date__} BETWEEN ${__week_2LM_start__} AND ${__week_2LM_end__}  ;;
      hidden: yes
    }

    dimension: week_to_date_LQ {
      type: yesno
      sql:  ${__target_date__} BETWEEN ${__week_LQ_start__} AND ${__week_LQ_end__}  ;;
      hidden: yes
    }

    dimension: week_to_date_2LQ {
      type: yesno
      sql:  ${__target_date__} BETWEEN ${__week_2LQ_start__} AND ${__week_2LQ_end__};;
      hidden: yes
    }

    dimension: week_to_date_LH {
      type: yesno
      sql:  ${__target_date__} BETWEEN ${__week_LH_start__} AND ${__week_LH_end__};;
      hidden: yes
    }

    dimension: week_to_date_2LH {
      type: yesno
      sql:  ${__target_date__} BETWEEN ${__week_2LH_start__} AND ${__week_2LH_end__};;
      hidden: yes
    }

    dimension: week_to_date_LY {
      type: yesno
      sql:  ${__target_date__} BETWEEN ${__week_LY_start__} AND ${__week_LY_end__};;
      hidden: yes
    }

    dimension: week_to_date_2LY {
      type: yesno
      sql:  ${__target_date__} BETWEEN ${__week_2LY_start__} AND ${__week_2LY_end__};;
      hidden: yes
    }

# █▀▄▀█ █▀█ █▄░█ ▀█▀ █░█
# █░▀░█ █▄█ █░▀█ ░█░ █▀█

    dimension: month_to_date {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__month_start__} AND ${__month_end__} ;;
      hidden: yes
    }

    dimension: month_to_date_LM {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__month_LM_start__} AND ${__month_LM_end__} ;;
      hidden: yes
    }

    dimension: month_to_date_2LM {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__month_2LM_start__} AND ${__month_2LM_end__} ;;
      hidden: yes
    }

    dimension: month_to_date_LQ {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__month_LQ_start__} AND ${__month_LQ_end__} ;;
      hidden: yes
    }

    dimension: month_to_date_2LQ {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__month_2LQ_start__} AND ${__month_2LQ_end__} ;;
      hidden: yes
    }

    dimension: month_to_date_LH {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__month_LH_start__} AND ${__month_LH_end__} ;;
      hidden: yes
    }

    dimension: month_to_date_2LH {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__month_2LH_start__} AND ${__month_2LH_end__} ;;
      hidden: yes
    }

    dimension: month_to_date_LY {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__month_LY_start__} AND ${__month_LY_end__} ;;
      hidden: yes
    }

    dimension: month_to_date_2LY {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__month_2LY_start__} AND ${__month_2LY_end__} ;;
      hidden: yes
    }


# █▀█ █░█ ▄▀█ █▀█ ▀█▀ █▀▀ █▀█
# ▀▀█ █▄█ █▀█ █▀▄ ░█░ ██▄ █▀▄


    dimension: quarter_to_date {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__quarter_start__} AND ${__quarter_end__} ;;
      hidden: yes
    }

    dimension: quarter_to_date_LQ {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__quarter_LQ_start__} AND ${__quarter_LQ_end__} ;;
      hidden: yes
    }

    dimension: quarter_to_date_2LQ {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__quarter_2LQ_start__} AND ${__quarter_2LQ_end__} ;;
      hidden: yes
    }

    dimension: quarter_to_date_LH {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__quarter_LH_start__} AND ${__quarter_LH_end__} ;;
      hidden: yes
    }

    dimension: quarter_to_date_2LH {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__quarter_2LH_start__} AND ${__quarter_2LH_end__} ;;
      hidden: yes
    }

    dimension: quarter_to_date_LY {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__quarter_LY_start__} AND ${__quarter_LY_end__} ;;
      hidden: yes
    }

    dimension: quarter_to_date_2LY {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__quarter_2LY_start__} AND ${__quarter_2LY_end__} ;;
      hidden: yes
    }

# █░█ ▄▀█ █░░ █▀▀
# █▀█ █▀█ █▄▄ █▀░

    dimension: half_to_date {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__half_start__} AND ${__half_end__} ;;
      hidden: yes
    }

    dimension: half_to_date_LH {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__half_LH_start__} AND ${__half_LH_end__} ;;
      hidden: yes
    }

    dimension: half_to_date_2LH {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__half_2LH_start__} AND ${__half_2LH_end__} ;;
      hidden: yes
    }

    dimension: half_to_date_LY {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__half_LY_start__} AND ${__half_LY_end__} ;;
      hidden: yes
    }

    dimension: half_to_date_2LY {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__half_2LY_start__} AND ${__half_2LY_end__} ;;
      hidden: yes
    }


# █▄█ █▀▀ ▄▀█ █▀█
# ░█░ ██▄ █▀█ █▀▄


    dimension: year_to_date {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__year_start__} AND ${__year_end__} ;;
      hidden: no
    }

    dimension: year_to_date_LY {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__year_LY_start__} AND ${__year_LY_end__} ;;
      hidden: yes
    }

    dimension: year_to_date_2LY {
      type: yesno
      sql: ${__target_date__} BETWEEN ${__year_2LY_start__} AND ${__year_2LY_end__} ;;
      hidden: yes
    }

  dimension: year_to_LM {
    type: yesno
    sql: ${__target_date__} BETWEEN ${__year_start__} AND last_day(${__month_LM_start__}, month) ;;
    hidden: yes
  }

  dimension: year_to_LM_LY {
    type: yesno
    sql: ${__target_date__} BETWEEN ${__year_LY_start__} AND last_day(date_sub(${__month_LM_start__}, interval ${__length_of_year__} day), month) ;;
    hidden: yes
  }

  dimension: year_to_LM_2LY {
    type: yesno
    sql: ${__target_date__} BETWEEN ${__year_2LY_start__} AND last_day(date_sub(${__month_LM_start__}, interval (${__length_of_year__}*2) day), month) ;;
    hidden: yes
  }
  }
