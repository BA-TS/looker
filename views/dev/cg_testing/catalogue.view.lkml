view: catalogue {

  required_access_grants: [is_developer]
  fields_hidden_by_default: yes

  derived_table: {

    # sql:

    # SELECT
    #   a.catalogueID,
    #   cN.catalogueName,
    #   a.liveDate,
    #   TIMESTAMP_SUB(c.liveDate, INTERVAL 1 SECOND) AS endDate,
    #   CASE WHEN b.liveDate IS NOT NULL THEN 1 ELSE 0 END AS isActive

    # FROM
    #   `toolstation-data-storage.range.catSchedule` a

    # LEFT OUTER JOIN
    # (

    #   SELECT
    #     MAX(liveDate) AS liveDate

    #   FROM
    #     `toolstation-data-storage.range.catSchedule`

    #   WHERE
    #     liveDate <= CURRENT_TIMESTAMP

    # ) b
    # ON a.liveDate = b.liveDate

    # INNER JOIN
    #   `toolstation-data-storage.range.catSchedule` c
    # ON a.catalogueID + 1 = c.catalogueID

    # LEFT JOIN
    #   `toolstation-data-storage.range.catalogue` cN
    # ON a.catalogueID = cN.catalogueID

    # WHERE
    #   a.catalogueID IS NOT NULL

    # ;;

  sql:

  WITH
  catalogue AS
  (

  SELECT
      a.catalogueID AS catalogue_id,
      d.catalogueName AS catalogue_name,
      a.liveDate AS catalogue_live_date,
      TIMESTAMP_SUB(c.liveDate, INTERVAL 1 SECOND) AS catalogue_end_date,
      CASE
          WHEN b.liveDate IS NOT NULL
              THEN TRUE
          ELSE FALSE
      END AS catalogue_is_active

  FROM
      `toolstation-data-storage.range.catSchedule` a
  LEFT OUTER JOIN
  (
      SELECT
          MAX(liveDate) AS liveDate

      FROM
          `toolstation-data-storage.range.catSchedule`

      WHERE
          liveDate <= current_timestamp
  ) b
  ON a.liveDate = b.liveDate

  INNER JOIN
      `toolstation-data-storage.range.catSchedule` c
  ON a.catalogueID +1 = c.catalogueID

  LEFT JOIN
      `toolstation-data-storage.range.catalogue` d
  ON a.catalogueID = d.catalogueID

  WHERE
  a.catalogueID IS NOT NULL

  ),

  extra AS
  (

      SELECT
          *,
          CASE
              WHEN CURRENT_TIMESTAMP BETWEEN extra_live_date AND extra_end_date
                  THEN TRUE
              ELSE FALSE
          END AS extra_is_active

      FROM
      (

      SELECT
          CAST(1 AS INTEGER) AS extra_id, -- EXTRA 1-3, SEASONAL 4-8 ?
          CAST('EXTRA - February' AS STRING) AS extra_name,
          CAST(10083 AS INTEGER) AS catalogue_id,
          CAST('2020-02-10 00:00:00' AS TIMESTAMP) AS extra_live_date,
          CAST('2020-03-08 23:59:59' AS TIMESTAMP) AS extra_end_date,
      UNION ALL (SELECT 4,'SEASONAL - Outdoor Living and Landscaping',10083,'2020-03-30 00:00:00','2020-05-25 23:59:59')

      UNION ALL (SELECT 1,'EXTRA - April',10084,'2020-04-06 00:00:00','2020-08-09 23:59:59')

      UNION ALL (SELECT 1,'EXTRA - August',10085,'2020-08-10 00:00:00','2020-09-12 23:59:59')

      UNION ALL (SELECT 1,'EXTRA - October',10086,'2020-10-12 00:00:00','2020-11-08 23:59:59')
      UNION ALL (SELECT 2,'EXTRA - November',10086,'2020-10-12 00:00:00','2020-11-08 23:59:59')
      UNION ALL (SELECT 4,'SEASONAL - Deals',10086,'2020-11-30 00:00:00','2020-12-28 23:59:59')

      UNION ALL (SELECT 1,'EXTRA - February',10087,'2021-02-08 00:00:00','2021-03-14 23:59:59')
      UNION ALL (SELECT 4,'SEASONAL - Outdoor Living and Landscaping',10087,'2021-03-29 00:00:00','2021-03-14 23:59:59')

      UNION ALL (SELECT 1,'EXTRA - April',10088,'2021-04-19 00:00:00','2021-06-06 23:59:59')

      UNION ALL (SELECT 1,'EXTRA - July',10089,'2021-07-12 00:00:00','2021-09-05 23:59:59')

      UNION ALL (SELECT 1,'EXTRA - October',10090,'2021-10-11 00:00:00','2021-10-31 23:59:59')
      UNION ALL (SELECT 2,'EXTRA - October Einhell',10090,'2021-10-11 00:00:00','2021-10-31 23:59:59')
      UNION ALL (SELECT 4,'SEASONAL - Big Switch On: Lighting & Electrical',10090,'2021-09-27 00:00:00','2021-10-31 23:59:59')
      UNION ALL (SELECT 5,'SEASONAL - Big Switch On: Plumbing & Heating',10090,'2021-11-01 00:00:00','2022-01-03 23:59:59')
      UNION ALL (SELECT 6,'SEASONAL - Deals',10090,'2021-11-22 00:00:00','2021-12-31 23:59:59')

      UNION ALL (SELECT 1,'EXTRA - February',10091,'2022-02-07 00:00:00','2022-03-20 23:59:59')
      -- excluded Feb extra Power Tools 8 pager (need to investigate if separate nominations)

      UNION ALL (SELECT 1, 'EXTRA - April', 10092, '2022-04-11 00:00:00', '2022-06-05 23:59:59')
      UNION ALL (SELECT 1, 'SEASONAL - Deals', 10092, '2022-03-28 00:00:00', '2022-06-05 23:59:59')

      )

  )

  SELECT
      *

  FROM
      catalogue

  FULL OUTER JOIN
    extra
  USING(catalogue_id)

  WHERE
      extra.extra_name IS NOT NULL

  ;;

  datagroup_trigger: toolstation_core_datagroup

  }

  dimension: catalogue_id {
    type: number
    sql: ${TABLE}.catalogue_id ;;
  }

  dimension: catalogue_name {
    view_label: "Date"
    group_label: "Publication"
    label: "Catalogue"
    type: string
    sql: ${TABLE}.catalogue_name ;;
    hidden: no
  }

  dimension_group: catalogue_live_date {
    type: time
    datatype: datetime
    sql: ${TABLE}.catalogue_live_date ;;
    timeframes: [
      raw,
      time,
      date
    ]
  }

  dimension_group: catalogue_end_date {
    type: time
    datatype: datetime
    sql: ${TABLE}.catalogue_end_date ;;
    timeframes: [
      raw,
      time,
      date
    ]
  }

  dimension: catalogue_active {
    view_label: "Date"
    group_label: "Publication"
    label: "Active Catalogue?"
    type: yesno
    sql: ${TABLE}.catalogue_is_active = true ;;
    hidden: no
  }

  dimension: extra_id {
    type: number
    sql: ${TABLE}.extra_id ;;
  }

  dimension: extra_name {
    view_label: "Date"
    group_label: "Publication"
    label: "Extra"
    type: string
    sql: ${TABLE}.extra_name || " (" || ${catalogue_name} || ")" ;;
    hidden: no
  }


  dimension_group: extra_live_date {
    type: time
    datatype: datetime
    sql: ${TABLE}.extra_live_date ;;
    timeframes: [
      raw,
      time,
      date
    ]
  }

  dimension_group: extra_end_date {
    type: time
    datatype: datetime
    sql: ${TABLE}.extra_end_date ;;
    timeframes: [
      raw,
      time,
      date
    ]
  }

  dimension: extra_active {

    view_label: "Date"
    group_label: "Publication"
    label: "Active Extra(s)?"
    type: yesno
    sql: ${TABLE}.extra_is_active = true ;;
    hidden: no
  }

}
