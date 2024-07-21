view: return_orders {
  derived_table: {
    sql:
    select
      distinct t.transactionUID as return_ID,
      date(transactionDate) as returnDate,
      Case when UPPER(t.orderReason) like '%CUSTOMER CHANGED MIND%' then 'Customer_Changed_Mind'
      when UPPER(t.orderReason) like '%DAMAGED%' OR UPPER(t.orderReason) like '%FAULTY%'  then 'Damaged/Faulty'
      else 'Others' END AS return_reason,
      t.orderSpecialRequests,
      TRIM(REGEXP_EXTRACT(oc.comments, r'This order is a return for(.{12})')) as link_OrderID
      from `toolstation-data-storage.sales.transactions` t
      left Join
      `toolstation-data-storage.sales.order_comments` oc
      On t.transactionUID = oc.order_id
      where
      --date(t.placedDate) >= "2023-01-01"
      --and
      t.transactionLineType = "Return" and t.productCode not like '0%';;
  }

  dimension: return_ID {
    type: string
    sql: ${TABLE}.return_ID ;;
  }

  dimension: return_reason{
    type: string
    sql: ${TABLE}.return_reason ;;
  }

  dimension: order_special_requests{
    type: string
    sql: ${TABLE}.orderSpecialRequests;;
  }

  dimension: return_date {
    type: date
    sql: ${TABLE}.returnDate ;;
  }
}
