view: cannibalisation_2024 {

  derived_table: {
    sql:
    SELECT
    *
    FROM `toolstation-data-storage.retailReporting.cannibalisation_2024_copy`
    ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: cannibalisation_oct24 {
    label: "Oct 24"
    type: number
    sql: ${TABLE}.Oct24 ;;
  }

}
