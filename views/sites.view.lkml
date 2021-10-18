view: sites {
  sql_table_name: `toolstation-data-storage.locations.sites`
    ;;
  drill_fields: [site_uid]

  dimension: site_uid {
    primary_key: yes
    hidden:  yes
    label: "Site UID - Sites"
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  # dimension_group: active_from {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.activeFrom ;;
  # }

  # dimension_group: active_to {
  #   type: time
  #   timeframes: [
  #     raw,
  #     time,
  #     date,
  #     week,
  #     month,
  #     quarter,
  #     year
  #   ]
  #   sql: ${TABLE}.activeTo ;;
  # }

  dimension: address1 {
    type: string
    sql: ${TABLE}.address1 ;;
  }

  dimension: address2 {
    type: string
    sql: ${TABLE}.address2 ;;
  }

  dimension: address3 {
    type: string
    sql: ${TABLE}.address3 ;;
  }

  dimension: cost_centre_id {
    type: string
    sql: ${TABLE}.costCentreID ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension_group: date_closed {
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
    sql: ${TABLE}.dateClosed ;;
  }

  dimension_group: date_opened {
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
    sql: ${TABLE}.dateOpened ;;
  }

  dimension: division {
    type: string
    sql: ${TABLE}.division ;;
  }

  dimension: format {
    type: string
    sql: ${TABLE}.format ;;
  }

  dimension: geo_point {
    type: string
    sql: ${TABLE}.geoPoint ;;
  }

  dimension: head_ofdivision {
    type: string
    sql: ${TABLE}.headOfdivision ;;
  }

  dimension: is_active {
    type: number
    sql: ${TABLE}.isActive ;;
  }

  dimension: is_branch {
    type: number
    sql: ${TABLE}.isBranch ;;
  }

  dimension: is_closed {
    type: number
    sql: ${TABLE}.isClosed ;;
  }

  dimension: is_metro {
    type: number
    sql: ${TABLE}.isMetro ;;
  }

  dimension: is_reduced_stock {
    type: number
    sql: ${TABLE}.isReducedStock ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: postcode {
    type: string
    sql: ${TABLE}.postcode ;;
  }

  dimension: region_director {
    type: string
    sql: ${TABLE}.regionDirector ;;
  }

  dimension: region_manager {
    type: string
    sql: ${TABLE}.regionManager ;;
  }

  dimension: region_name {
    type: string
    sql: ${TABLE}.regionName ;;
  }

  dimension: site_name {
    type: string
    sql: ${TABLE}.siteName ;;
  }

  dimension: site_type {
    type: string
    sql: ${TABLE}.siteType ;;
  }

  dimension: square_feet {
    type: number
    sql: ${TABLE}.squareFeet ;;
  }

  dimension: town {
    type: string
    sql: ${TABLE}.town ;;
  }

  dimension: map_point {
    type:  location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }
}
