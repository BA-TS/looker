include: "/models/backend/config.model"
include: "/views/**/*.view"

label: "TS - Sales"

include: "/explores/sales/*"
# include: "/aggregate_awareness/sales/*"
include: "/dashboards/sales/daily_sales_report/*"

include: "/tests/ts_sales/*.lkml" # comment out to disable 'Data Tests'
