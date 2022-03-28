view: daily_transactions_incomplete {
  derived_table: {
    datagroup_trigger: toolstation_transactions_datagroup
    sql: select
      i.parentOrderUID,
      i.placedDate,
      i.paymentType,
      i.status,
      i.siteUID,
      tc.mainTradeCreditAccountUID,
      tc.accountID,
      tc.creditLimit,
      tc.remainingBalance,
      sum(i.grossSalesValue) as OrderValue

      from `toolstation-data-storage.sales.transactions_incomplete` i

      LEFT JOIN `toolstation-data-storage.customer.tradeCreditDetails` tc

      on i.customerUID = tc.mainTradeCreditAccountUID

      where  status = "Pending" and paymentType = "account"

      group by 1,2,3,4,5,6,7,8,9

      order by placedDate desc
      ;;
  }


  dimension: parent_order_uid {
    type: string
    sql: ${TABLE}.parentOrderUID ;;
  }

  dimension_group: placed_date {
    type: time
    sql: ${TABLE}.placedDate ;;
  }

  dimension: payment_type {
    type: string
    sql: ${TABLE}.paymentType ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: main_trade_credit_account_uid {
    type: string
    sql: ${TABLE}.mainTradeCreditAccountUID ;;
  }

  dimension: account_id {
    type: string
    sql: ${TABLE}.accountID ;;
  }

  dimension: credit_limit {
    type: number
    sql: ${TABLE}.creditLimit ;;
  }

  dimension: remaining_balance {
    type: number
    sql: ${TABLE}.remainingBalance ;;
  }

  dimension: order_value {
    type: number
    sql: ${TABLE}.OrderValue ;;
  }


}
