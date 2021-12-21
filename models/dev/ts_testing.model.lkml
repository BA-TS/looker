include: "/models/backend/config.model"
include: "/views/**/*.view"

label: "TS - Development"

explore: sites {
  required_access_grants: [is_developer]
}

explore:  base {
  label: "DATE TESTING"
  required_access_grants: [is_developer]

  sql_always_where:

  ${period_over_period}

    ;;

}

explore: open_to_buy_model {
  label: "Open to Buy [TESTING]"
  required_access_grants: [is_developer]
  # sql_always_where:

  # ${date} > current_date() - 30

  # ;;
}
