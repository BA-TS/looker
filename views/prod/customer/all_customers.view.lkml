include: "/views/prod/finance/transactions.view"
include: "/views/prod/department_specific/crm/trade_customers.view"

view: customers {
  sql_table_name:

  `toolstation-data-storage.customer.allCustomers`

  ;;

  dimension: address__address_line1 {
    type: string
    sql: ${TABLE}.address.addressLine1 ;;
    group_label: "Address"
    group_item_label: "Address Line 1"
    required_access_grants: [can_use_customer_information]
  }
  dimension: address__address_line2 {
    type: string
    sql: ${TABLE}.address.addressLine2 ;;
    group_label: "Address"
    group_item_label: "Address Line 2"
    required_access_grants: [can_use_customer_information]
  }
  dimension: address__address_line3 {
    type: string
    sql: ${TABLE}.address.addressLine3 ;;
    group_label: "Address"
    group_item_label: "Address Line 3"
    required_access_grants: [can_use_customer_information]
  }
  dimension: address__address_line4 {
    type: string
    sql: ${TABLE}.address.addressLine4 ;;
    group_label: "Address"
    group_item_label: "Address Line 4"
    required_access_grants: [can_use_customer_information]
  }
  dimension: address__address_line5 {
    type: string
    sql: ${TABLE}.address.addressLine5 ;;
    group_label: "Address"
    group_item_label: "Address Line 5"
    required_access_grants: [can_use_customer_information]
  }
  dimension: address__address_uid {
    type: string
    sql: ${TABLE}.address.addressUID ;;
    group_label: "Address"
    group_item_label: "Address UID"
    required_access_grants: [can_use_customer_information]
  }
  dimension: address__country {
    type: string
    sql: ${TABLE}.address.country ;;
    group_label: "Address"
    group_item_label: "Country"
    required_access_grants: [can_use_customer_information]
  }
  dimension: address__country_code {
    type: string
    sql: ${TABLE}.address.countryCode ;;
    group_label: "Address"
    group_item_label: "Country Code"
    required_access_grants: [can_use_customer_information]
  }
  dimension: address__country_code2 {
    type: string
    sql: ${TABLE}.address.countryCode2 ;;
    group_label: "Address"
    group_item_label: "Country Code 2"
    required_access_grants: [can_use_customer_information]
  }
  dimension: address__postcode {
    type: string
    sql: ${TABLE}.address.postcode ;;
    group_label: "Address"
    group_item_label: "Postcode"
    required_access_grants: [can_use_customer_information]
  }
  dimension_group: creation {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.creationDate ;;
    hidden: yes
  }
  dimension: customer__company {
    type: string
    sql: ${TABLE}.customer.company ;;
    group_label: "Customer"
    group_item_label: "Company"
    required_access_grants: [can_use_customer_information]
  }
  dimension: customer__email {
    type: string
    sql: ${TABLE}.customer.email ;;
    group_label: "Customer"
    group_item_label: "Email"
    required_access_grants: [can_use_customer_information]
  }
  dimension: customer__first_name {
    type: string
    sql: ${TABLE}.customer.firstName ;;
    group_label: "Customer"
    group_item_label: "First Name"
    required_access_grants: [can_use_customer_information]
  }
  dimension: customer__last_name {
    type: string
    sql: ${TABLE}.customer.lastName ;;
    group_label: "Customer"
    group_item_label: "Last Name"
    required_access_grants: [can_use_customer_information]
  }
  dimension: customer__mobile {
    type: string
    sql: ${TABLE}.customer.mobile ;;
    group_label: "Customer"
    group_item_label: "Mobile"
    required_access_grants: [can_use_customer_information]
  }
  dimension: customer__telephone {
    type: string
    sql: ${TABLE}.customer.telephone ;;
    group_label: "Customer"
    group_item_label: "Telephone"
    required_access_grants: [can_use_customer_information]
  }
  dimension: customer__title {
    type: string
    sql: ${TABLE}.customer.title ;;
    group_label: "Customer"
    group_item_label: "Title"
    required_access_grants: [can_use_customer_information]
  }
  dimension: customer_uid {
    type: string
    primary_key: yes
    sql: ${TABLE}.customerUID ;;
    label: "Customer UID"
  }
  dimension: flags__active_account {
    type: yesno
    sql: ${TABLE}.flags.activeAccount = true;;
    group_label: "Flags"
    group_item_label: "Active Account"
    hidden: yes
  }
  dimension: flags__address_do_not_use {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.flags.addressDoNotUse = true ;;
    group_label: "Flags"
    group_item_label: "Address Do Not Use"
  }
  dimension: flags__address_profanity {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.flags.addressProfanity = true ;;
    group_label: "Flags"
    group_item_label: "Address Profanity"
  }
  dimension: flags__customer_do_not_use {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.flags.customerDoNotUse = true ;;
    group_label: "Flags"
    group_item_label: "Customer Do Not Use"
  }
  dimension: flags__customer_profanity {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.flags.customerProfanity = true ;;
    group_label: "Flags"
    group_item_label: "Customer Profanity"
  }
  dimension: flags__guest_checkout {
    type: yesno
    sql: ${TABLE}.flags.guestCheckout = true ;;
    group_label: "Flags"
    label: "Guest Checkout"
  }
  dimension: flags__toolstation_account {
    type: yesno
    sql: ${TABLE}.flags.toolstationAccount = "true" ;;
    group_label: "Flags"
    label: "Toolstation Account"
  }
  dimension: flags__toolstation_address {
    type: yesno
    sql: ${TABLE}.flags.toolstationAddress = true ;;
    group_label: "Flags"
    group_item_label: "Toolstation Address"
    hidden: yes
  }
  dimension: permissions__catalogue_mail_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.catalogue_mail_opt_in = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "Catalogue (Mail)"
  }
  dimension: permissions__offers_email_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.offers_email_opt_in = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "Email (Offers)"
  }
  dimension: permissions__offers_mail_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.offers_mail_opt_in = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "Mail (Offers)"
  }
  dimension: permissions__offers_mobile_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.offers_mobile_opt_in = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "Mobile (Offers)"
  }
  dimension: permissions__offers_notif_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.Offers_Notif_Opt_In = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "Notification (Offers)"
  }
  dimension: permissions__offers_sms_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.offers_sms_opt_in = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "SMS (Offers)"
  }
  dimension: permissions__order_process_email_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_process_email_opt_in = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "Email (Order Process)"
  }
  dimension: permissions__order_process_notif_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.Order_Process_Notif_Opt_In = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "Notification (Order Process)"
  }
  dimension: permissions__order_process_sms_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_process_sms_opt_in = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "SMS (Order Process)"
  }
  dimension: permissions__order_query_email_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_query_email_opt_in = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "Email (Order Query)"
  }
  dimension: permissions__order_query_mobile_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_query_mobile_opt_in = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "Mobile (Order Query)"
  }
  dimension: permissions__order_query_notif_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.Order_Query_Notif_Opt_In = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "Notification (Order Query)"
  }
  dimension: permissions__order_query_sms_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_query_sms_opt_in = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "SMS (Order Query)"
  }
  dimension: permissions__order_query_telephone_opt_in {
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_query_telephone_opt_in = true ;;
    group_label: "Permissions (Opt In)"
    group_item_label: "Telephone (Order Query)"
  }
  dimension: is_trade {
    type:  yesno
    group_label: "Flags"
    label: "Is Trade"
    sql:

    ${trade_customers.trade_flag} != ""

     ;; # ${trade_customers.customer_number} is not null
  }
  dimension_group: updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.updatedDate ;;
    hidden: yes
  }

  #####################

  dimension: is_new_customer {
    type: yesno
    group_label: "Flags"
    sql:

    ${creation_date} >= CURRENT_DATE() - 30

    ;;
  }

}
