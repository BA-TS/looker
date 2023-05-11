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
    type: string
    sql: ${TABLE}.orderID ;;
  }

  dimension: po_number {
    type: string
    sql: ${TABLE}.PO_Number ;;
  }

}
