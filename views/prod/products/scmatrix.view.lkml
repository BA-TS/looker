# The name of this view in Looker is "Scmatrix"
view: scmatrix {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `toolstation-data-storage.range.SCMatrix`
    ;;
    view_label: "SC Matrix"
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: active_from {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    hidden: yes
    sql: ${TABLE}.activeFrom ;;
  }

  dimension_group: active_to {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    hidden: yes
    sql: ${TABLE}.activeTo ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Is Active" in Explore.

  dimension: is_active {
    type: number
    sql: ${TABLE}.isActive ;;
    hidden: yes
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.


  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
    hidden: yes
  }

  dimension: sc_cost {
    label: "SC Cost"
    type: string
    sql: ${TABLE}.SC_Cost ;;
  }

  dimension: sc_matrix {
    label: "SC Matrix"
    type: string
    sql: ${TABLE}.SC_Matrix ;;
  }

  dimension: sc_size {
    label: "SC Size"
    type: string
    sql: ${TABLE}.SC_Size ;;
  }

  dimension: sc_usage {
    label: "SC Usage"
    type: string
    sql: ${TABLE}.SC_Usage ;;
  }


}
