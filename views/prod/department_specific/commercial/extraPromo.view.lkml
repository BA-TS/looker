view: extraPromo{
  derived_table: {
    sql:
    SELECT DISTINCT
    eP.productCode,
    eD.liveDate,
    eD.endDate
    FROM `toolstation-data-storage.promotions.cataloguePromo` eP
    INNER JOIN `toolstation-data-storage.range.extraDates` eD ON eP.catalogueID = eD.catalogueID
    WHERE UPPER(eP.catalogueLocation) LIKE "%EXTRA%" AND eP.productCode IS NOT NULL;;
  }

  fields_hidden_by_default: yes

  dimension: extra_promo_pk {
    type: string
    sql: concat(${product_code},${live_date},${end_date}) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: end_date {
    type: date
    sql: date(${TABLE}.endDate) ;;
  }

  dimension: live_date {
    type: date
    sql: date(${TABLE}.liveDate) ;;
  }
}
