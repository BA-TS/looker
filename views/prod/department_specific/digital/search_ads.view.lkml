view: search_ads {
  sql_table_name: toolstation-data-storage.search_ads.SearchAds360_looker ;;

  # derived_table: {
  #   sql:
  #   SELECT
  #     *,
  #     ROUND(coalesce(cost,
  #         0) + coalesce(sa360_cost,
  #         0) + coalesce(google_tax,
  #         0), 2) AS inc_tax_cost
  #   FROM (
  #     SELECT
  #       *,
  #       CASE
  #         WHEN account = "Toolstation_Shopping_Google" THEN ROUND((cost * 2) / 100, 2)
  #         WHEN account = "Toolstation_Search_Google" THEN ROUND((cost * 2) / 100, 2)
  #         WHEN account = "Toolstation_Bing" THEN 0
  #         ELSE 0
  #       END AS google_tax,
  #       ROUND((cost * 1.25) / 100, 2) AS sa360_cost
  #     FROM (
  #       SELECT
  #         CASE
  #           WHEN accountId = "700000002262132" THEN 'Toolstation_Shopping_Google'
  #           WHEN accountId = "700000002261838" THEN 'Toolstation_Search_Google'
  #           WHEN accountId = "700000002279434" THEN 'Toolstation_Bing'
  #           ELSE accountId
  #         END AS account,
  #         accountId,
  #         date,
  #         ROUND(SUM(cost), 2) AS cost
  #       FROM
  #         toolstation-data-storage.search_ads.p_AdGroupDeviceStats_21700000001867552
  #       GROUP BY
  #         accountId,
  #         date))
  #   GROUP BY
  #     1,
  #     2,
  #     3,
  #     4,
  #     5,
  #     6
  #   ORDER BY
  #     date

  #   ;;
  #   datagroup_trigger: toolstation_core_datagroup
  # }

  dimension: account {
    type: string
    sql: ${TABLE}.account ;;
  }

  dimension: accountId {
    label: "Account ID"
    type: string
    sql: ${TABLE}.accountId ;;
  }

  dimension_group: date {
    type: time
    datatype: date
    timeframes: [raw, date, month, year]
    sql: ${TABLE}.date ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
    hidden: yes
    value_format_name: gbp
  }

  dimension: google_tax {
    type: number
    sql: ${TABLE}.google_tax ;;
    hidden: yes
    value_format_name: gbp
  }

  dimension: sa360_cost {
    type: number
    sql: ${TABLE}.sa360_cost ;;
    hidden: yes
    value_format_name: gbp
  }

  dimension: inc_tax_cost {
    type: number
    sql: ${TABLE}.inc_tax_cost ;;
    hidden: yes
    value_format_name: gbp
  }

  measure: total_cost {
    label: "Net Cost"
    type: sum
    sql: ${cost} ;;
    value_format_name: gbp
  }

  measure: total_google_tax {
    type: sum
    sql: ${google_tax} ;;
    value_format_name: gbp
  }

  measure: total_sa360_cost {
    label: "Total SA360 Cost"
    type: sum
    sql: ${sa360_cost} ;;
    value_format_name: gbp
  }

  measure: total_inc_tax_cost {
    label: "Total Cost"
    type: sum
    sql: ${inc_tax_cost} ;;
    value_format_name: gbp
  }
}
