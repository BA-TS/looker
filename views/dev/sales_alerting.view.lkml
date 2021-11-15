# The name of this view in Looker is "Sales Alerting"
view: sales_alert{
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `toolstation-data-storage.looker_persistent_tables.sales_alerting`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

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

  dimension: net_sales {
    type: number
    sql: ${TABLE}.net_sales ;;
    hidden: yes
  }

  measure: total_net_sales {
    type: sum
    sql: ${net_sales} ;;
    hidden: yes
  }

  measure: average_net_sales {
    type: average
    sql: ${net_sales} ;;
    hidden: yes
  }

  dimension: net_sales_1w {
    type: number
    sql: ${TABLE}.net_sales_1w ;;
  }

  dimension: net_sales_2w {
    type: number
    sql: ${TABLE}.net_sales_2w ;;
  }

  dimension: net_sales_1y {
    type: number
    sql: ${TABLE}.net_sales_1y ;;
  }

  dimension: net_sales_2y {
    type: number
    sql: ${TABLE}.net_sales_2y ;;
  }

  dimension: sales_channel {
    type: string
    sql: ${TABLE}.salesChannel ;;
  }

}
