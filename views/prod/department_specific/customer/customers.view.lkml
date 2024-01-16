include: "/views/prod/department_specific/finance/transactions.view"
include: "/views/prod/department_specific/customer/trade_customers.view"
include: "/views/prod/department_specific/customer/trade_credit_details.view"
include: "/views/prod/department_specific/customer/customer_classification.view"
include: "/views/prod/department_specific/customer/assumed_trade_dataiku.view"


view: customers {
  sql_table_name: `toolstation-data-storage.customer.allCustomers`;;

  dimension: customer_uid {
    group_label: "Customer"
    label: "Customer UID"
    required_access_grants: [can_use_customer_information2]
    type: string
    primary_key: yes
    sql: ${TABLE}.customerUID ;;
  }

  dimension: customer_uid2 {
    group_label: "Customer"
    label: "Customer UID"
    required_access_grants: [user_lauren_england]
    type: string
    sql: concat("T",abs(FARM_FINGERPRINT(${customer_uid})));;
  }

  dimension: address__address_line1 {
    group_label: "Customer Address"
    group_item_label: "Address Line 1"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.address.addressLine1 ;;

  }

  dimension: address__address_line2 {
    group_label: "Customer Address"
    group_item_label: "Address Line 2"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.address.addressLine2 ;;
  }

  dimension: address__address_line3 {
    group_label: "Customer Address"
    group_item_label: "Address Line 3"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.address.addressLine3 ;;
  }

  dimension: address__address_line4 {
    group_label: "Customer Address"
    group_item_label: "Address Line 4"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.address.addressLine4 ;;
  }

  dimension: address__address_line5 {
    group_label: "Customer Address"
    group_item_label: "Address Line 5"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.address.addressLine5 ;;
  }

  dimension: address__address_uid {
    group_label: "Customer Address"
    group_item_label: "Address UID"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.address.addressUID ;;
    hidden: yes
  }

  dimension: address__country {
    group_label: "Customer Address"
    required_access_grants: [can_use_customer_information]
    group_item_label: "Country"
    type: string
    sql: ${TABLE}.address.country ;;
  }

  dimension: address__country_is_uk {
    group_label: "Flags"
    required_access_grants: [can_use_customer_information]
    group_item_label: "Address Country - Is UK"
    type: yesno
    sql: ${address__country}="United Kingdom" OR ${address__country} is null;;
  }


  dimension: address__country_code {
    group_label: "Customer Address"
    group_item_label: "Country Code"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.address.countryCode ;;
    hidden: yes
  }

  dimension: address__country_code2 {
    group_label: "Customer Address"
    group_item_label: "Country Code 2"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.address.countryCode2 ;;
    hidden: yes
  }

  dimension: address__postcode {
    group_label: "Customer Address"
    group_item_label: "Postcode"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.address.postcode ;;
  }

  dimension: loyalty_club_member {
    group_label: "Loyalty Club"
    group_item_label: "Loyalty Club Member"
    required_access_grants: [can_use_customer_information]
    type: string
    sql:CASE WHEN ${TABLE}.loyalty.loyalty_club_member  THEN "Yes" ELSE "No" END;;
  }

  dimension: loyalty_club_start {
    group_label: "Loyalty Club"
    group_item_label: "Sign Up Date"
    required_access_grants: [can_use_customer_information]
    type: date
    sql: ${TABLE}.loyalty.sign_up_date ;;
  }

  dimension: loyalty_club_end {
    group_label: "Loyalty Club"
    group_item_label: "Leave Date"
    required_access_grants: [can_use_customer_information]
    type: date
    sql: ${TABLE}.loyalty.leave_date ;;
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
    group_label: "Customer"
    group_item_label: "Company"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.customer.company ;;
  }

  dimension: customer__email {
    group_label: "Customer"
    group_item_label: "Email"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.customer.email ;;
  }

  dimension: customer__first_name {
    group_label: "Customer"
    group_item_label: "First Name"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.customer.firstName ;;
  }

  dimension: customer__last_name {
    group_label: "Customer"
    group_item_label: "Last Name"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.customer.lastName ;;
  }

  dimension: customer__mobile {
    group_label: "Customer"
    group_item_label: "Mobile"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.customer.mobile ;;
  }

  dimension: customer__telephone {
    group_label: "Customer"
    group_item_label: "Telephone"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.customer.telephone ;;
  }

  dimension: customer__title {
    group_label: "Customer"
    group_item_label: "Title"
    required_access_grants: [can_use_customer_information]
    type: string
    sql: ${TABLE}.customer.title ;;
  }

  dimension: flags__active_account {
    group_label: "Flags"
    group_item_label: "Active Account"
    type: yesno
    sql: ${TABLE}.flags.activeAccount = true;;
    hidden: yes
  }

  dimension: flags__address_do_not_use {
    group_label: "Flags"
    group_item_label: "Address Do Not Use"
    label: "Address - Do Not Use?"
    type: yesno
    sql: ${TABLE}.flags.addressDoNotUse = true ;;
  }

  dimension: flags__address_profanity {
    group_label: "Flags"
    group_item_label: "Address - Profanity?"
    type: yesno
    sql: ${TABLE}.flags.addressProfanity = true ;;
  }

  dimension: flags__customer_do_not_use {
    group_label: "Flags"
    group_item_label: "Customer - Do Not Use?"
    type: yesno
    sql: ${TABLE}.flags.customerDoNotUse = true ;;
  }

  dimension: flags__customer_profanity {
    group_label: "Flags"
    group_item_label: "Customer - Profanity?"
    type: yesno
    sql: ${TABLE}.flags.customerProfanity = true ;;
  }

  dimension: flags__customer_anonymous {
    group_label: "Flags"
    label: "Customer - Anonymous?"
    description: "If a customer is anonymous"
    type: yesno
    sql:${customer__email} LIKE "TILL_%TOOLSTATION.COM";;
  }

  dimension: flags__guest_checkout {
    group_label: "Flags"
    label: "Guest Checkout?"
    type: yesno
    sql: ${TABLE}.flags.guestCheckout = true ;;
  }

  dimension: flags__toolstation_account {
    group_label: "Flags"
    label: "Toolstation - Internal Account?"
    description: "Flag for accounts that are Toolstation-owned."
    type: yesno
    sql: ${TABLE}.flags.toolstationAccount = "true" ;;
  }

  dimension: flags__toolstation_address {
    group_label: "Flags"
    group_item_label: "Toolstation - Internal Address?"
    description: "Flag for Toolstation-owned account addresses."
    type: yesno
    sql: ${TABLE}.flags.toolstationAddress = true ;;
  }

  dimension: permissions__catalogue_mail_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "Catalogue (Mail)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.catalogue_mail_opt_in = true ;;
  }

  dimension: permissions__offers_email_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "Email (Offers)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.offers_email_opt_in = true ;;
  }

  dimension: permissions__offers_mail_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "Mail (Offers)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.offers_mail_opt_in = true ;;
  }

  dimension: permissions__offers_mobile_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "Mobile (Offers)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.offers_mobile_opt_in = true ;;
  }

  dimension: permissions__offers_notif_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "Notification (Offers)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.Offers_Notif_Opt_In = true ;;
  }

  dimension: permissions__offers_sms_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "SMS (Offers)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.offers_sms_opt_in = true ;;
  }

  dimension: permissions__order_process_email_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "Email (Order Process)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_process_email_opt_in = true ;;
  }

  dimension: permissions__order_process_notif_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "Notification (Order Process)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.Order_Process_Notif_Opt_In = true ;;
  }

  dimension: permissions__order_process_sms_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "SMS (Order Process)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_process_sms_opt_in = true ;;
  }

  dimension: permissions__order_query_email_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "Email (Order Query)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_query_email_opt_in = true ;;
  }

  dimension: permissions__order_query_mobile_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "Mobile (Order Query)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_query_mobile_opt_in = true ;;
  }

  dimension: permissions__order_query_notif_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "Notification (Order Query)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.Order_Query_Notif_Opt_In = true ;;
  }

  dimension: permissions__order_query_sms_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "SMS (Order Query)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_query_sms_opt_in = true ;;
  }

  dimension: permissions__order_query_telephone_opt_in {
    group_label: "Permissions (Opt In)"
    group_item_label: "Telephone (Order Query)"
    required_access_grants: [can_use_customer_information]
    type: yesno
    sql: ${TABLE}.permissions.order_query_telephone_opt_in = true ;;
  }

  dimension: is_trade {
    description: "A customer who has been classified as a 'Trade' customer. Please note that this is a dynamic field which is updated constantly, so values may vary."
    group_label: "Flags"
    label: "Is Trade"
    type:  yesno
    sql:${trade_customers.trade_flag} is not null;;
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

  dimension: is_new_customer {
    description: "A new customer is classified as an account created in the last 30 days."
    group_label: "Flags"
    type: yesno
    sql:${creation_date} >= CURRENT_DATE() - 30;;
  }

  dimension_group: customer_account_created{
    label: "Customer Account Creation"
    group_label: "Customer"
    type: time
    datatype: date
    timeframes: [year]
    sql:${creation_date};;
  }

  dimension: customer_classification_type {
    type: string
    group_label: "Flags"
    label: "Is Trade/Assumed/DIY"
    sql:${customer_classification.customer_type} ;;
  }

  dimension: assumed_trade_2023_prediction {
    view_label: "Customer Classification"
    group_label: "Flags"
    label: "Is Assumed Trade (2023)"
    type:  string
    sql:
          CASE
          WHEN ${is_trade} = false AND ${assumed_trade_dataiku.final_prediction} = true THEN 'Assumed Trade'
          WHEN ${is_trade} = false THEN 'DIY'
          ELSE 'Existing Trade'
        END ;;
  }

  dimension: assumed_trade_2023_prediction2 {
    view_label: "Customer Classification"
    group_label: "Flags"
    label: "Is Assumed Trade (Total Trade, 2023)"
    type:  string
    sql:
          CASE
          WHEN ${is_trade} = false AND ${assumed_trade_dataiku.final_prediction} = true THEN 'Total Trade'
          WHEN ${is_trade} = false THEN 'DIY'
          ELSE 'Total Trade'
        END ;;
  }

  measure: number_of_customers {
    label: "
    {% if _explore._name == 'GA4' %}
    {% else %}
    Number of Customers
    {% endif %}"
    description: "A count of the number of unique customers."
    type: count_distinct
    sql: ${customer_uid} ;;
  }

  measure: trade_customers_total {
    type: count_distinct
    value_format: "#,##0;(#,##0)"
    sql: CASE WHEN ${is_trade} = true THEN ${customer_uid}  ELSE NULL END;;
    hidden: yes
  }

  measure: non_trade_customers_total {
    type: count_distinct
    value_format: "#,##0;(#,##0)"
    sql: CASE WHEN ${is_trade} = false THEN ${customer_uid}  ELSE NULL END;;
    hidden: yes
  }

  measure: trade_percent {
    #view_label: "Measures"
    group_label: "Core Metrics"
    label: "Trade Customers %"
    type: number
    sql: ${trade_customers_total}/NULLIF((${trade_customers_total}+${non_trade_customers_total}),0);;
    value_format: "0.0%"
  }

  measure: number_of_opt_ins {
    description: "A count of the number of unique Opt ins."
    type: sum_distinct
    sql:
    (case when ${permissions__catalogue_mail_opt_in} then 1 else 0 end)
    +(case when ${permissions__offers_email_opt_in} then 1 else 0 end)
    +(case when ${permissions__offers_mail_opt_in} then 1 else 0 end)
    +(case when ${permissions__offers_mobile_opt_in} then 1 else 0 end)
    +(case when ${permissions__offers_notif_opt_in} then 1 else 0 end)
    +(case when ${permissions__offers_sms_opt_in} then 1 else 0 end)
    +(case when ${permissions__order_process_email_opt_in} then 1 else 0 end)
    +(case when ${permissions__order_process_notif_opt_in} then 1 else 0 end)
    +(case when ${permissions__order_process_sms_opt_in} then 1 else 0 end)
    +(case when ${permissions__order_query_email_opt_in} then 1 else 0 end)
    +(case when ${permissions__order_query_mobile_opt_in} then 1 else 0 end)
    +(case when ${permissions__order_query_notif_opt_in} then 1 else 0 end)
    +(case when ${permissions__order_query_sms_opt_in} then 1 else 0 end)
    +(case when ${permissions__order_query_telephone_opt_in} then 1 else 0 end) ;;
    required_access_grants: [lz_testing]
  }

  measure: number_of_opt_outs {
    description: "A count of the number of unique Opt ins."
    type: sum_distinct
    sql:
    (case when ${permissions__catalogue_mail_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__offers_email_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__offers_mail_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__offers_mobile_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__offers_notif_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__offers_sms_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__order_process_email_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__order_process_notif_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__order_process_sms_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__order_query_email_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__order_query_mobile_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__order_query_notif_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__order_query_sms_opt_in}=false then 1 else 0 end)
    +(case when ${permissions__order_query_telephone_opt_in}=false then 1 else 0 end) ;;
    required_access_grants: [lz_testing]
  }

  measure: opt_in_percent {
    label: "Customer Permissions Total Opt in %"
    type: number
    sql:${number_of_opt_ins}/(${number_of_opt_ins}+${number_of_opt_outs}) ;;
    value_format: "0.00%"
    required_access_grants: [lz_testing]
  }
}
