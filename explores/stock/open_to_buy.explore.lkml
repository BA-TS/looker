include: "/models/backend/config.model"
include: "/views/**/*.view"

explore: open_to_buy_model {
  label: "Open to Buy"
  required_access_grants: [is_super]
  # sql_always_where:

  # ${date_raw} < DATE_TRUNC(DATE_SUB(DATE_ADD(DATE_TRUNC(CURRENT_DATE, YEAR),INTERVAL 1 YEAR), INTERVAL 1 DAY), MONTH)
  # AND ${date_raw} > DATE_SUB(DATE_TRUNC(CURRENT_DATE, YEAR),INTERVAL 1 DAY)

  # ;;

  sql_always_where:

  open_to_buy_model.department <> 'Deleted' AND open_to_buy_model.department <> 'Uncatalogued' AND open_to_buy_model.department <> 'Clearance'

  ;;

}
