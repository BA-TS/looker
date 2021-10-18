include: "/views/transactions.view"

view: customers {
  sql_table_name: `toolstation-data-storage.customer.allCustomers`
    ;;

  dimension: address__address_line1 {
    type: string
    sql: ${TABLE}.address.addressLine1 ;;
    group_label: "Address"
    group_item_label: "Address Line 1"
  }

  dimension: address__address_line2 {
    type: string
    sql: ${TABLE}.address.addressLine2 ;;
    group_label: "Address"
    group_item_label: "Address Line 2"
  }

  dimension: address__address_line3 {
    type: string
    sql: ${TABLE}.address.addressLine3 ;;
    group_label: "Address"
    group_item_label: "Address Line 3"
  }

  dimension: address__address_line4 {
    type: string
    sql: ${TABLE}.address.addressLine4 ;;
    group_label: "Address"
    group_item_label: "Address Line 4"
  }

  dimension: address__address_line5 {
    type: string
    sql: ${TABLE}.address.addressLine5 ;;
    group_label: "Address"
    group_item_label: "Address Line 5"
  }

  dimension: address__address_uid {
    type: string
    sql: ${TABLE}.address.addressUID ;;
    group_label: "Address"
    group_item_label: "Address UID"
  }

  dimension: address__country {
    type: string
    sql: ${TABLE}.address.country ;;
    group_label: "Address"
    group_item_label: "Country"
  }

  dimension: address__country_code {
    type: string
    sql: ${TABLE}.address.countryCode ;;
    group_label: "Address"
    group_item_label: "Country Code"
  }

  dimension: address__country_code2 {
    type: string
    sql: ${TABLE}.address.countryCode2 ;;
    group_label: "Address"
    group_item_label: "Country Code 2"
  }

  dimension: address__postcode {
    type: string
    sql: ${TABLE}.address.postcode ;;
    group_label: "Address"
    group_item_label: "Postcode"
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
  }

  dimension: customer__company {
    type: string
    sql: ${TABLE}.customer.company ;;
    group_label: "Customer"
    group_item_label: "Company"
  }

  dimension: customer__email {
    type: string
    sql: ${TABLE}.customer.email ;;
    group_label: "Customer"
    group_item_label: "Email"
  }

  dimension: customer__first_name {
    type: string
    sql: ${TABLE}.customer.firstName ;;
    group_label: "Customer"
    group_item_label: "First Name"
  }

  dimension: customer__last_name {
    type: string
    sql: ${TABLE}.customer.lastName ;;
    group_label: "Customer"
    group_item_label: "Last Name"
  }

  dimension: customer__mobile {
    type: string
    sql: ${TABLE}.customer.mobile ;;
    group_label: "Customer"
    group_item_label: "Mobile"
  }

  dimension: customer__telephone {
    type: string
    sql: ${TABLE}.customer.telephone ;;
    group_label: "Customer"
    group_item_label: "Telephone"
  }

  dimension: customer__title {
    type: string
    sql: ${TABLE}.customer.title ;;
    group_label: "Customer"
    group_item_label: "Title"
  }

  dimension: customer_uid {
    type: string
    primary_key: yes
    sql: ${TABLE}.customerUID ;;
    label: "Customer UID"
  }

  dimension: flags__active_account {
    type: yesno
    sql: ${TABLE}.flags.activeAccount ;;
    group_label: "Flags"
    group_item_label: "Active Account"
  }

  dimension: flags__address_do_not_use {
    type: yesno
    sql: ${TABLE}.flags.addressDoNotUse ;;
    group_label: "Flags"
    group_item_label: "Address Do Not Use"
  }

  dimension: flags__address_profanity {
    type: yesno
    sql: ${TABLE}.flags.addressProfanity ;;
    group_label: "Flags"
    group_item_label: "Address Profanity"
  }

  dimension: flags__customer_do_not_use {
    type: yesno
    sql: ${TABLE}.flags.customerDoNotUse ;;
    group_label: "Flags"
    group_item_label: "Customer Do Not Use"
  }

  dimension: flags__customer_profanity {
    type: yesno
    sql: ${TABLE}.flags.customerProfanity ;;
    group_label: "Flags"
    group_item_label: "Customer Profanity"
  }

  dimension: flags__guest_checkout {
    type: yesno
    sql: ${TABLE}.flags.guestCheckout ;;
    group_label: "Flags"
    group_item_label: "Guest Checkout"
  }

  dimension: flags__toolstation_account {
    type: string
    sql: ${TABLE}.flags.toolstationAccount ;;
    group_label: "Flags"
    group_item_label: "Toolstation Account"
  }

  dimension: flags__toolstation_address {
    type: yesno
    sql: ${TABLE}.flags.toolstationAddress ;;
    group_label: "Flags"
    group_item_label: "Toolstation Address"
  }

  dimension: permissions__catalogue_mail_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.catalogue_mail_opt_in ;;
    group_label: "Permissions"
    group_item_label: "Catalogue Mail Opt In"
  }

  dimension: permissions__offers_email_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.offers_email_opt_in ;;
    group_label: "Permissions"
    group_item_label: "Offers Email Opt In"
  }

  dimension: permissions__offers_mail_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.offers_mail_opt_in ;;
    group_label: "Permissions"
    group_item_label: "Offers Mail Opt In"
  }

  dimension: permissions__offers_mobile_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.offers_mobile_opt_in ;;
    group_label: "Permissions"
    group_item_label: "Offers Mobile Opt In"
  }

  dimension: permissions__offers_notif_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.Offers_Notif_Opt_In ;;
    group_label: "Permissions"
    group_item_label: "Offers Notif Opt In"
  }

  dimension: permissions__offers_sms_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.offers_sms_opt_in ;;
    group_label: "Permissions"
    group_item_label: "Offers Sms Opt In"
  }

  dimension: permissions__order_process_email_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.order_process_email_opt_in ;;
    group_label: "Permissions"
    group_item_label: "Order Process Email Opt In"
  }

  dimension: permissions__order_process_notif_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.Order_Process_Notif_Opt_In ;;
    group_label: "Permissions"
    group_item_label: "Order Process Notif Opt In"
  }

  dimension: permissions__order_process_sms_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.order_process_sms_opt_in ;;
    group_label: "Permissions"
    group_item_label: "Order Process Sms Opt In"
  }

  dimension: permissions__order_query_email_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.order_query_email_opt_in ;;
    group_label: "Permissions"
    group_item_label: "Order Query Email Opt In"
  }

  dimension: permissions__order_query_mobile_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.order_query_mobile_opt_in ;;
    group_label: "Permissions"
    group_item_label: "Order Query Mobile Opt In"
  }

  dimension: permissions__order_query_notif_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.Order_Query_Notif_Opt_In ;;
    group_label: "Permissions"
    group_item_label: "Order Query Notif Opt In"
  }

  dimension: permissions__order_query_sms_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.order_query_sms_opt_in ;;
    group_label: "Permissions"
    group_item_label: "Order Query Sms Opt In"
  }

  dimension: permissions__order_query_telephone_opt_in {
    type: yesno
    sql: ${TABLE}.permissions.order_query_telephone_opt_in ;;
    group_label: "Permissions"
    group_item_label: "Order Query Telephone Opt In"
  }

  dimension: trade_customer {
    type:  string
    group_label: "Flags"
    sql: case when ${trade_customers.customer_number} is null then False else True end ;;
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
  }


}
