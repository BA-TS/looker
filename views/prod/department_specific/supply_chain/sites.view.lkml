view: sites {
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
        GROUP BY 1,2,3,4,5,6
      )
      LEFT JOIN
        `toolstation-data-storage.locations.sites` AS sites
      USING(siteUID);;
    datagroup_trigger: ts_location_datagroup
  }

  dimension: site_uid {
    primary_key: yes
    group_label: "Site Information"
    label: "Site UID"
    type: string
    sql: ${TABLE}.siteUID ;;
  }

  dimension: location_type {
    group_label: "Site Information"
    label: "DC Type"
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

  dimension: site_name {
    group_label: "Site Information"
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
    group_label: "Site Information"
    label: "Cost Centre ID"
    type: string
    sql: ${TABLE}.costCentreID ;;
  }

  dimension_group: date_opened {
    group_label: "Site Information"
    label: "Opened"
    description: "Year of when the branch was opened"
    type: time
    timeframes: [year]
    sql: ${TABLE}.dateOpened ;;
  }

  dimension_group: date_closed {
    group_label: "Site Information"
    label: "Closed"
    type: time
    timeframes: [date]
    sql: ${TABLE}.dateClosed ;;
    hidden: yes
  }

  dimension_group: branch_age {
    group_label: "Site Information"
    label: "Branch Age"
    description: "Age of the branch since it was opened"
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
    group_label: "Site Information"
    type: string
    sql: ${TABLE}.siteType ;;
  }

  dimension: format {
    group_label: "Site Information"
    type: string
    sql: ${TABLE}.format ;;
  }

  dimension: square_feet {
    group_label: "Site Information"
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
    group_label: "Site Information"
    label: "DC ID"
    type: string
    sql: ${TABLE}.servicing_dc_id ;;
    hidden: yes
  }

  measure: number_of_DCs {
    view_label: "Measures"
    group_label: "Other Metrics"
    label: "Number of DCs"
    description: "Number of DCs"
    type: count_distinct
    sql: ${servicing_dc_name} ;;
  }

  dimension: servicing_dc_name {
    group_label: "Site Information"
    label: "DC Name"
    type: string
    sql: ${TABLE}.servicing_dc_name ;;
  }

  dimension: salesTier {
    group_label: "Site Information"
    label: "Sales Tier"
    type: string
    sql: ${TABLE}.salesTier ;;
  }

  dimension: labourTier {
    group_label: "Site Information"
    label: "Labour Tier"
    type: string
    sql: ${TABLE}.labourTier ;;
  }

  dimension: Opening_times_Mon_Fri {
    group_label: "Site Information"
    label: "Opening Times Mon - Fri"
    type: string
    sql: ${TABLE}.Opening_times_Mon_Fri ;;
  }

  dimension: Opening_times_Sat {
    group_label: "Site Information"
    label: "Opening Times Sat"
    type: string
    sql: ${TABLE}.Opening_times_Sat ;;
  }

  dimension: Opening_times_Sun {
    group_label: "Site Information"
    label: "Opening Times Sun"
    type: string
    sql: ${TABLE}.Opening_times_Sun ;;
  }
}
