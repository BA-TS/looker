view: branch_market_share {

  derived_table: {
    sql:
    SELECT
    *
    FROM
    `toolstation-data-storage.retailReporting.branch_market_share_copy`
    ;;
  }


  dimension: site_uid {
    type: string
    sql: ${TABLE}.site_uid ;;
    hidden: yes
    primary_key: yes
  }

  dimension: urban_classification {
    type: string
    sql: ${TABLE}.urban_classification ;;
  }

  dimension: urban_classification_average {
    type: number
    sql: ${TABLE}.urban_classification_average ;;
    value_format_name: percent_1
  }

  dimension: distance_1km {
    label: "Distance 1km"
    type: number
    sql: ${TABLE}.distance_1km;;
    value_format_name: percent_1
  }

  dimension: distance_2km {
    label: "Distance 2km"
    type: number
    sql: ${TABLE}.distance_2km;;
    value_format_name: percent_1
  }

  dimension: distance_5km {
    label: "Distance 5km"
    type: number
    sql: ${TABLE}.distance_5km;;
    value_format_name: percent_1
  }

}
