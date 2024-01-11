view: foh_master_products_2024 {

  sql_table_name:`toolstation-data-storage.tmp.FOHNetSales`;;

  dimension: SKU {
    type: string
    view_label: "Site Information"
    sql: ${TABLE}.productCode ;;
    hidden: yes
  }

  dimension:Location  {
    view_label: "Site Information"
    type: string
    label: "FOH location"
    sql: ${TABLE}.Location ;;
  }

  dimension:Week  {
    view_label: "Site Information"
    type: string
    label: "FOH Week"
    sql: ${TABLE}.Week ;;
  }

  dimension: Year {
    label: "FOH Year"
    type: number
    sql: ${TABLE}.Year ;;
  }
}
