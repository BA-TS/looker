# The name of this view in Looker is "Ran Queries"
view: ran_queries {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `toolstation-data-storage.audit.ranQueries` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Cache Hit" in Explore.

  dimension: cache_hit {
    type: yesno
    sql: ${TABLE}.cache_hit ;;
  }

  dimension: cost_in_gbp {
    type: number
    sql: ${TABLE}.cost_in_gbp ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cost_in_gbp {
    type: sum
    sql: ${cost_in_gbp}
    label: "Total Cost in GBP";;  }


  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension: job_id_computed {
    type: string
    sql: ${TABLE}.job_id_computed
    label: "Job Type";;
  }

  dimension: query {
    type: string
    sql: ${TABLE}.query
    label: "Query Text";;
  }

  dimension_group: run_start_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.run_start_date ;;
  }

  dimension: run_start_hour {
    type: number
    sql: ${TABLE}.run_start_hour ;;
  }

  dimension: user_email {
    type: string
    sql: ${TABLE}.user_email
    label: "User";;
  }
  measure: count {
    type: count
  }
}
