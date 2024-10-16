include: "/views/**/transactions.view"

view: bdm_ka_customers {
  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    team,
    bdm,
    customerUID,
    coalesce(startDate,date_sub(current_date,interval 3 year)) as startDate,
    coalesce(endDate,current_date) as endDate,
    customerName
    from
    `toolstation-data-storage.retailReporting.BDM_KA_CUSTOMERS_LIST`
    where bdm is not null
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
    label: "Name"
    type: string
    sql: ${TABLE}.bdm ;;
  }

  # dimension: active_bdm {
  #   type: yesno
  #   sql: ${bdm} in ("Matty","Kim","Chris","Louise","London","Rob","Rachel") ;;
  # }

  dimension_group: start {
    view_label: "Customer Accounts"
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

  dimension: customer_TY {
    view_label: "Customer Accounts"
    label: "Account Created This Year"
    type: yesno
    sql:${start_year}=extract (year from current_date);;
  }

  dimension_group: end {
    view_label: "Customer Accounts"
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
    view_label: "Customer Accounts"
    type: string
    sql: ${TABLE}.customerName ;;
  }

  dimension: is_bdm_ka_customer {
    view_label: "Customer Accounts"
    label: "Is BDM or KA Customer"
    type: yesno
    sql:${customer_uid} is not null;;
    hidden: yes
  }

  dimension: is_active {
    view_label: "Customer Accounts"
    type: yesno
    label: "Is Account Active"
    sql: ${customer_uid} is not null ;;
  }

  dimension: period {
    view_label: "Customer Accounts"
    type: string
    label: "Period - Pre vs Managed"
    sql:
    case when ${start_date}<${transactions.order_completed_date}
    then "Pre" else "Managed"
    End ;;
  }

  dimension: classification {
    view_label: "Customer Accounts"
    label: "Account Classification"
    type: string
    sql:
    case
      when (date_diff(current_date()-1, ${start_date}, day)) > 364 then 'Existing'
      when (date_diff(${start_date}, ${transactions.order_completed_date},day)) <= 364 then 'Existing'
      when (date_diff(${start_date}, ${transactions.order_completed_date}, day)) is null then 'New'
      when (date_diff(${start_date}, ${transactions.order_completed_date}, day)) > 364 then 'New'
      else 'Time Traveler' end;;
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
