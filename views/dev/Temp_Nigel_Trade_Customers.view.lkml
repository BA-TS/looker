# # include: "/explores/sales/transactions.explore.lkml"

# view: temp_nigel_trade_customers {
#   view_label: "Trade Account Customers"
#   derived_table: {
#     explore_source: base {
#       column: customer_uid { field: customers.customer_uid }
#       column: is_trade { field: customers.is_trade }
#       column: has_trade_accounts { field: transactions.has_trade_account }
#       column: total_gross_sales { field: transactions.total_gross_sales }
#       column: total_net_sales { field: transactions.total_net_sales }
#       column: number_of_customers { field: customers.number_of_customers }

#       filters: {
#         field: base.select_date_range
#         value: "2022/09/01 to 2023/09/01"
#       }
#       filters: {
#         field: base.select_date_reference
#         value: "Transaction"
#       }
#       filters: {
#         field: customers.is_trade
#         value: "Yes"
#       }
#     }
#   }

#   dimension: has_trade_accounts {
#     label: "Customers Has Trade Account? (Yes / No)"
#     description: "Flags whether the customer has a trade account"
#     type: yesno
#   }

#   dimension: customer_uid {
#     label: "Customers Customer UID"
#     description: ""
#     hidden: yes
#   }

#   dimension: total_gross_sales {
#     label: "Measures Gross Sales"
#     description: "Sales value including VAT"
#     # value_format: £
#     type: number
#   }

#   dimension: gross_sales_tier {
#     type: tier
#     tiers: [0,100,200,300,400,500,600,700,800,900,1000,1500,2000,2500,3000,3500,4000,4500,5000,6000,7000,8000,9000,10000,15000,20000,25000,30000,40000,50000,100000]
#     # value_format: "$#,“K”"
#     sql: ${total_gross_sales} ;;
#   }

#   dimension: total_net_sales {
#     label: "Measures Net Sales"
#     description: "Sales value excluding VAT"
#     # value_format: "£#.00"
#     type: number
#   }

#   dimension: net_sales_tier {
#     type: tier
#     tiers: [0,100,200,300,400,500,600,700,800,900,1000,1500,2000,2500,3000,3500,4000,4500,5000,6000,7000,8000,9000,10000,15000,20000,25000,30000,40000,50000,100000]
#     sql: ${total_gross_sales} ;;
#     # value_format: "£#.00"
#   }
# }
