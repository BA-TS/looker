# The name of this view in Looker is "Po Numbers"
view: po_numbers {
  sql_table_name: `toolstation-data-storage.ts_finance.PO_numbers`;;

  dimension: order_id {
    label: "Order ID"
    description: "Transaction Parent Order UID"
    primary_key: yes
    type: string
    sql: ${TABLE}.orderID ;;
    hidden:  yes
  }

  dimension: po_number {
    label: "PO Number"
    group_label: "Purchase Details"
    description: "PO number provided by the customer at point of purchase"
    type: string
    sql: ${TABLE}.PO_Number ;;
  }
}
