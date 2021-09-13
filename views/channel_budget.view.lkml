view: channel_budget {
  sql_table_name: `toolstation-data-storage.ts_finance.channelBudget`
    ;;

  dimension: channel {
    hidden: yes
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension_group: date {
    hidden: yes
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

  dimension: date_channel {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${date_date}||${channel} ;;
  }

  dimension: fixed_funding {
    hidden: yes
    type: number
    sql: ${TABLE}.fixedFunding ;;
  }

  dimension: gross_profit {
    hidden: yes
    type: number
    sql: ${TABLE}.grossProfit ;;
  }

  dimension: net_sales {
    type: number
    sql: ${TABLE}.netSales ;;
    hidden: yes
  }

  dimension: retro_funding {
    hidden: yes
    type: number
    sql: ${TABLE}.retroFunding ;;
  }

  measure: channel_net_sales_budget {
    description: "Budget Net Sales at Channel level only"
    type: sum
    sql: ${net_sales} ;;
  }
}
