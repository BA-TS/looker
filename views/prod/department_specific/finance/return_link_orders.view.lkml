view: return_link_orders {
derived_table: {
  sql:
    WITH link_orders_tran as
    (select
    oc.order_id,
    t.parentOrderUID,
    t.transactionUID as link_OrderID,
    from `toolstation-data-storage.sales.transactions` t
    left Join
    `toolstation-data-storage.sales.order_comments` oc
    On t.transactionUID = TRIM(REGEXP_EXTRACT(oc.comments, r'This order is a return for(.{12})'))
    where date(t.placedDate) >= "2023-01-01" and t.productCode not like '0%'
    ),

    link_orders_parent as (
    select
    oc.order_id,
    t.parentOrderUID,
    t.transactionUID as link_OrderID,
    from `toolstation-data-storage.sales.transactions` t
    left Join
    `toolstation-data-storage.sales.order_comments` oc
    On t.parentOrderUID = TRIM(REGEXP_EXTRACT(oc.comments, r'This order is a return for(.{12})'))
    where date(t.placedDate) >= "2022-01-01" and t.productCode not like '0%'),

    Join_tran_parent as
    (select * from link_orders_tran
    UNION DISTINCT
    select * from link_orders_parent)

    select
    DISTINCT row_number () over () as prim_key,
    *
    from Join_tran_parent;;
}

  dimension: prim_key {
    type: number
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: order_id {
    label: "Return Order UID "
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: parent_order_uid {
    type: string
    sql:${TABLE}.parentOrderUID ;;
  }

  dimension: transaction_uid {
    type: string
    sql:${TABLE}.link_OrderID ;;
  }

 }
