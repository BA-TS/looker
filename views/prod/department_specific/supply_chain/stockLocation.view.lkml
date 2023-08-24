view: stocklocation {
  derived_table: {
    sql: SELECT distinct row_number() over () as P_K, *, (TIMESTAMP_SUB(openingStockDate, INTERVAL 1 SECOND) ) AS closingStockDate
    FROM `toolstation-data-storage.stock.stockLocation`
    ;;
  }

   dimension: P_K {
    description: "Primary Key"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.P_K;;
   }

  dimension: LocationUID {
    description: "Location ID"
    type: string
    sql: ${TABLE}.locationUID;;
  }

  dimension: productUID {
    description: "Product ID"
    type: string
    sql: ${TABLE}.productUID;;
  }

  dimension: siteUID {
    description: "Site ID"
    type: string
    sql: ${TABLE}.siteUID;;
  }

  dimension: Location_name {
    description: "Location Name"
    type: string
    sql: ${TABLE}.LocationName;;
  }

  dimension: isPickable {
    description: "isPickable"
    type: yesno
    sql: ${TABLE}.isPickable = 1;;
  }

  dimension: isClosed {
    description: "isClosed"
    type: yesno
    sql: ${TABLE}.isClosed = 1;;
  }

  dimension: isMovable {
    description: "isMovable"
    type: yesno
    sql: ${TABLE}.isMovable = 1;;
  }

  dimension: isVirtual {
    description: "isVirtual"
    type: yesno
    sql: ${TABLE}.isVirtual = 1;;
  }

  dimension_group: StockUpdated {
    label: "Updated Stock Date"
    description: "Date Stock Updated"
    type: time
    timeframes: [date,raw]
    sql: ${TABLE}.stockUpdated ;;
  }

  dimension_group: openingStockDate {
    label: "Opening Stock Date"
    description: "Date Stock Opened"
    type: time
    timeframes: [date,raw]
    sql: ${TABLE}.openingStockDate ;;
  }

  dimension_group: closingStockDate {
    label: "Closed Stock Date"
    description: "Date Stock Closed"
    type: time
    timeframes: [date,raw]
    sql: ${TABLE}.closingStockDate ;;
  }

  measure: total_lifetime_orders {
    label: "Stock Level"
    description: "Use this for counting lifetime orders across many users"
    type: sum
    sql: ${TABLE}.stockLevel ;;
  }

  }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#

# }
