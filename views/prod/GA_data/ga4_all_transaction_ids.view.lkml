view: ga4_all_transaction_ids {

   derived_table: {
     sql: SELECT distinct *, row_number() over () as P_K
    FROM `toolstation-data-storage.Digital_reporting.DigitalGA4AllTransactionIDs`
       ;;
   }

   dimension: P_K {
    description: "Primary Key"
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.P_K ;;
   }

   dimension: platform {
    description: "Web or App used"
    hidden: yes
    type: string
    sql: ${TABLE}.platform ;;
   }
#
   dimension_group: date {
     description: "GA4 date of purchase"
    hidden: yes
     type: time
     timeframes: [date, raw]
     sql: ${TABLE}.date ;;
   }
#
  dimension: OrderID {
    hidden: yes
    description: "transactionID"
    type: string
    sql: ${TABLE}.OrderID;;
  }
 }
