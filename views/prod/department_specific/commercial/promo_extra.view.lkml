view: promo_extra{
  sql_table_name: `toolstation-data-storage.range.catalogue_extra_promo`;;
  fields_hidden_by_default: yes

  dimension: end_date {
    type: date
    sql: date(${TABLE}.endDate) ;;
  }

  dimension: live_date {
    type: date
    sql: date(${TABLE}.liveDate) ;;
  }

  dimension: product_code {
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: promo_publication {
    type: string
    sql: ${TABLE}.promoPublication ;;
  }

  dimension: extra_promo_pk {
    type: string
    sql: concat(${product_code},${live_date},${end_date},${promo_publication}) ;;
    primary_key: yes
    hidden: yes
  }
}
