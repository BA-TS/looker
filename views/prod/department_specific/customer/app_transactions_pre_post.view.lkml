include: "/views/**/*customers.view"
include: "/views/**/*transactions.view"

view: app_transactions_pre_post {
  derived_table: {
    explore_source: base {
      bind_all_filters: yes
      column: customer_uid { field: customers.customer_uid }
      column: first_transaction_date { field: transactions.first_transaction_date }
      column: first_app_transaction_date { field: transactions.first_app_transaction_date }
    }
  }

  dimension: customer_uid {
    label: "Customers Customer UID"
    hidden: yes
  }

  dimension: first_app_transaction_date {
    group_label: "App Transactions - Pre vs Post (Apr 24)"
    label: "First APP Transaction Date"
    sql: ${TABLE}.first_app_transaction_date ;;
    type: date
  }

  dimension: first_transaction_date {
    label: "Measures First Transaction Date"
    description: "First transaction date"
    type: date
    hidden: yes
    sql: date(${TABLE}.first_transaction_date);;
  }

  dimension: first_transaction_date_same_as_app {
    type: yesno
    hidden: yes
    sql: ${first_app_transaction_date}=${first_transaction_date};;
  }

  dimension: days_since_first_app_transaction_date {
    type: number
    hidden: yes
    sql: date_diff(${transactions.transaction_date},${first_app_transaction_date},day);;
  }

  dimension: 12_weeks_pre_first_app_transaction_date {
    group_label: "App Transactions - Pre vs Post (Apr 24)"
    label: "Pre vs Post First App Transaction (<12 Weeks)"
    type: string
    sql:
    case
    when ${days_since_first_app_transaction_date} between 0 and 84 then "Post"
    when ${days_since_first_app_transaction_date} between -84 and -0 then "Pre"
    else null
    end
    ;;
  }
}
