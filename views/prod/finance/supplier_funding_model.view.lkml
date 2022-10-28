
view: supplier_funding_model {

  sql_table_name: `toolstation-data-storage.looker_custom_tables.supplier_funding_model`
    ;;

  dimension: daily_amount {
    label: "Daily Amount"
    type: number
    sql: ${TABLE}.dailyAmount ;;
    hidden: yes
  }

  dimension_group: date {
    group_label: ""
    label: ""
    view_label: "Date"
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: dealtrack_id {
    label: "DealTrack ID"
    type: string
    sql: ${TABLE}.dealtrackID ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: funding_reason {
    type: string
    sql: ${TABLE}.fundingReason ;;
  }

  dimension: support_type {
    type: string
    sql: ${TABLE}.supportType ;;
  }

  dimension: total_amount {
    type: number
    sql: ${TABLE}.totalAmount ;;
  }

  dimension: total_days {
    type: number
    sql: ${TABLE}.totalDays ;;
  }

  dimension_group: valid_from {
    view_label: "Date"
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.validFrom ;;
  }

  dimension_group: valid_to {
    view_label: "Date"
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.validTo ;;
  }


  measure: average_daily_amount {
    type: average
    sql: ${daily_amount} ;;
  }



}
