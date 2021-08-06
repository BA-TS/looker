view: disctribution_centre_names {
  sql_table_name: `toolstation-data-storage.locations.disctributionCentreNames`
    ;;

  dimension: dc_name {
    type: string
    sql: ${TABLE}.dc_name ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }
}
