view: scorecard_testing_region_YTD {
  sql_table_name:`toolstation-data-storage.tmp.typyCustomerRetention_region_YTD`;;

  dimension: siteUID {
    type: string
    label: "siteUID"
    view_label: "Scorecard testing"
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: customerUID {
    type: string
    view_label: "Scorecard testing"
    sql: ${TABLE}.customerUID ;;
    label: "customer UID retention"
    hidden: yes
  }

  dimension: customer_tyly_flag {
    type: yesno
    view_label: "Scorecard testing"
    label: "Customer Rentention (Region YTD)"
    sql: ${customerUID} is not null ;;
  }

}
