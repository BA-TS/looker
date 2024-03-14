view: foh_master_products_2024 {

  sql_table_name:`toolstation-data-storage.commercial.DS_WEEKLY_FOH_SALES`;;

  dimension: SKU {
    type: string
    sql: ${TABLE}.productCode ;;
    hidden: yes
  }

  dimension: siteUID  {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: foh_Area  {
    group_label: "Site Information"
    type: string
    label: "FOH Area"
    sql: ${TABLE}.fohArea ;;
  }

  dimension: Location  {
    group_label: "Site Information"
    type: string
    label: "FOH Location"
    sql: ${TABLE}.Location ;;
  }

  dimension: Week  {
    group_label: "Site Information"
    type: string
    label: "FOH Week"
    sql: CAST(${TABLE}.fiscalYearWeek AS String);;
  }
}
