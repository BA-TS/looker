view: sales_alerts {
  sql_table_name: `toolstation-data-storage.looker_persistent_tables.sales_alerting`;;

  dimension: deviation_flag {
    type: number
    sql: -0.05 ;;
    hidden: yes
  }

  dimension: flag {
    type: number
    sql: 1 ;;
    hidden: yes
  }

  dimension: ok {
    type: number
    sql: 0 ;;
    hidden: yes
  }

  dimension: warning_threshold {
    type: number
    sql: 3 ;;
    hidden: yes
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw, date
    ]
    convert_tz: no
    datatype: date
    sql:${TABLE}.date;;
  }

  dimension: sales_channel {
    type: string
    sql: ${TABLE}.salesChannel ;;
  }

  dimension: net_sales {
    type: number
    sql:${TABLE}.net_sales;;
    hidden: yes
  }

  dimension: net_sales_wow {
    type: number
    sql:${TABLE}.net_sales_1w;;
    hidden: yes
  }

  dimension: net_sales_2wow {
    type: number
    sql:${TABLE}.net_sales_2w;;
    hidden: yes
  }

  dimension: net_sales_yoy {
    type: number
    sql:${TABLE}.net_sales_1y;;
    hidden: yes
  }

  dimension: net_sales_2yoy {
    type: number
    sql:${TABLE}.net_sales_2y;;
    hidden: yes
  }

  measure: net_sales_value {
    type: sum
    sql: ${net_sales}  ;;
  }

  measure: net_sales_wow_value {
    type: sum
    sql: ${net_sales_wow} ;;
    hidden: yes
  }

  measure: net_sales_wow_change {
    type: number
    group_label: "WoW"
    label: "WoW Change £"
    sql:${net_sales_value} - ${net_sales_wow_value};;
    value_format_name: gbp
  }

  measure: net_sales_wow_percent {
    type: number
    group_label: "WoW"
    label: "WoW Change %"
    sql:safe_divide(${net_sales_value}, ${net_sales_wow_value}) - 1;;
    value_format_name: percent_2
  }

  measure: net_sales_2wow_value {
    type: sum
    sql: ${net_sales_2wow} ;;
    hidden: yes
  }

  measure: net_sales_2wow_change {
    type: number
    group_label: "WoW2"
    label: "2WoW Change £"
    sql:${net_sales_value} - ${net_sales_2wow_value};;
    value_format_name: gbp
  }

  measure: net_sales_2wow_percent {
    type: number
    group_label: "WoW2"
    label: "2WoW Change %"
    sql:safe_divide(${net_sales_value}, ${net_sales_2wow_value}) - 1;;
    value_format_name: percent_2
  }

  measure: net_sales_yoy_value {
    type: sum
    sql: ${net_sales_yoy} ;;
    hidden: yes
  }

  measure: net_sales_yoy_change {
    type: number
    group_label: "YoY"
    label: "YoY Change £"
    sql:${net_sales_value} - ${net_sales_yoy_value};;
    value_format_name: gbp
  }

  measure: net_sales_yoy_percent {
    type: number
    group_label: "YoY"
    label: "YoY Change %"
    sql:safe_divide(${net_sales_value}, ${net_sales_yoy_value}) - 1;;
    value_format_name: percent_2
  }

  measure: net_sales_2yoy_value {
    type: sum
    sql: ${net_sales_2yoy} ;;
    hidden: yes
  }

  measure: net_sales_2yoy_change {
    type: number
    group_label: "2YoY"
    label: "2YoY Change £"
    sql:${net_sales_value} - ${net_sales_2yoy_value};;
    value_format_name: gbp
  }

  measure: net_sales_2yoy_percent {
    type: number
    group_label: "2YoY"
    label: "2YoY Change %"
    sql:safe_divide(${net_sales_value}, ${net_sales_2yoy_value}) - 1;;
    value_format_name: percent_2
  }

  measure: wow_flag {
    type: number
    label: "WoW Warning"
    sql:if (${net_sales_wow_percent} <= ${deviation_flag}, ${flag} , 0 );;
  }

  measure: 2wow_flag {
    type: number
    label: "2WoW Warning"
    sql: if (${net_sales_2wow_percent} <= ${deviation_flag}, ${flag} , 0 );;
  }
  measure: yoy_flag {
    type: number
    label: "YoY Warning"
    sql:if (${net_sales_yoy_percent} <= ${deviation_flag}, ${flag} , 0 );;
  }

  measure: 2yoy_flag {
    type: number
    label: "2YoY Warning"
    sql:if (${net_sales_2yoy_percent} <= ${deviation_flag}, ${flag} , 0 );;
  }

  measure: any_flag {
    type: number
    label: "Overall Warning"
    sql:if (
        if (${wow_flag} = ${flag}, ${flag}, ${ok})+
        if (${2wow_flag} = ${flag}, ${flag}, ${ok})+
        if (${yoy_flag} = ${flag}, ${flag}, ${ok})+
        if(${2yoy_flag} = ${flag}, ${flag}, ${ok})
       >= ${warning_threshold}, ${flag}, ${ok});;
  }

  measure: count_of_dates {
    type: count_distinct
    sql: ${date_date} ;;
    hidden: yes # only used by Data Tests
  }
}
