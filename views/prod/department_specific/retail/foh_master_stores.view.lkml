view: foh_master_stores {

  sql_table_name:`toolstation-data-storage.locations.FOH_MASTER_STORES`;;

  dimension: siteUID {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension:Maximum_Number_of_Dump_Stacks  {
    view_label: "Site Information"
    type: number
    sql: ${TABLE}.Maximum_Number_of_Dump_Stacks ;;
  }

  dimension: Maximum_Number_of_FSDUs {
    view_label: "Site Information"
    type: number
    sql: ${TABLE}.Maximum_Number_of_FSDUs ;;
  }
}
