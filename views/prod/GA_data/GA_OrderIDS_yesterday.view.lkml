view: ga_orderids_yesterday {
  derived_table: {
    sql: SELECT distinct
      date,
      transactions.OrderID as OrderIDs,
      transactions.item_id,
      sum(transactions.net_value) as netValue,
      row_number() over () P_K
      FROM `toolstation-data-storage.Digital_reporting.GA_DigitalTransactions_*` as aw left join unnest(transactions) as transactions
      where
      _TABLE_SUFFIX = format_date("%Y%m%d", date_sub(current_date(), INTERVAL 1 day)) and
      ((aw.item_id = transactions.item_id) or (aw.item_id is not null and transactions.item_id is null) or (aw.item_id is null and transactions.item_id is null))
      and transactions.OrderID is not null
      group by 1,2,3
      order by 2 desc
             ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [date]
    sql: ${TABLE}.date ;;
  }

  dimension: P_K {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension: order_id {
    view_label: "GA4 Transactions"
    label: "Transaction ID"
    description: "Order ID of order where order was seen in GA4"
    type: string
    sql: ${TABLE}.OrderIDs ;;
  }

  measure: orders {
    view_label: "GA4 Transactions"
    label: "Orders"
    description: "Total orders seen in GA4"
    #group_label: "Measures"
    type: count_distinct
    sql: ${order_id} ;;
  }

  measure: net_value {
    view_label: "GA4 Transactions"
    label: "Net Revenue"
    type: sum
    value_format_name: gbp
    sql: ${TABLE}.netValue ;;
  }

  dimension: item_id {
    type: string
    view_label: "Products"
    group_label: "Product Details"
    hidden: yes
    label: "Product Code"
    sql: case when ${TABLE}.item_id in ('44842') then 'null' else ${TABLE}.item_id end;;
  }

}