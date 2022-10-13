# The name of this view in Looker is "Digital Promo SKU Looker"
view: digital_promo_sku_looker {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `toolstation-data-storage.digital.digital_promoSKU_looker`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Department" in Explore.

  dimension: department {
    type: string
    sql: ${TABLE}.Department ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: end {
    type: time
    description: "%d/%m/%E4Y"
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
    sql: ${TABLE}.End_date ;;
  }

  dimension: promo_type {
    type: string
    sql: ${TABLE}.Promo_type ;;
  }

  dimension: sku {
    type: number
    sql: ${TABLE}.SKU ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sku {
    type: sum
    sql: ${sku} ;;
  }

  measure: average_sku {
    type: average
    sql: ${sku} ;;
  }

  dimension_group: start {
    type: time
    description: "%m/%d/%E4Y"
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
    sql: ${TABLE}.Start_Date ;;
  }

  dimension: subdepartment {
    type: string
    sql: ${TABLE}.Subdepartment ;;
  }

  dimension: week_cat {
    type: string
    sql: ${TABLE}.Week_Cat ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
