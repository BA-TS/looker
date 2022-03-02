view: disctribution_centre_names {
  sql_table_name: `toolstation-data-storage.locations.disctributionCentreNames`
    ;;

    label: "Distribution Centre"

  dimension: dc_name {
    group_label: "Distribution Centre"
    label: "DC Name"
    type: string
    sql: ${TABLE}.dc_name ;;
  }

  dimension: site_uid {
    group_label: "Distribution Centre"
    label: "Site UID"
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: is_distribution_centre {
    group_label: "Distribution Centre"
    label: "Is Distribution Centre?"
    type: yesno
    sql:

    ${dc_name} IS NOT NULL

    ;;
  }


  dimension: is_store {
    group_label: "Distribution Centre"
    label: "Is Store?"
    type: yesno
    sql:

    ${dc_name} IS NULL

    ;;
  }


}
