view: assumed_trade_rolling12 {
  derived_table: {
    sql:
      with base as (
      SELECT distinct
      c.customerUID,
      date_trunc(date(transactionDate), MONTH) as yearMonth,
      round(sum(coalesce(grossSalesValue,0)),2) as spend
      FROM `toolstation-data-storage.sales.transactions` t
      left join `toolstation-data-storage.customer.allCustomers` c
      on t.customerUID = c.customerUID
      where extract (year from transactionDate)>2022
      --and t.customerUID = "CWW18325710"
      group by all
      )

      select
      customerUID,
      yearMonth,
      round(AVG(spend)
               OVER(ORDER BY yearMonth ROWS BETWEEN 11 PRECEDING AND CURRENT ROW),2)
               AS MA_spend
       from base
       order by 1
      ;;
  }

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes
    primary_key: yes
  }

  # dimension: yearMonth {
  #   type: string
  #   sql: ${TABLE}.yearMonth ;;
  #   hidden: yes
  # }

  dimension_group: yearMonth {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.yearMonth ;;
  }

  dimension: MA_spend {
    type: string
    sql: ${TABLE}.MA_spend ;;
  }

}
