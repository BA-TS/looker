view: tp_hire_enquiries{
  sql_table_name: `toolstation-data-storage.customer.tp_hire_enquiries`;;

  dimension: customerUID {
    type: string
    sql: ${TABLE}.customer_uid ;;
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
