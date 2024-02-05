view: scorecard_testing1 {
  sql_table_name:`toolstation-data-storage.tmp.typyCustomerRetention`;;


  dimension: siteUID {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: customerUID {
    type: string
    view_label: "Site Information"
    label: "Site UID"
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: customer_ty_ly_flag {
    required_access_grants: [retail_testing]
    type: yesno
    view_label: "Site Information"
    sql: ${customerUID} is not null ;;
  }

}
