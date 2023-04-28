view: distribution_centre_names {
  sql_table_name: `toolstation-data-storage.locations.disctributionCentreNames` ;;
  label: "Location"

  dimension: dc_name {
    label: "DC Name"
    type: string
    sql: ${TABLE}.dc_name ;;
  }

  dimension: site_uid {
    label: "DC UID"
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: is_distribution_centre {
    group_label: "Flags"
    label: "Is Distribution Centre?"
    type: yesno
    sql: ${dc_name} IS NOT NULL ;;
  }

  dimension: is_store {
    group_label: "Flags"
    label: "Is Store?"
    type: yesno
    sql: ${dc_name} IS NULL ;;
  }
}
