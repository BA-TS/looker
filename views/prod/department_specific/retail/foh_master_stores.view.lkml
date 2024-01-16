view: foh_master_stores {

  sql_table_name:`toolstation-data-storage.range.foh_products_weekly`;;

  dimension: SKU {
    type: string
    sql: ${TABLE}.productCode ;;
    hidden: yes
  }

  dimension: Week  {
    view_label: "Location"
    group_label: "Site Information"
    type: string
    label: "FOH Week 2"
    sql: ${TABLE}.fiscalYearWeek;;
    hidden: yes
  }

  dimension: is_FOH_product  {
    view_label: "Location"
    group_label: "Site Information"
    type: yesno
    sql: ${Week} is not null;;
  }
}
