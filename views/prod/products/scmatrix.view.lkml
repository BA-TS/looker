view: scmatrix {
  sql_table_name: `toolstation-data-storage.range.SCMatrix`;;
    view_label: "SC Matrix"

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

  dimension: is_active {
    type: number
    sql: ${TABLE}.isActive ;;
    hidden: yes
  }

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
