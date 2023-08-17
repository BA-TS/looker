view: sku_cover_dc_wrong_stock {
  label: "Stock in Wrong Location"

   derived_table: {
     sql: SELECT Distinct row_number() over () as P_K,reportDate,
    productCode,WrongStock_DC,WrongStockValue_DC,WrongStock_store,
    WrongStockValue_store,WrongStock_total,WrongStockValue_total
       FROM `toolstation-data-storage.supplyChainReporting.BQ_DAILY_STOCK_SKU_COVER_DC_WRONG_STOCK`
       ;;
   }
#
#    Define your dimensions and measures here, like this:
   dimension: P_K {
    description: "Primary Key"
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.P_K ;;
   }

   dimension: productCode {
     description: "productCode"
     type: string
     sql: ${TABLE}.productCode ;;
   }
#
   dimension_group: date {
     description: "Report Date"
     type: time
     timeframes: [date, raw]
     sql: ${TABLE}.reportDate ;;
   }
#
   dimension: WrongStock_DC {
    description: "wrong stock in Distribution Centres"
    type: number
    hidden: yes
    sql: ${TABLE}.WrongStock_DC ;;
   }

  dimension: WrongStockValue_DC {
    description: "wrong stock value in Distribution Centres"
    type: number
    hidden: yes
    sql: ${TABLE}.WrongStockValue_DC ;;
  }

  dimension: WrongStock_store {
    description: "wrong stock in stores"
    type: number
    hidden: yes
    sql: ${TABLE}.WrongStock_store ;;
  }

  dimension: WrongStockValue_store {
    description: "wrong stock value in stores"
    type: number
    hidden: yes
    sql: ${TABLE}.WrongStockValue_store ;;
  }

  dimension: WrongStock_total {
    description: "wrong stock total"
    type: number
    hidden: yes
    sql: ${TABLE}.WrongStock_total ;;
  }

  dimension: WrongStockValue_total {
    description: "wrong stock value total"
    type: number
    hidden: yes
    sql: ${TABLE}.WrongStockValue_total ;;
  }
  measure: WrongStock_in_DC {
    group_label: "Stock Units"
    label: "DC"
    type: sum
    sql: ${WrongStock_DC} ;;
  }

  measure: WrongStockValue_in_DC {
    type: sum
    group_label: "Stock Value"
    label: "DC"
    value_format_name: gbp
    sql: ${WrongStockValue_DC} ;;
  }

  measure: WrongStock_in_store {
    group_label: "Stock Units"
    label: "Store"
    type: sum
    sql: ${WrongStock_store} ;;
  }

  measure: WrongStockValue_in_store {
    group_label: "Stock Value"
    label: "Store"
    type: sum
    value_format_name: gbp
    sql: ${WrongStockValue_store} ;;
  }
  measure: WrongStock_in_total {
    group_label: "Stock Units"
    label: "Total"
    type: sum
    sql: ${WrongStock_total} ;;
  }

  measure: WrongStockValue_in_total {
    group_label: "Stock Value"
    label: "Total"
    type: sum
    value_format_name: gbp
    sql: ${WrongStockValue_total} ;;
  }

 }
