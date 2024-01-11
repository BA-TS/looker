view: foh_master_products_2024 {

  sql_table_name:`toolstation-data-storage.tmp.FOH_MASTER_PRODUCTS_2024`;;

  dimension: SKU {
    type: string
    view_label: "Site Information"
    sql: ${TABLE}.SKU ;;
    hidden: yes
  }

  dimension:Location  {
    view_label: "Site Information"
    type: string
    label: "FOH location"
    sql: ${TABLE}.Location ;;
  }

  dimension: Year {
    label: "FOH year"
    type: number
    sql: ${TABLE}.Year ;;
  }
}
