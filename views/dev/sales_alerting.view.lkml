
view: sales_alert{

  sql_table_name: `toolstation-data-storage.looker_persistent_tables.sales_alerting`
    ;;

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date
    ]
    # ,
    #   week,
    #   month,
    #   quarter,
    #   year
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: net_sales_dim {
    type: number
    sql: ${TABLE}.net_sales ;;
    hidden: yes
  }

  dimension: net_sales_1w {
    type: number
    sql: ${TABLE}.net_sales_1w ;;
    hidden: yes
  }

  dimension: net_sales_2w {
    type: number
    sql: ${TABLE}.net_sales_2w ;;
    hidden: yes
  }

  dimension: net_sales_1y {
    type: number
    sql: ${TABLE}.net_sales_1y ;;
    hidden: yes
  }

  dimension: net_sales_2y {
    type: number
    sql: ${TABLE}.net_sales_2y ;;
    hidden: yes
  }

  dimension: sales_channel {
    type: string
    sql: ${TABLE}.salesChannel ;;
  }

  ####################################################

  measure: net_sales {
    type: sum
    sql: ${net_sales_dim} ;;
    value_format_name:  gbp_0
  }

  measure: net_sales_1w_prior {
    type: sum
    sql: ${net_sales_1w} ;;
    value_format_name:  gbp_0
  }
  measure:  net_sales_2w_prior {
    type: sum
    sql: ${net_sales_2w} ;;
    value_format_name:  gbp_0
  }
  measure: net_sales_1y_prior {
    type: sum
    sql: ${net_sales_1y} ;;
    value_format_name:  gbp_0

  }
  measure:  net_sales_2y_prior {
    type: sum
    sql: ${net_sales_2y} ;;
    value_format_name:  gbp_0
  }
  measure:  net_sales_1w_change {
    type: number
    sql: ${net_sales}-${net_sales_1w_prior} ;;
    value_format_name:  gbp_0
  }
  measure:  net_sales_2w_change {
    type: number
    sql: ${net_sales}-${net_sales_2w_prior} ;;
    value_format_name:  gbp_0
  }
  measure:  net_sales_1y_change {
    type: number
    sql: ${net_sales}-${net_sales_1y_prior} ;;
    value_format_name:  gbp_0
  }
  measure:  net_sales_2y_change {
    type: number
    sql: ${net_sales}-${net_sales_2y_prior} ;;
    value_format_name:  gbp_0
  }

  #######################################


  measure: alert_required {
    group_label: "Deviation"
    can_filter: no
    type: number
    sql:

    if(
      (${1_week_deviation}=false
      AND ${2_week_deviation}=false
      AND ${1_year_deviation}=false
      AND ${2_year_deviation}=false) = false,
    1,
    0)


    ;;
  }

  parameter: 1_week_deviation_parameter {
    type: unquoted
    label: "Include 1W Deviation?"
    allowed_value: {
      label: "Yes"
      value: "YES"
    }
    allowed_value: {
      label: "No"
      value: "NO"
    }
  }
  measure: 1_week_deviation {
    group_label: "Deviation"
    hidden: yes
    type: yesno
    sql:
    {% if 1_week_deviation_parameter._in_query and 1_week_deviation_parameter._parameter_value == "YES" %}
    ABS(${net_sales_1w_change} / ${net_sales_1w_prior}) >= {% parameter minimum_deviation %}
    {% else %}
    false
    {% endif %}

    ;;
  }


  parameter: 2_week_deviation_parameter {
    type: unquoted
    label: "Include 2W Deviation?"
    allowed_value: {
      label: "Yes"
      value: "YES"
    }
    allowed_value: {
      label: "No"
      value: "NO"
    }
  }
  measure: 2_week_deviation {
    group_label: "Deviation"
    hidden: yes
    type: yesno
    sql:
    {% if 2_week_deviation_parameter._in_query and 2_week_deviation_parameter._parameter_value == "YES" %}
    ABS(${net_sales_2w_change} / ${net_sales_2w_prior}) >= {% parameter minimum_deviation %}
    {% else %}
    false
    {% endif %}

    ;;
  }
  parameter: 1_year_deviation_parameter {
    type: unquoted
    label: "Include 1Y Deviation?"
    allowed_value: {
      label: "Yes"
      value: "YES"
    }
    allowed_value: {
      label: "No"
      value: "NO"
    }
  }
  measure: 1_year_deviation {
    group_label: "Deviation"
    hidden: no
    type: yesno
    sql:
    {% if 1_year_deviation_parameter._in_query and 1_year_deviation_parameter._parameter_value == "YES" %}
    ABS(${net_sales_1y_change} / ${net_sales_1y_prior}) >= {% parameter minimum_deviation %}
    {% else %}
    false
    {% endif %}

    ;;
  }
  parameter: 2_year_deviation_parameter {
    type: unquoted
    label: "Include 2Y Deviation?"
    allowed_value: {
      label: "Yes"
      value: "YES"
    }
    allowed_value: {
      label: "No"
      value: "NO"
    }
  }
  measure: 2_year_deviation {
    group_label: "Deviation"
    hidden: no
    type: yesno
    sql:
    {% if 2_year_deviation_parameter._in_query and 2_year_deviation_parameter._parameter_value == "YES" %}
    ABS(${net_sales_2y_change} / ${net_sales_2y_prior}) >= {% parameter minimum_deviation %}
    {% else %}
    false
    {% endif %}

    ;;
  }



  parameter: minimum_deviation {
    type: number
    default_value: "0"
    allowed_value: {
      label: "0%"
      value: "0"
    }
    allowed_value: {
      label: "5%"
      value: "0.05"
    }
    allowed_value: {
      label: "10%"
      value: "0.10"
    }
    allowed_value: {
      label: "15%"
      value: "0.15"
    }
    allowed_value: {
      label: "20%"
      value: "0.20"
    }
    allowed_value: {
      label: "25%"
      value: "0.25"
    }
    allowed_value: {
      label: "30%"
      value: "0.30"
    }
    allowed_value: {
      label: "35%"
      value: "0.35"
    }
    allowed_value: {
      label: "40%"
      value: "0.40"
    }
    allowed_value: {
      label: "45%"
      value: "0.45"
    }
    allowed_value: {
      label: "50%"
      value: "0.50"
    }
    allowed_value: {
      label: "55%"
      value: "0.55"
    }
    allowed_value: {
      label: "60%"
      value: "0.60"
    }
    allowed_value: {
      label: "65%"
      value: "0.65"
    }
    allowed_value: {
      label: "70%"
      value: "0.70"
    }
    allowed_value: {
      label: "75%"
      value: "0.75"
    }
    allowed_value: {
      label: "80%"
      value: "0.80"
    }
    allowed_value: {
      label: "85%"
      value: "0.85"
    }
    allowed_value: {
      label: "90%"
      value: "0.90"
    }
    allowed_value: {
      label: "95%"
      value: "0.95"
    }
    allowed_value: {
      label: "100%"
      value: "1"
    }
  }

}
