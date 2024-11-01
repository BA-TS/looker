view: customer_loyalty {
  derived_table: {
    sql:
    select
    customerUID,
    date(loyalty.sign_up_date),
    coalesce(date(loyalty.leave_date),current_date)
    from `toolstation-data-storage.customer.allCustomers`
    where loyalty.loyalty_club_member = true
    ;;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: customer_uid {
    group_label: "Customer"
    label: "Customer UID"
    required_access_grants: [can_use_customer_information2]
    type: string
    primary_key: yes
    sql: ${TABLE}.customerUID ;;
  }

  dimension_group: loyalty_club_start {
    group_label: "Loyalty Club"
    group_item_label: "Sign Up Date"
    type: time
    datatype: date
    sql: ${TABLE}.loyalty.sign_up_date ;;
    timeframes: [
      date,
      month,
    ]
  }

  dimension_group: loyalty_club_end {
    group_label: "Loyalty Club"
    group_item_label: "Leave Date"
    type: time
    datatype: date
    sql: ${TABLE}.loyalty.leave_date ;;
    hidden: yes
    timeframes: [
      date,
      month
    ]
  }

}
