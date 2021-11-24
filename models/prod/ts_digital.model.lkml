include: "/models/backend/config.model"
include: "/views/**/*.view"

label: "TS - Digital"


# explore: base {

#   label: "Product Conversion TESTING"
#   description: ""

#   conditionally_filter: {
#     filters: [
#       base.select_date_range: "Yesterday"
#     ]
#     unless: [
#       select_fixed_range
#     ]
#   }

#   sql_always_where:

#   ${period_over_period}

#     ;;

#     join: digital_product_conversion {
#       type: inner
#       relationship: one_to_many
#       sql_on:

#       ${base.base_date_date} = ${digital_product_conversion.date_date}

#       ;;
#     }

#   join: products {
#     type: inner
#     relationship: many_to_one
#     sql_on: ${digital_product_conversion.ga_sku}=${products.product_code} ;;
#   }

# }




include: "/explores/digital/*"
