view: cannibalisation_2024 {

  derived_table: {
    sql:
    SELECT
    distinct
    *
    FROM `toolstation-data-storage.retailReporting.cannibalisation_2024_copy`
    ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.site_uid ;;
    hidden: yes
    primary_key: yes
  }

  dimension: cannibalisation_oct24 {
    label: "Oct 24"
    type: number
    sql: ${TABLE}.Oct24 ;;
    value_format_name: gbp_0
  }

}
