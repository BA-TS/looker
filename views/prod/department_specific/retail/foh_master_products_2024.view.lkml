view: foh_master_products_2024 {

  # sql_table_name:`toolstation-data-storage.range.foh_products_weekly`;;
  sql_table_name:`toolstation-data-storage.commercial.DS_WEEKLY_FOH_SALES`;;

  dimension: SKU {
    type: string
    view_label: "Site Information"
    sql: ${TABLE}.productCode ;;
    hidden: yes
  }

  dimension: siteUID  {
    view_label: "Site Information"
    type: string
    label: "FOH location"
    sql: ${TABLE}.siteUID ;;
  }

  dimension: Location  {
    view_label: "Site Information"
    type: string
    label: "FOH location"
    sql: ${TABLE}.location ;;
  }

  dimension: Week  {
    view_label: "Site Information"
    type: string
    label: "FOH Week"
    sql: CAST(${TABLE}.fiscalYearWeek AS String);;
  }
}
