view: dgtl_product_conversion {
  sql_table_name: `toolstation-data-storage.digitalreporting.DGTL_product_conversion`
    ;;

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: exit_rate {
    type: number
    sql: ${TABLE}.exitRate ;;
  }

  dimension: ga_brand {
    type: string
    sql: ${TABLE}.ga_brand ;;
  }

  dimension: ga_category {
    type: string
    sql: ${TABLE}.ga_category ;;
  }

  dimension: ga_entrances {
    type: number
    sql: ${TABLE}.ga_entrances ;;
  }

  dimension: ga_page_title {
    type: string
    sql: ${TABLE}.ga_pageTitle ;;
  }

  dimension: ga_product_conversion {
    type: number
    sql: ${TABLE}.ga_productConversion ;;
  }

  dimension: ga_product_exits {
    type: number
    sql: ${TABLE}.ga_productExits ;;
  }

  dimension: ga_sku {
    type: string
    sql: ${TABLE}.ga_SKU ;;
  }

  dimension: ga_total_product_page_views {
    type: number
    sql: ${TABLE}.ga_total_product_page_views ;;
  }

  dimension: ga_total_product_revenue {
    type: number
    sql: ${TABLE}.ga_total_productRevenue ;;
  }

  dimension: ga_total_product_sold {
    type: number
    sql: ${TABLE}.ga_total_product_sold ;;
  }

  dimension: ga_total_product_units {
    type: number
    sql: ${TABLE}.ga_total_productUnits ;;
  }

  dimension: ga_total_time_on_page_sec {
    type: number
    sql: ${TABLE}.ga_total_time_on_page_sec ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
