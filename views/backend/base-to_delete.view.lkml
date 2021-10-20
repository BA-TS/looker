# view: base {
#   derived_table: {

#     datagroup_trigger: toolstation_transactions_datagroup

#     sql:
#       SELECT
#         d.fullDate as date,
#         p.productDepartment as department,
#         s.siteUID,
#         sc.salesChannel

#       from `toolstation-data-storage.ts_finance.dim_date` d
#         cross join (select distinct siteUID from `toolstation-data-storage.locations.sites`) s
#         cross join (select distinct productDepartment from `toolstation-data-storage.range.products_current`) p
#         cross join (select distinct salesChannel from `toolstation-data-storage.sales.transactions`) sc

#       where d.fullDate >= (select min(date(transactionDate)) from `toolstation-data-storage.sales.transactions`)
#         and d.fullDate < current_date + 30;;
#   }

#   dimension: date {
#     type: date
#     hidden:  yes
#     sql: ${TABLE}.date ;;
#   }

#   dimension: department {
#     type:  string
#     hidden:  yes
#     sql: ${TABLE}.department ;;
#   }

#   dimension: siteUID {
#     type:  string
#     hidden:  yes
#     sql: ${TABLE}.siteUID ;;
#   }

#   dimension: salesChannel {
#     type:  string
#     hidden:  yes
#     sql: ${TABLE}.salesChannel ;;
#   }


# }
