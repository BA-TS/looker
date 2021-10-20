view: disctribution_centre_names {
  sql_table_name: `toolstation-data-storage.locations.disctributionCentreNames`
    ;;

  dimension: dc_name {
    label: "DC Name"
    type: string
    sql: ${TABLE}.dc_name ;;
  }

  dimension: site_uid {
    label: "Site UID"
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }
}
