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
    hidden: yes
    type: string
    sql: ${TABLE}.locationUID;;
  }

  dimension: productUID {
    description: "Product ID"
    hidden: yes
    type: string
    sql: ${TABLE}.productUID;;
  }

  dimension: siteUID {
    description: "Site ID"
    hidden: yes
    type: string
    sql: ${TABLE}.siteUID;;
  }

  dimension: Location_name {
    description: "Location Name"
    hidden: yes
    type: string
    sql: ${TABLE}.LocationName;;
  }

  dimension: isPickable {
    label: "Is Pickable"
    group_label: "Flags"
    description: "isPickable"
    type: yesno
    sql: ${TABLE}.isPickable = 1;;
  }

  dimension: isClosed {
    description: "isClosed"
    hidden: yes
    type: yesno
    sql: ${TABLE}.isClosed = 1;;
  }

  dimension: isMovable {
    description: "isMovable"
    hidden: yes
    type: yesno
    sql: ${TABLE}.isMovable = 1;;
  }

  dimension: isVirtual {
    description: "isVirtual"
    hidden: yes
    type: yesno
    sql: ${TABLE}.isVirtual = 1;;
  }

  dimension_group: StockUpdated {
    label: "Updated Stock Date"
    description: "Date Stock Updated"
    hidden: yes
    type: time
    timeframes: [date,raw]
    sql: ${TABLE}.stockUpdated ;;
  }

  dimension_group: openingStockDate {
    label: "Opening Stock Date"
    description: "Date Stock Opened"
    hidden: yes
    type: time
    timeframes: [date,raw]
    sql: ${TABLE}.openingStockDate ;;
  }

  dimension_group: closingStockDate {
    label: "Closed Stock Date"
    description: "Date Stock Closed"
    hidden: yes
    type: time
    timeframes: [date,raw]
    sql: ${TABLE}.closingStockDate ;;
  }

  measure: total_lifetime_orders {
    view_label: "Stock Measures"
    label: "Stock Level"
    description: "Use this for counting lifetime orders across many users"
    #hidden: yes
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
