view: catalogue {

  required_access_grants: [is_developer]

  derived_table: {

    sql:

    SELECT
      a.catalogueID,
      cN.catalogueName,
      a.liveDate,
      TIMESTAMP_SUB(c.liveDate, INTERVAL 1 SECOND) AS endDate,
      CASE WHEN b.liveDate IS NOT NULL THEN 1 ELSE 0 END AS isActive

    FROM
      `toolstation-data-storage.range.catSchedule` a

    LEFT OUTER JOIN
    (

      SELECT
        MAX(liveDate) AS liveDate

      FROM
        `toolstation-data-storage.range.catSchedule`

      WHERE
        liveDate <= CURRENT_TIMESTAMP

    ) b
    ON a.liveDate = b.liveDate

    INNER JOIN
      `toolstation-data-storage.range.catSchedule` c
    ON a.catalogueID + 1 = c.catalogueID

    LEFT JOIN
      `toolstation-data-storage.range.catalogue` cN
    ON a.catalogueID = cN.catalogueID

    WHERE
      a.catalogueID IS NOT NULL

    ;;

  sql_trigger_value: toolstation-datagroup-trigger ;;

  }

  dimension: catalogue_id {
    type: number
    sql: ${TABLE}.catalogueID ;;
  }

  dimension: catalogue_name {
    type: string
    sql: ${TABLE}.catalogueName ;;
  }

  dimension_group: catalogue_live_date {
    type: time
    datatype: datetime
    sql: ${TABLE}.liveDate ;;
    timeframes: [
      raw,
      time,
      date
    ]
  }

  dimension_group: catalogue_end_date {
    type: time
    datatype: datetime
    sql: ${TABLE}.endDate ;;
    timeframes: [
      raw,
      time,
      date
    ]
  }

  dimension: catalogue_active {
    type: yesno
    sql: ${TABLE}.isActive = 1 ;;
  }

}
