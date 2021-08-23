view: channel_budget {
  sql_table_name: `toolstation-data-storage.ts_finance.channelBudget`
    ;;

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

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

  dimension: date_channel {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${date_date}||${channel} ;;
  }

  dimension: fixed_funding {
    type: number
    sql: ${TABLE}.fixedFunding ;;
  }

  dimension: gross_profit {
    type: number
    sql: ${TABLE}.grossProfit ;;
  }

  dimension: net_sales {
    type: number
    sql: ${TABLE}.netSales ;;
  }

  dimension: retro_funding {
    type: number
    sql: ${TABLE}.retroFunding ;;
  }

}
