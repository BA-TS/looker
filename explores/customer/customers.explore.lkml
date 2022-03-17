include: "/views/prod/department_specific/customer/*.view"

explore: customers {

  label: "Customer"
  description: "Explore Toolstation customer data."

  required_access_grants: [can_use_customer_information]

  join: trade_customers {
    view_label: "Budget"
    type: left_outer
    relationship: one_to_one
    sql_on: ${customers.customer_uid} = ${trade_customers.customer_uid};;
  }

  join: trade_credit_ids {
    type: left_outer
    relationship: many_to_one
    sql_on: ${customers.customer_uid} = ${trade_credit_ids.customer_uid} ;;
  }

  join: trade_credit_details {
    type: left_outer
    relationship: many_to_one
    sql_on: ${trade_credit_ids.main_trade_credit_account_uid} = ${trade_credit_details.main_trade_credit_account_uid} ;;
  }

}
