include: "/models/backend/config.model"
include: "/views/**/*.view"

label: "ls_testing"

explore: cltv_orders {
  label: "orders"
  required_access_grants: [is_super]
  join:  cltv_customers{
    type: inner
    relationship: many_to_one
    sql_on: ${cltv_orders.CUSTOMERUID}=${cltv_customers.CUSTOMERUID}

    ;;

  }




  }
