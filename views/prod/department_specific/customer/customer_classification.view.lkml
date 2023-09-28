view: customer_classification {
  derived_table: {
    sql:
      SELECT
        c.CustomerUID as customer_uid,
        CASE
          WHEN atc.CustomerUID IS NOT NULL THEN 'Assumed Trade'
          WHEN dtc.Customer_Number IS NOT NULL THEN 'Trade'
          ELSE 'DIY'
        END AS customer_type
      FROM `toolstation-data-storage.customer.allCustomers` AS c
      LEFT JOIN `toolstation-data-storage.customer.assumed_trade_customers` AS atc ON c.CustomerUID = atc.CustomerUID
      LEFT JOIN `toolstation-data-storage.customer.dbs_trade_customers` AS dtc ON c.CustomerUID = dtc.Customer_Number
      ;;
  }

  dimension: customer_type {
    type: string
    sql: ${TABLE}.customer_type ;;
    ##required_access_grants: [lz_testing]
  }

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customer_uid ;;
    hidden: yes
    primary_key: yes
  }
}
