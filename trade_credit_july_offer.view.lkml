view: trade_credit_july_offer {
  derived_table: {
    sql: with transactions as (

      select t.*
      from `toolstation-data-storage.sales.transactions` t
      where
      transactionDate >='2021-05-01'
      and isCancelled = 0
      and productCode <> '85699'
      order by transactionDate

      )

      ,tc_ids as (
      SELECT
                  accountID,
                  mainTradeCreditAccountUID,
                  tcAccountCreatedDate,
                  date_add(tcAccountCreatedDate, INTERVAL -30 day) as pre_sign_up,
                  date_add(tcAccountCreatedDate, INTERVAL 30 day) as end_offer_date,
                  date_add(tcAccountCreatedDate, INTERVAL 60 day) as after_offer_period,
                  creditLimit,
                  format_date('%m', tcAccountCreatedDate) as month
      FROM `toolstation-data-storage.customer.tradeCreditDetails`
      where format_date('%m', tcAccountCreatedDate) = '07'
      )

      select  mainTradeCreditAccountUID,
              sum(case when transactionDate between pre_sign_up and tcAccountCreatedDate then netsalesvalue else null end) as TotalPreOfferSpending,
              sum(case when transactionDate between tcAccountCreatedDate and end_offer_date then netsalesvalue else null end) as TotalOfferSpending,
              sum(case when transactionDate between end_offer_date and after_offer_period then netsalesvalue else null end) as TotalPostOfferSpending,
              count(distinct(case when transactionDate between pre_sign_up and tcAccountCreatedDate then parentorderuid else null end)) as pre_offer_orders,
              count(distinct(case when transactionDate  between tcAccountCreatedDate and end_offer_date then parentorderuid else null end)) as offer_orders,
              count(distinct(case when transactionDate between end_offer_date and after_offer_period then parentorderuid else null end)) as post_offer_orders,
              sum(case when transactionDate between pre_sign_up and tcAccountCreatedDate then netsalesvalue else null end) / count(distinct(case when transactionDate between pre_sign_up and tcAccountCreatedDate then parentorderuid else null end)) as pre_offer_AOV,
              sum(case when transactionDate between tcAccountCreatedDate and end_offer_date then netsalesvalue else null end) / count(distinct(case when transactionDate  between tcAccountCreatedDate and end_offer_date then parentorderuid else null end)) as offer_aov,
              sum(case when transactionDate between end_offer_date and after_offer_period then netsalesvalue else null end) / count(distinct(case when transactionDate between end_offer_date and after_offer_period then parentorderuid else null end)) as post_offer_aov

              -- sum(t2.netsalesvalue) as postOfferSpending
      from tc_ids

      left  join   transactions t1 on
      tc_ids.mainTradeCreditAccountUID = t1.customeruid


      group by 1
      order by mainTradeCreditAccountUID
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: main_trade_credit_account_uid {
    type: string
    primary_key: yes
    sql: ${TABLE}.mainTradeCreditAccountUID ;;
  }

  dimension: total_pre_offer_spending {
    type: number
    sql: ${TABLE}.TotalPreOfferSpending ;;
  }

  dimension: total_offer_spending {
    type: number
    sql: ${TABLE}.TotalOfferSpending ;;
  }

  dimension: total_post_offer_spending {
    type: number
    sql: ${TABLE}.TotalPostOfferSpending ;;
  }

  dimension: pre_offer_orders {
    type: number
    sql: ${TABLE}.pre_offer_orders ;;
  }

  dimension: offer_orders {
    type: number
    sql: ${TABLE}.offer_orders ;;
  }

  dimension: post_offer_orders {
    type: number
    sql: ${TABLE}.post_offer_orders ;;
  }

  dimension: pre_offer_aov {
    type: number
    sql: ${TABLE}.pre_offer_AOV ;;
  }

  dimension: offer_aov {
    type: number
    sql: ${TABLE}.offer_aov ;;
  }

  dimension: post_offer_aov {
    type: number
    sql: ${TABLE}.post_offer_aov ;;
  }

  set: detail {
    fields: [
      main_trade_credit_account_uid,
      total_pre_offer_spending,
      total_offer_spending,
      total_post_offer_spending,
      pre_offer_orders,
      offer_orders,
      post_offer_orders,
      pre_offer_aov,
      offer_aov,
      post_offer_aov
    ]
  }
}
