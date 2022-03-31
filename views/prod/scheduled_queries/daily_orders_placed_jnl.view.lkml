view: daily_orders_placed_jnl {
  derived_table: {
    datagroup_trigger: toolstation_core_datagroup
    sql:

      with base as (

      select
      date(placedDate) date,

      case
      when paymentType like '%paypal%' and salesChannel = 'eBay' then 'WK'
      when paymentType like '%braintree%' and salesChannel = 'eBay' then 'WK'
      when paymentType like '%paypal%' and siteUID <> 'WK' then 'WW'
      when paymentType like '%braintree%' and siteUID <> 'WK' then 'WW'
      When t.parentOrderUID like 'QCC%' Then 'CC'
      else siteUID
      end as siteUID,
      case when p.payment_type like '%paypal%' then p.payment_type else paymentType end as paymentType,
      round(sum(grossSalesValue),2) as grossSalesValue

      from toolstation-data-storage.sales.transactions t
          left join toolstation-data-storage.sales.payments p
              on t.parentOrderUID = p.parentOrderUID

      where iscancelled = 0
      and date(placedDate) = current_date-1
      and productCode <> '86599'
      and paymentType <> 'account'

      group by 1, 2, 3

      union all

      select
      date(placedDate) date,
      case
      when paymentType like '%paypal%' and salesChannel = 'eBay' then 'WK'
      when paymentType like '%braintree%' and salesChannel = 'eBay' then 'WK'
      when paymentType like '%paypal%' and siteUID <> 'WK' then 'WW'
      when paymentType like '%braintree%' and siteUID <> 'WK' then 'WW'
      When t.parentOrderUID like 'QCC%' Then 'CC'
      else siteUID
      end as siteUID,
      case when p.payment_type like '%paypal%' then p.payment_type else paymentType end as paymentType,
      round(sum(grossSalesValue),2) as grossSalesValue

      from toolstation-data-storage.sales.transactions_incomplete t
          left join toolstation-data-storage.sales.payments p
              on t.parentOrderUID = p.parentOrderUID

      where lower(t.status) <> 'cancelled'
      and date(placedDate) = current_date-1
      and productCode <> '86599'
      and paymentType <> 'account'

      group by 1,2,3

      union all

      select
      date(placedDate) date,
      case
      when paymentType like '%paypal%' and salesChannel = 'eBay' then 'WK'
      when paymentType like '%braintree%' and salesChannel = 'eBay' then 'WK'
      when paymentType like '%paypal%' and siteUID <> 'WK' then 'WW'
      when paymentType like '%braintree%' and siteUID <> 'WK' then 'WW'
      When t.parentOrderUID like 'QCC%' Then 'CC'
      else siteUID
      end as siteUID,
      case when p.payment_type like '%paypal%' then p.payment_type else paymentType end as paymentType,
      round(sum(grossSalesValue),2) as grossSalesValue

      from toolstation-data-storage.sales.transactions_incomplete t
          left join toolstation-data-storage.sales.payments p
              on t.parentOrderUID = p.parentOrderUID

      where lower(t.status) = 'cancelled'
      and date(placedDate) = current_date-1
      and date(transactionDate) is not null
      and date(transactionDate) > date(placedDate)
      and productCode <> '86599'
      and paymentType <> 'account'

      group by 1,2,3
      )

      ,pre as (
      SELECT
      site.siteUID,
      format('%03d', cast(site.costCentreID as int64)) costCentre,
      date,
      CASE
      WHEN paymentType in ('card','cash','cheque') THEN '25120'
      WHEN paymentType like '%paypal%' THEN '25130'
      WHEN paymentType like 'braintree%' THEN '25160'
      ELSE NULL
      END as GL,
      case
      when paymentType like '%paypal%' then 'paypal'
      when paymentType like '%braintree%' then 'braintree'
      else paymentType
      end as paymentType,
      sum(grossSalesValue) Value

      FROM base
      LEFT JOIN toolstation-data-storage.locations.sites site
      on base.siteUID = site.siteUID

      Group by siteUID, costCentreID, GL, paymentType, date
      having value <> 0
      )
      select * from (
      (select
      siteUID,
      GL,

      costCentre || ' ' || case when costCentre = "993" then "ebay" else paymentType end || ' ' || format_date('%d.%m.%y', date) description,

      costCentre,
      Value

      from pre

      order by siteUID)

      union all

      (select
      siteUID,
      '25140',
      costCentre || ' ' || 'Orders Placed' || ' ' || format_date('%d.%m.%y', date) description,
      costCentre,
      round(sum(Value),2)*-1 value

      from pre
      group by 1,2,3,4
      ))

      order by 1,5 desc
       ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: gl {
    type: string
    sql: ${TABLE}.GL ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: cost_centre {
    type: string
    sql: ${TABLE}.costCentre ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.Value ;;
  }

}
