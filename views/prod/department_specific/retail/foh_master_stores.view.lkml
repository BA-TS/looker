view: foh_master_stores {

  sql_table_name:`toolstation-data-storage.range.foh_products_weekly`;;

  dimension: SKU {
    type: string
    sql: ${TABLE}.productCode ;;
    hidden: yes
  }

  dimension: Location  {
    view_label: "Location"
    group_label: "Site Information"
    type: string
    label: "FOH location"
    sql: ${TABLE}.location ;;
  }

  dimension: Week  {
    view_label: "Location"
    group_label: "Site Information"
    type: string
    label: "FOH Week"
    sql: ${TABLE}.fiscalYearWeek;;
  }
}
