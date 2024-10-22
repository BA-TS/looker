view: tp_hire_enquiries{
  derived_table: {
    sql:
    select
    id,
    trim(customer_uid) as customer_uid,
    customer_enquiry,
    customer_enquiry_other,
    additional_information,
    branch_id,
    colleague_name,
    date(created_at) as created_at,
    date(updated_at) as updated_at,
    from
    `toolstation-data-storage.customer.tp_hire_enquiries`;;
  }

  dimension: referral_id {
    hidden: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: customerUID {
    hidden: yes
    type: string
    sql: ${TABLE}.customer_uid ;;
  }

  dimension: is_tp_hire_customer{
    label: "Is TP Hire Customer"
    type: yesno
    sql: ${customerUID} is not null;;
  }

  dimension: customer_enquiry {
    type: string
    sql: ${TABLE}.customer_enquiry;;
  }

  dimension: customer_enquiry_other {
    type: string
    sql: ${TABLE}.customer_enquiry_other ;;
  }

  dimension: additional_information {
    type: string
    sql: ${TABLE}.additional_information ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.branch_id ;;
    hidden: yes
  }

  dimension: colleague_name {
    type: string
    sql: ${TABLE}.colleague_name ;;
  }

  measure: number_of_referrals {
    type: count_distinct
    sql: ${referral_id} ;;
  }

  dimension_group: created_at {
    label: "Created At"
    datatype: date
    timeframes: [date, week, month, year]
    type: time
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: updated_at {
    label: "Updated At"
    datatype: date
    timeframes: [date, week, month, year]
    type: time
    sql: ${TABLE}.updated_at ;;
  }

}
