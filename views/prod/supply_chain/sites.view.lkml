view: sites {
  sql_table_name: `toolstation-data-storage.locations.sites`
    ;;
  drill_fields: [site_uid]

  dimension: site_uid {
    required_access_grants: [is_developer]
    primary_key: yes
    hidden:  yes
    label: "Site UID - Sites"
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: site_name {
    label: "Site Name"
    type: string
    sql: ${TABLE}.siteName ;;
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

  ########## Site Address ##########


  dimension: address1 {
    label: "Address Line 1"
    group_label: "Site Address"
    type: string
    sql: ${TABLE}.address1 ;;
  }

  dimension: address2 {
    label: "Address Line 2"
    group_label: "Site Address"
    type: string
    sql: ${TABLE}.address2 ;;
  }

  dimension: address3 {
    label: "Address Line 3"
    group_label: "Site Address"
    type: string
    sql: ${TABLE}.address3 ;;
  }

  dimension: town {
    group_label: "Site Address"
    type: string
    sql: ${TABLE}.town ;;
  }

  dimension: county {
    group_label: "Site Address"
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: country {
    group_label: "Site Address"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
  dimension: postcode {
    group_label: "Site Address"
    type: string
    sql: ${TABLE}.postcode ;;
  }

  dimension: geo_point {
    label: "Geopoint"
    group_label: "Site Address"
    type: string
    sql: ${TABLE}.geoPoint ;;
    hidden: yes
  }

  dimension: latitude {
    group_label: "Site Address"
    type: number
    sql: ${TABLE}.latitude ;;
    hidden: yes
  }

  dimension: longitude {
    group_label: "Site Address"
    type: number
    sql: ${TABLE}.longitude ;;
    hidden: yes
  }
  dimension: map_point {
    group_label: "Site Address"
    type:  location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  ##################################################

  dimension: cost_centre_id {
    label: "Cost Centre ID"
    type: string
    sql: ${TABLE}.costCentreID ;;
  }

  dimension_group: date_closed {
    group_label: "Closed Date"
    label: "Closed"
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
    hidden: yes
  }

  dimension_group: date_opened {
    group_label: "Opened Date"
    label: "Opened"
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
    hidden: yes
  }


  ########## Flag ##########

  dimension: is_active {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isActive = 1 ;;
  }

  dimension: is_branch {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isBranch = 1 ;;
  }

  dimension: is_closed {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isClosed = 1`;;
  }

  dimension: is_metro {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isMetro = 1 ;;
  }

  dimension: is_reduced_stock {
    group_label: "Flags"
    type: yesno
    sql: ${TABLE}.isReducedStock = 1 ;;
  }

  ########## Division and Region ##########

  dimension: division {
    group_label: "Division and Region"
    type: string
    sql: ${TABLE}.division ;;
  }

  dimension: head_ofdivision {
    label: "Head of Division"
    group_label: "Division and Region"
    type: string
    sql: ${TABLE}.headOfdivision ;;
  }

  dimension: region_director {
    group_label: "Division and Region"
    type: string
    sql: ${TABLE}.regionDirector ;;
  }

  dimension: region_manager {
    group_label: "Division and Region"
    type: string
    sql: ${TABLE}.regionManager ;;
  }

  dimension: region_name {
    group_label: "Division and Region"
    type: string
    sql: ${TABLE}.regionName ;;
  }

  ########## Store Classification ##########

  dimension: site_type {
    group_label: "Store Classification"
    type: string
    sql: ${TABLE}.siteType ;;
  }

  dimension: format {
    group_label: "Store Classification"
    type: string
    sql: ${TABLE}.format ;;
  }

  dimension: square_feet {
    group_label: "Store Classification"
    type: number
    sql: ${TABLE}.squareFeet ;;
  }

}
