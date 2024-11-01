view: customer_loyalty {
  derived_table: {
    sql:
    select
    customerUID,
    date(loyalty.sign_up_date) as sign_up_date,
    coalesce(date(loyalty.leave_date),current_date) as leave_date
    from `toolstation-data-storage.customer.allCustomers`
    where loyalty.loyalty_club_member = true
    ;;
    datagroup_trigger: ts_transactions_datagroup
  }

  dimension: customer_uid {
    group_label: "Customer"
    label: "Customer UID"
    type: string
    primary_key: yes
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: active_loyalty_club_member {
    group_label: "Loyalty Club"
    type: string
    sql: case when ${customer_uid} is not null then "Yes" else "No" end ;;
  }

  dimension_group: loyalty_club_start {
    group_label: "Loyalty Club"
    group_item_label: "Sign Up Date"
    type: time
    datatype: date
    sql: ${TABLE}.sign_up_date ;;
    timeframes: [
      date,
      month,
    ]
    hidden: yes
  }

  dimension_group: loyalty_club_end {
    group_label: "Loyalty Club"
    group_item_label: "Leave Date"
    type: time
    datatype: date
    sql: ${TABLE}.leave_date ;;
    hidden: yes
    timeframes: [
      date,
      month
    ]
  }

}
