# The name of this view in Looker is "Po Numbers"
view: po_numbers {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `toolstation-data-storage.ts_finance.PO_numbers`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Order ID" in Explore.

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
