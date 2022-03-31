include: "/models/backend/config.model"
include: "/views/**/*.view"

explore: open_to_buy_model_new {

  label: "Open to Buy"
  required_access_grants: [is_super]


  sql_always_where:

  open_to_buy_model_new.department <> 'Deleted'
    AND
  open_to_buy_model_new.department <> 'Uncatalogued'
    AND
  open_to_buy_model_new.department <> 'Clearance'
    AND
  open_to_buy_model_new.department <> 'Marketing Vouchers'
    -- AND
  -- EXTRACT(YEAR from ${date_raw}) = EXTRACT(YEAR FROM CURRENT_DATE()) -- removes 2023 data

  ;;

}
