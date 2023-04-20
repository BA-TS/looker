# include: "/views/**/*.view"

# explore: base {

#   extends: []
#   label: "Budget"
#   description: "Explore Toolstation budget data."

#   always_filter: {
#     filters: [
#       select_date_type: "Calendar"
#     ]
#   }

#   conditionally_filter: {

#     filters: [
#       select_date_range: "Yesterday"
#     ]
#     unless: [
#       select_fixed_range,
#       dynamic_fiscal_year,
#       dynamic_fiscal_half,
#       dynamic_fiscal_quarter,
#       dynamic_fiscal_month,
#       dynamic_actual_year,
#       catalogue.catalogue_name,
#       catalogue.extra_name,
#       combined_week,
#       combined_month,
#       combined_quarter,
#       combined_year
#     ]

#   }

#   fields: [
#     ALL_FIELDS*,
#   ]

#   sql_always_where:

#   ${period_over_period}

#         ;;

#   join: total_budget {
#     view_label: "Budget"
#     type: left_outer
#     relationship: one_to_one
#     sql_on: ${base.date_date} = ${total_budget.total_budget_date};;
#   }


#   join: channel_budget {
#     view_label: "Budget"
#     type:  left_outer
#     relationship: many_to_one
#     sql_on:
#         ${base.date_date}=${channel_budget.date}
#       ;;
#   }

#   join: category_budget {
#     view_label: "Budget"
#     type: left_outer
#     relationship: many_to_one
#     sql_on:
#         ${base.date_date}=${category_budget.date}
#       ;;
#   }

#   join: site_budget {
#     view_label: "Budget"
#     type: left_outer
#     relationship: many_to_one
#     sql_on:
#         ${base.date_date} = ${site_budget.date_date}
#       ;;
#   }

#   join: products {
#     type:  left_outer
#     relationship: many_to_one
#     sql_on:
#       UPPER(${category_budget.department})=UPPER(${products.department})
#       ;;
#   }

#   join: sites {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${site_budget.site_uid}=${sites.site_uid} ;;
#   }

#   join: calendar_completed_date{
#     from:  calendar
#     view_label: "Date"
#     type:  inner
#     relationship:  many_to_one
#     sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
#   }
# }
