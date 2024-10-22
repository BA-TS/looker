view: tp_hire_enquiries{
  sql_table_name: `toolstation-data-storage.customer.tp_hire_enquiries`;;

  dimension: customerUID {
    hidden: yes
    type: string
    sql: ${TABLE}.customer_uid ;;
  }

  dimension: is_tp_hire_customer{
    label: "Is TP Hire Customer"
    type: string
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
  }

  dimension: colleague_name {
    type: string
    sql: ${TABLE}.colleague_name ;;
  }

  # dimension: created_at {
  #   type: date_time
  #   sql: ${TABLE}.created_at ;;
  # }

  # dimension: updated_at {
  #   type: date_time
  #   sql: ${TABLE}.updated_at ;;
  # }

}
