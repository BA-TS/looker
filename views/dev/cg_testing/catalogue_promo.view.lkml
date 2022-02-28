view: catalogue_promo {

  label: "Promo"
  required_access_grants: [is_developer]

  derived_table: {

    sql:

      SELECT
        1 AS promoID, 'eXtra1' AS promoName, CURRENT_DATE() AS liveDate, CURRENT_DATE() + 7 AS endDate, 91 AS catalogueID

      UNION ALL(SELECT 2, 'eXtra2', CURRENT_DATE() + 8, CURRENT_DATE() + 15, 91)
      UNION ALL(SELECT 3, 'eXtra3', CURRENT_DATE() + 16, CURRENT_DATE() + 30, 91)

    ;;

  }

  dimension: promo_name {
    type: string
    sql: ${TABLE}.promoName ;;
  }

  dimension_group: promo_live_date {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date
    ]
    sql: ${TABLE}.liveDate ;;
  }

  dimension_group: promo_end_date {
    type: time
    datatype: datetime
    timeframes: [
      raw,
      time,
      date
    ]
    sql: ${TABLE} ;;
  }

  dimension: catalogue_id {
    type: number
    sql: ${TABLE}.catalogueID ;;
  }

}
