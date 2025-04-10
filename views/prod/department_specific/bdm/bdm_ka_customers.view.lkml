include: "/views/**/transactions.view"

view: bdm_ka_customers {
  derived_table: {
    sql:
   select
    DISTINCT row_number() over () AS prim_key,
    team,
    bdm,
    customerUID,
    startDate,
    max(coalesce(endDate,current_date)) as endDate,
    company as customerName
    from
    `toolstation-data-storage.retailReporting.BDM_KA_LEDGER`
    where bdm is not null
    group by all
    order by startDate desc
    ;;
    datagroup_trigger: ts_daily_datagroup
  }

  dimension: prim_key {
    type: string
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: customer_uid {
    view_label: "Customers"
    label: "Customer UID"
    type: string
    sql: ${TABLE}.customerUID ;;
  }

  dimension: team {
    label: "Team (BDM or KA)"
    type: string
    sql: ${TABLE}.team ;;
  }

  dimension: bdm {
    label: "Name of BDM"
    type: string
    sql: ${TABLE}.bdm ;;
  }

  # dimension: classification {
  #   label: "Customer Classification"
  #   type: string
  #   sql: ${TABLE}.classification ;;
  # }

  dimension_group: start {
    view_label: "Customers"
    group_label: "Start and End Dates"
    type: time
    datatype: date
    sql: ${TABLE}.startDate ;;
    timeframes: [
      date,
      month,
      year
    ]
  }


  # dimension_group: first_transaction {
  #   view_label: "Customers"
  #   type: time
  #   datatype: date
  #   sql: ${TABLE}.first_transaction ;;
  #   timeframes: [
  #     date,
  #     raw,
  #     month,
  #     year
  #   ]
  # }

  dimension: customer_TY {
    view_label: "Customers"
    label: "Account Created This Year"
    type: yesno
    sql:${start_year}=extract (year from current_date);;
  }

  dimension_group: end {
    view_label: "Customers"
    group_label: "Start and End Dates"
    type: time
    datatype: date
    sql: ${TABLE}.endDate;;
    timeframes: [
      date,
      month,
      year
    ]
  }

  dimension: customer_name {
    view_label: "Customers"
    type: string
    sql: ${TABLE}.customerName ;;
    hidden: yes

  }

  dimension: is_bdm_ka_customer {
    view_label: "Customers"
    label: "Is BDM or KA Customer"
    type: yesno
    sql:${customer_uid} is not null;;
    hidden: yes
  }

  dimension: is_active {
    view_label: "Customers"
    type: yesno
    label: "Is Account Active"
    sql: ${customer_uid} is not null ;;
  }

  dimension: period {
    view_label: "Customers"
    type: string
    label: "Period - Pre vs Managed"
    sql:
    case when ${start_date}<${transactions.order_completed_date}
    then "Pre" else "Managed"
    End ;;
  }

  # dimension: classification {
  #   view_label: "Customers"
  #   label: "Account Classification"
  #   type: string
  #   sql:
  #   case
  #     when (date_diff(current_date()-1, ${start_date}, day)) > 364 then 'Existing'
  #     when (date_diff(${start_date}, ${transactions.order_completed_date},day)) <= 364 then 'Existing'
  #     when (date_diff(${start_date}, ${transactions.order_completed_date}, day)) is null then 'New'
  #     when (date_diff(${start_date}, ${transactions.order_completed_date}, day)) > 364 then 'New'
  #     else 'Time Traveler' end;;
  # }

  dimension: credit_limit {
    type: number
    sql: ${TABLE}.creditLimit ;;
    value_format_name: gbp_0
  }

  dimension: website_raw {
    type: string
    sql: concat("https://",replace(${TABLE}.website,"https://","")) ;;
    hidden: yes
  }

  dimension: website_label {
    type: string
    sql: replace(replace(replace(${TABLE}.website,"https:",""),"www.",""),"/","") ;;
    hidden: yes
  }

  dimension: website {
    type: string
    sql: ${website_raw} ;;
    html: <a href="{{ website_raw}}"target=”_blank”>{{ website_label }}</a> ;;
  }

  dimension: email_raw {
    type: string
    sql: ${TABLE}.email ;;
    hidden: yes
  }

  dimension: email {
    type: string
    sql: ${email_raw} ;;
    html: <a href="mail:to {{ email_raw}}">{{ email_raw }}</a> ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: contact {
    type: string
    sql: ${TABLE}.contact ;;
  }

  dimension: job_title {
    type: string
    sql: ${TABLE}.jobTitle ;;
  }

  dimension: office_number {
    type: string
    sql: ${TABLE}.officeNumber ;;
  }

  dimension: phone_number {
    type: string
    sql: ${TABLE}.phoneNumber ;;
  }

  dimension: account_number {
    type: string
    sql: ${TABLE}.accountNumber ;;
  }

  measure: average_credit_limit {
    type: average
    sql: ${credit_limit} ;;
    value_format_name: gbp_0
  }

  measure: number_of_bdm {
    view_label: "Measures"
    label: "Number of BDMs"
    type: count_distinct
    sql: ${bdm};;
  }

  measure: number_of_customers {
    view_label: "Measures"
    type: count_distinct
    sql: ${customer_uid};;
  }
}
