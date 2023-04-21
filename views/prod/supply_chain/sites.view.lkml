view: sites {
  label: "Location"
  derived_table: {
    sql:
      SELECT
        DISTINCT sites.siteUID AS siteUID,
        sites.* EXCEPT(siteUID),
        dc_flag,
        store_flag,
        servicing_dc_id,
        servicing_dc_name,
        -- servicing_dc_site_uid
      FROM
      (
        SELECT
          sites.siteUID,
          CASE
            WHEN dc_data.dc_name IS NOT NULL
              THEN TRUE
            ELSE FALSE
          END AS dc_flag,
          CASE
            WHEN dc_site.dc_name IS NOT NULL
              THEN TRUE
            ELSE FALSE
          END AS store_flag,
          dc_site.distributionCentreID AS servicing_dc_id,
          dc_site.uncleaned_dc_name AS servicing_dc_name,
          dc_site.siteUID AS servicing_dc_site_uid
        FROM
          `toolstation-data-storage.locations.sites` AS sites
        LEFT JOIN
          `toolstation-data-storage.locations.DCtoShopMapping` AS map
        ON sites.siteUID = map.siteUID
        LEFT JOIN
          `toolstation-data-storage.locations.disctributionCentreNames` AS dc_site
        USING(distributionCentreID)
        LEFT JOIN
        (
          SELECT
            siteUID,
            dc_name
          FROM
            `toolstation-data-storage.locations.distributionCentreSites`
          INNER JOIN
            `toolstation-data-storage.locations.disctributionCentreNames`
          USING(siteUID)
        ) AS dc_data
        ON sites.siteUID = dc_data.siteUID AND dc_data.dc_name IS NOT NULL
        WHERE
          UPPER(sites.siteName) NOT LIKE "%D%SHIP%"
            AND
          (
            map.isActive = 1
                OR
            dc_data.dc_name IS NOT NULL
          )
            -- AND
          -- sites.isClosed = 0 -- added 11/05/22
        GROUP BY
          1,
          2,
          3,
          4,
          5,
          6
      )
      LEFT JOIN
        `toolstation-data-storage.locations.sites` AS sites
      USING(siteUID);;
    datagroup_trigger: ts_location_datagroup
  }

  dimension: location_type {
    type: string
    sql:
    CASE ${servicing_dc_id}
      WHEN "1"
        THEN "RDC"
      WHEN "2"
        THEN "RDC"
      WHEN "3"
        THEN "RDC"
      WHEN "4"
        THEN "Bridgwater"
      ELSE "Stores"
    END;;
  }

  dimension: site_uid {
    primary_key: yes
    view_label: "Location"
    label: "Site UID"
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: site_name {
    view_label: "Location"
    label: "Site Name"
    type: string
    sql: ${TABLE}.siteName ;;
  }


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

  dimension_group: branch_age {
    label: "Branch Age"
    type: duration
    intervals: [year]
    sql_start: dateOpened ;;
    sql_end: CURRENT_TIMESTAMP() ;;
  }


  dimension: is_active {
    group_label: "Flags"
    label: "Is Active?"
    type: yesno
    sql: ${TABLE}.isActive = 1 ;;
  }

  dimension: is_closed {
    group_label: "Flags"
    label: "Is Closed?"
    type: yesno
    sql: ${TABLE}.isClosed = 1 ;;
  }

  dimension: is_metro {
    group_label: "Flags"
    label: "Is Metro?"
    type: yesno
    sql: ${TABLE}.isMetro = 1 ;;
  }

  dimension: is_reduced_stock {
    group_label: "Flags"
    label: "Is Reduced Stock?"
    type: yesno
    sql: ${TABLE}.isReducedStock = 1 ;;
  }

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

  dimension: is_dc {
    group_label: "Flags"
    label: "Is Distribution Centre?"
    type: yesno
    sql: ${TABLE}.dc_flag = 1 ;;
  }

  dimension: is_store {
    group_label: "Flags"
    label: "Is Store?"
    type: yesno
    sql: ${TABLE}.store_flag = 1 ;;
  }

  dimension: servicing_dc_id {
    group_label: "Servicing DC"
    label: "DC ID"
    type: string
    sql: ${TABLE}.servicing_dc_id ;;
    hidden: yes
  }

  dimension: servicing_dc_name {
    group_label: "Servicing DC"
    label: "DC Name"
    type: string
    sql: ${TABLE}.servicing_dc_name ;;
  }
}
