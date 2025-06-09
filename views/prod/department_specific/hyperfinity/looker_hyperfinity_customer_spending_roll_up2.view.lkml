view: looker_hyperfinity_customer_spending_roll_up2 {
  derived_table: {
    sql:
    select customeruid,
    calendaryearmonth,
    transacted,
    from toolstation-data-storage.crm_reporting.LOOKER_HYPERFINITY_CUSTOMER_SPENDING_ROLL_UP
    where transacted = "1"
    ;;
  }

  dimension: prim_key {
    sql: concat(${customer_uid},${calendar_year_month}) ;;
    type: number
    primary_key: yes
    hidden: yes
  }

  dimension: customer_uid {
    sql: ${TABLE}.customeruid ;;
    type: string
    hidden: yes
  }

  dimension: calendar_year_month {
    sql: cast(${TABLE}.calendaryearmonth as string);;
    type: string
    hidden: yes
  }

  dimension:transacted_month {
    sql: cast(${TABLE}.transacted as int) ;;
    type: number
    # hidden: yes
  }

  measure: number_of_transactions{
    label: "Number of months (Transacted)"
    sql: ${transacted_month} ;;
    type: sum
  }


}
