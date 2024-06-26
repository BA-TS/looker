view: dc_to_shop_mapping {
  derived_table: {
    sql:
    select * from
    `toolstation-data-storage.locations.DCtoShopMapping`
    ;;
    datagroup_trigger: ts_monthly_datagroup
  }

  fields_hidden_by_default: yes

  dimension_group: active_from {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.activeFrom ;;
  }

  dimension_group: active_to {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.activeTo ;;
  }

  dimension: availability_active {
    type: number
    sql: ${TABLE}.availabilityActive ;;
  }

  dimension: distribution_centre_id {
    type: string
    sql: ${TABLE}.distributionCentreID ;;
  }

  dimension: is_active {
    type: number
    sql: ${TABLE}.isActive ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
  }
}
