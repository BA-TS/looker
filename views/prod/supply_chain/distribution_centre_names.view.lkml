view: disctribution_centre_names {
  sql_table_name: `toolstation-data-storage.locations.disctributionCentreNames`
    ;;

    label: "Distribution Centre"

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

  dimension: is_distribution_centre {
    label: "Is Distribution Centre?"
    type: yesno
    sql:

    ${dc_name} IS NOT NULL

    ;;
  }


  dimension: is_store {
    label: "Is Store?"
    type: yesno
    sql:

    ${dc_name} IS NULL

    ;;
  }


}
