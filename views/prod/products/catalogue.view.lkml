view: catalogue {
  derived_table: {
  sql:
    SELECT distinct row_number() over () as P_K,
    C.catalogueNAme,CD.* except(isActive),
    case when isActive = 1 then "true" else "false" end as isActive,
    PE.extraID, PE.extraName, PE.extraStartDate, PE.extraEndDate,
    CASE WHEN CURRENT_TIMESTAMP BETWEEN extraStartDate AND extraEndDate THEN TRUE ELSE FALSE END AS extra_is_active
    FROM `toolstation-data-storage.range.catalogueDates` as CD
    INNER JOIN `toolstation-data-storage.range.catalogue` c ON CD.catalogueID = C.catalogueID
    full outer join `toolstation-data-storage.publication.extra` as PE
    on cast(CD.catalogueID as string) = regexp_extract(cast(PE.extraID as string),"^.{0,5}")
    WHERE PE.extraName IS NOT NULL
    -- WITH
    -- catalogue AS
    -- (
    -- SELECT
    --     a.catalogueID AS catalogue_id,
    --     d.catalogueName AS catalogue_name,
    --     a.liveDate AS catalogue_live_date,
    --     TIMESTAMP_SUB(c.liveDate, INTERVAL 1 SECOND) AS catalogue_end_date,
    --     CASE
    --         WHEN b.liveDate IS NOT NULL
    --             THEN TRUE
    --         ELSE FALSE
    --     END AS catalogue_is_active
    -- FROM `toolstation-data-storage.range.catSchedule` a
    -- LEFT OUTER JOIN
    -- (
    --     SELECT
    --         MAX(liveDate) AS liveDate
    --     FROM
    --         `toolstation-data-storage.range.catSchedule`
    --     WHERE
    --         liveDate <= current_timestamp
    -- ) b
    -- ON a.liveDate = b.liveDate
    -- INNER JOIN
    --     `toolstation-data-storage.range.catSchedule` c
    -- ON a.catalogueID +1 = c.catalogueID
    -- LEFT JOIN
    --     `toolstation-data-storage.range.catalogue` d
    -- ON a.catalogueID = d.catalogueID
    -- WHERE
    -- a.catalogueID IS NOT NULL
    -- ),
   -- extra AS
    -- (
    --     SELECT
    --         *,
    --         CASE
    --             WHEN CURRENT_TIMESTAMP BETWEEN extra_live_date AND extra_end_date
    --                 THEN TRUE
    --             ELSE FALSE
    --         END AS extra_is_active
    --     FROM
    --     (
    --     SELECT
    --         CAST(1 AS INTEGER) AS extra_id, -- EXTRA 1-3, SEASONAL 4-8 ?
    --         CAST('EXTRA - February' AS STRING) AS extra_name,
    --         CAST(10083 AS INTEGER) AS catalogue_id,
    --         CAST('2020-02-10 00:00:00' AS TIMESTAMP) AS extra_live_date,
    --         CAST('2020-03-08 23:59:59' AS TIMESTAMP) AS extra_end_date,
    --     UNION ALL (SELECT 4,'SEASONAL - Outdoor Living and Landscaping',10083,'2020-03-30 00:00:00','2020-05-25 23:59:59')
    --     UNION ALL (SELECT 1,'EXTRA - April',10084,'2020-04-06 00:00:00','2020-08-09 23:59:59')
    --     UNION ALL (SELECT 1,'EXTRA - August',10085,'2020-08-10 00:00:00','2020-09-12 23:59:59')
    --     UNION ALL (SELECT 1,'EXTRA - October',10086,'2020-10-12 00:00:00','2020-11-08 23:59:59')
    --     UNION ALL (SELECT 2,'EXTRA - November',10086,'2020-10-12 00:00:00','2020-11-08 23:59:59')
    --     UNION ALL (SELECT 4,'SEASONAL - Deals',10086,'2020-11-30 00:00:00','2020-12-28 23:59:59')
    --     UNION ALL (SELECT 1,'EXTRA - February',10087,'2021-02-08 00:00:00','2021-03-14 23:59:59')
    --     UNION ALL (SELECT 4,'SEASONAL - Outdoor Living and Landscaping',10087,'2021-03-29 00:00:00','2021-03-14 23:59:59')
    --     UNION ALL (SELECT 1,'EXTRA - April',10088,'2021-04-19 00:00:00','2021-06-06 23:59:59')
    --     UNION ALL (SELECT 1,'EXTRA - July',10089,'2021-07-12 00:00:00','2021-09-05 23:59:59')
    --     UNION ALL (SELECT 1,'EXTRA - October',10090,'2021-10-11 00:00:00','2021-10-31 23:59:59')
    --     UNION ALL (SELECT 2,'EXTRA - October Einhell',10090,'2021-10-11 00:00:00','2021-10-31 23:59:59')
    --     UNION ALL (SELECT 4,'SEASONAL - Big Switch On: Lighting & Electrical',10090,'2021-09-27 00:00:00','2021-10-31 23:59:59')
    --     UNION ALL (SELECT 5,'SEASONAL - Big Switch On: Plumbing & Heating',10090,'2021-11-01 00:00:00','2022-01-03 23:59:59')
    --     UNION ALL (SELECT 6,'SEASONAL - Deals',10090,'2021-11-22 00:00:00','2021-12-31 23:59:59')
    --     UNION ALL (SELECT 1,'EXTRA - February',10091,'2022-02-07 00:00:00','2022-03-20 23:59:59')
    --     -- excluded Feb extra Power Tools 8 pager (need to investigate if separate nominations)
    --     UNION ALL (SELECT 1, 'EXTRA - April', 10092, '2022-04-11 00:00:00', '2022-06-05 23:59:59')
    --     UNION ALL (SELECT 1, 'SEASONAL - Deals', 10092, '2022-03-28 00:00:00', '2022-06-05 23:59:59')
    --     )
    -- )
    -- SELECT
    --     *
    -- FROM catalogue
    -- FULL OUTER JOIN
    --   extra
    -- USING(catalogue_id)
    -- WHERE extra.extra_name IS NOT NULL
    ;;
    # datagroup_trigger: ts_daily_datagroup
  }

  dimension: P_K {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.P_K ;;
  }

  dimension: catalogue_id {
    type: number
    sql: ${TABLE}.catalogueID ;;
  }

  dimension: catalogue_name {
    group_label: "Publication"
    label: "Catalogue"
    type: string
    sql: ${TABLE}.catalogueNAme ;;
  }

  dimension: catalogue_live_date {
    label: "Catalogue Live_date"
    type: date
    sql: ${TABLE}.liveDate ;;
  }

  dimension: catalogue_end_date {
    label: "Catalogue End Date"
    type: date
    sql: ${TABLE}.endDate ;;
  }

  dimension: catalogue_active {
    group_label: "Publication"
    label: "Active Catalogue?"
    type: yesno
    sql: ${TABLE}.isActive = true ;;
  }

  dimension: extra_id {
    type: number
    sql: ${TABLE}.extraID ;;
  }

  dimension: extra_name {
    group_label: "Publication"
    label: "Extra"
    type: string
    sql: ${TABLE}.extraName || " (" || ${catalogue_name} || ")" ;;
  }

  dimension: extra_live_date {
    label: "Extra Live Date"
    type: date
    sql: ${TABLE}.extraStartDate ;;
  }

  dimension: extra_end_date {
    label: "Extra End Date"
    type: date
    sql: ${TABLE}.extraEndDate ;;
  }

  dimension: extra_active {
    group_label: "Publication"
    label: "Active Extra(s)?"
    type: yesno
    sql: ${TABLE}.extra_is_active = true ;;
  }
}
