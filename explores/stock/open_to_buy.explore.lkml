include: "/models/backend/config.model"
include: "/views/**/*.view"

explore: open_to_buy_model {
  label: "Open to Buy"
  sql_always_where: open_to_buy_model_new.department NOT IN('Deleted','Uncatalogued','Clearance','Marketing Vouchers')  ;;
  always_filter: {
    filters: [
      open_to_buy_model.budget_type: "0"
    ]
  }
  hidden: yes
}
