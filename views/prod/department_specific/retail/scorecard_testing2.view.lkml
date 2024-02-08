view: scorecard_testing2 {
  sql_table_name:`toolstation-data-storage.tmp.typyCustomerRetention_region`;;


  dimension: siteUID {
    type: string
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
    required_access_grants: [retail_testing]
    type: yesno
    view_label: "Scorecard testing"
    label: "customer_tyly_flag_region"
    sql: ${customerUID} is not null ;;
  }

}
