view: customer_experience_trade {

  sql_table_name:`toolstation-data-storage.retailReporting.SC_CUSTOMER_EXPERIENCE_TRADE`;;

  dimension: month {
    type: string
    view_label: "Date"
    sql: CAST(${TABLE}.month AS string);;
    hidden: yes
  }

  dimension: siteUID {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: nps {
    type: string
    label: "NP"
    sql: ${TABLE}.nps ;;
  }
}
