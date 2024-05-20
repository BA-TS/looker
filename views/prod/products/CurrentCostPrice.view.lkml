view: costPrice {

   derived_table: {
     sql: SELECT distinct row_number() over () as P_K ,*
     FROM `toolstation-data-storage.range.currentCostPrice`;;
   }

   dimension: P_K {
    description: "Primary Key"
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.P_K ;;
   }

  dimension: product_uid {
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }

  dimension: product_code {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.productCode ;;
    hidden: yes
  }


  dimension: packCostGBP {
    type: number
    label: "Pack Cost Price"
    group_label: "Current Price"
    view_label: "Products"
    value_format_name: gbp
    sql: ${TABLE}.packCostGBP ;;
  }

  dimension: unitCostGBP {
    type: number
    label: "Unit Cost Price"
    group_label: "Current Price"
    view_label: "Products"
    value_format_name: gbp
    sql: ${TABLE}.unitCostGBP ;;
  }

  dimension: packQty {
    type: number
    label: "packQty"
    group_label: "Current Price"
    view_label: "Products"
    hidden: yes
    sql: ${TABLE}.packQty ;;
  }
 }
