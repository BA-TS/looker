
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

}
