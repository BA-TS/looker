# include: "/views/**/base.view"
# include: "/views/**/calendar.view"
# include: "/views/**/transactions.view"
# include: "/views/**/sites.view"
# include: "/views/**/catalogue.view"
# include: "/views/**/customers.view"
# include: "/views/**/bdm_customers.view"
# include: "/views/**/bdm_targets.view"
# include: "/views/**/key_accounts_targets.view"
# include: "/views/**/bdm_ledger.view"
# include: "/views/**/key_accounts_ledger.view"
# include: "/views/**/key_accounts_customers.view"
# include: "/views/**/*customer_segmentation.view"
# include: "/views/**/*trade_customers.view"
# include: "/views/**/po_numbers.view"
# include: "/views/**/products.view"
# include: "/views/**/targets.view"
# include: "/views/**/bdm_ka_customers.view"
# include: "/views/**/ledger.view"
# # include: "/views/**/trade_credit_details.view"
# include: "/views/**/trade_credit_ids.view"
# include: "/views/**/incremental.view"

# persist_with: ts_transactions_datagroup

# explore: bdm_ka_customers {
#   required_access_grants: [lz_testing]
#   view_name: bdm_ka_customers
#   label: "BDM LZ Test"
#   always_filter: {
#     filters: [
#       base.select_date_reference: "Transaction"
#     ]
#   }

#   conditionally_filter: {
#     filters: [
#       base.select_date_range: "this month",
#       bdm_ka_customers.is_active: "Yes",
#       bdm_ka_customers.team: "BDM",
#       bdm_ka_customers.bdm: ""
#     ]
#     unless: [
#       base.select_fixed_range,
#       base.dynamic_fiscal_year,
#       base.dynamic_fiscal_half,
#       base.dynamic_fiscal_quarter,
#       base.dynamic_fiscal_month,
#       base.dynamic_actual_year,
#       base.combined_week,
#       base.combined_month,
#       base.combined_quarter,
#       base.combined_year,
#       base.separate_month,
#     ]
#   }

#   fields: [
#     ALL_FIELDS*,
#     -catalogue*,
#   ]

#   sql_always_where:${base.period_over_period};;

#   join: calendar_completed_date{
#     fields: [calendar_completed_date.date,calendar_completed_date.calendar_year,calendar_completed_date.calendar_year_month,calendar_completed_date.calendar_year_month2,calendar_completed_date.calendar_year_quarter]
#     from:  calendar
#     view_label: "Date"
#     type:  inner
#     relationship:  many_to_one
#     sql_on: ${base.date_date}=${calendar_completed_date.date} ;;
#   }

#   join: transactions {
#     type: left_outer
#     relationship: one_to_many
#     fields: [transactions.has_trade_account,transactions.number_of_branches,transactions.number_of_unique_products,transactions.number_of_transactions,transactions.spc_net_sales,transactions.aov_net_sales,transactions.aov_units,transactions.total_margin_incl_funding,transactions.total_net_sales,transactions.payment_type,transactions.product_department,transactions.number_of_departments]
#     sql_on:  ${bdm_ka_customers.customer_uid}=${transactions.customer_uid};;
#   }

#     join: base {
#     view_label: "Date"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${base.base_date_date} = ${transactions.transaction_date_filter};;
#   }

#   join: catalogue {
#     view_label: "Catalogue"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${base.base_date_date} BETWEEN ${catalogue.catalogue_live_date} AND ${catalogue.catalogue_end_date} ;;
#   }

#   join: targets {
#     view_label: "Targets"
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${targets.bdm} = ${bdm_ka_customers.bdm} and ${targets.team} = ${bdm_ka_customers.team} and ${targets.month}=${calendar_completed_date.calendar_year_month2};;
#   }

#   join: ledger {
#     type: left_outer
#     relationship: many_to_one
#     sql_on: ${ledger.bdm} = ${bdm_ka_customers.bdm} and ${ledger.customer_uid} = ${bdm_ka_customers.customer_uid};;
#   }

#   join: customers {
#     view_label: "Customers"
#     fields: [customers.customer__company]
#     type :  left_outer
#     relationship: many_to_one
#     sql_on: ${bdm_ka_customers.customer_uid}=${customers.customer_uid} ;;
#   }

#   join: incremental {
#     type:  left_outer
#     relationship: many_to_one
#     # sql_on: ${calendar_completed_date.calendar_year_month2}=${incremental.calendar_year_month} and ${ledger.bdm} = ${incremental.bdm} and ${ledger.team} = ${incremental.team}
#     # ;;
#     # sql_on: ${calendar_completed_date.calendar_year_month2}=${incremental.calendar_year_month} and ${bdm_ka_customers.customer_uid} = ${incremental.customer_uid}
#     # ;;
#     sql_on: ${calendar_completed_date.calendar_year_month2}=${incremental.calendar_year_month} and ${ledger.bdm} = ${incremental.bdm}
#       ;;
#   }
# }
