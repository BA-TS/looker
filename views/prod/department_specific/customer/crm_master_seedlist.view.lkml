view: crm_master_seedlist {
  # required_access_grants: [can_use_customers]

  sql_table_name:`toolstation-data-storage.tmp.CRM_Master_SeedList_copy`;;

  dimension: customer_uid {
    type: string
    primary_key: yes
    sql: ${TABLE}.Customer_Number ;;
    label: "Customer UID"
  }

  dimension: customer__first_name {
    type: string
    sql: ${TABLE}.Name ;;
    group_label: "Customer"
    group_item_label: "First Name"
    required_access_grants: [can_use_customer_information]
  }

  dimension: customer__company {
    type: string
    sql: ${TABLE}.Company ;;
    group_label: "Customer"
    group_item_label: "Company"
    required_access_grants: [can_use_customer_information]
  }

  dimension: address__address_line1 {
    type: string
    sql: ${TABLE}.Address1 ;;
    group_label: "Address"
    group_item_label: "Address Line 1"
    required_access_grants: [can_use_customer_information]
  }

  dimension: address__address_line2 {
    type: string
    sql: ${TABLE}.Address2 ;;
    group_label: "Address"
    group_item_label: "Address Line 2"
    required_access_grants: [can_use_customer_information]
  }

  dimension: address__address_line3 {
    type: string
    sql: ${TABLE}.Address3 ;;
    group_label: "Address"
    group_item_label: "Address Line 3"
    required_access_grants: [can_use_customer_information]
  }

  dimension: address__address_line4 {
    type: string
    sql: ${TABLE}.Address4 ;;
    group_label: "Address"
    group_item_label: "Address Line 4"
    required_access_grants: [can_use_customer_information]
  }

  dimension: address__postcode {
    type: string
    sql: ${TABLE}.Postcode ;;
    group_label: "Address"
    group_item_label: "Postcode"
    required_access_grants: [can_use_customer_information]
  }

  dimension: seed_list {
    type: string
    group_label: "Customer"
    sql: "Seed";;
    required_access_grants: [can_use_customer_information]
  }
}
