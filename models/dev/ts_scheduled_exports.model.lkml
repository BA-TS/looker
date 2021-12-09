include: "/views/**/*.view.lkml"                # include all views in the views/ folder in this project

label: "TS - Scheduled Exports"

explore: daily_orders_placed_jnl {
  required_access_grants: [is_developer]
  label: "DAILY - Orders Placed JNL"
}
