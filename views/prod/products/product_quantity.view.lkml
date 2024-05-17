view: product_quantity {
  derived_table: {
    sql:
    select
    parentOrderUID,
    sum(quantity) as quantity,
    row_number() OVER(ORDER BY parentOrderUID) AS prim_key
    from toolstation-data-storage.sales.transactions
    where productCode NOT IN ('85699', '00053','44842') and productCode not like "0%"
    group by 1;;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key ;;
    hidden: yes
  }

  dimension: quantity {
    type: number
    label: "Units (PB)"
    sql: ${TABLE}.quantity ;;
  }

  dimension: quantity_tier {
    type: tier
    label: "Units Tier (PB)"
    sql: ${quantity} ;;
    style: integer
    tiers: [0,1,2,3,4]
  }

  dimension: quantity_tier2 {
    type: tier
    label: "Units Tier (PB2)"
    sql: ${quantity} ;;
    style: integer
    tiers: [0, 1,2,3,4,5,6,7,8,9,10,11]
  }

  dimension: parent_order_uid {
    group_label: "Order Details"
    description: "Main order ID"
    type: string
    sql: ${TABLE}.parentOrderUID ;;
    hidden: yes
  }

}
