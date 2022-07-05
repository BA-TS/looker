# The name of this view in Looker is "Bundle Orders Detail"
view: bundle_orders_detail {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `toolstation-data-storage.looker_mart.bundle_orders_detail`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: bundle {
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
    sql: ${TABLE}.bundle_date ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Bundle ID" in Explore.

  dimension: bundle_id {
    type: string
    sql: ${TABLE}.bundleID ;;
  }

  dimension: bundle_order_size {
    type: number
    sql: ${TABLE}.bundle_order_size ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_bundle_order_size {
    type: sum
    sql: ${bundle_order_size} ;;
  }

  measure: average_bundle_order_size {
    type: average
    sql: ${bundle_order_size} ;;
  }

  dimension: site_name {
    type: string
    sql: ${TABLE}.siteName ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  measure: count {
    type: count
    drill_fields: [site_name]
  }
}
