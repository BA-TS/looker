# If necessary, uncomment the line below to include explore_source.

# include: "transactions.explore.lkml"

view: scorecard_trade_customers_filter {
  derived_table: {
    explore_source: base {
      column: customer_uid { field: customers.customer_uid }
      filters: {
        field: base.select_date_range
        value: "before 1 months ago"
      }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_type
        value: "Calendar"
      }
      filters: {
        field: transactions.has_trade_account
        value: "Yes"
      }
    }
  }
  dimension: customer_uid {
    label: "Customers Customer UID"
    description: ""
    sql: ${TABLE}.customer_uid ;;
    hidden: yes
  }

  dimension: scorecard_trade_customers_filter {
    group_label: "Trade Customers Flags"
    label:"Trade Customers Filter"
    type: yesno
    sql: ${customer_uid} is not null ;;
  }


}
