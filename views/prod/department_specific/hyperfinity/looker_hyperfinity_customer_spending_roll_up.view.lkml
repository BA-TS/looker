view: looker_hyperfinity_customer_spending_roll_up {
 derived_table: {
  sql:
    select *,
    row_number() over () as prim_key
    from toolstation-data-storage.crm_reporting.LOOKER_HYPERFINITY_CUSTOMER_SPENDING_ROLL_UP  ;;
 }

  dimension: prim_key {
    sql: ${TABLE}.prim_key ;;
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

  # dimension: cluster_high_level_start {
  #   group_label: "Cluster"
  #   sql: ${TABLE}.CLUSTER_HIGHLEVEL_START ;;
  #   type: string
  # }

  # dimension: cluster_high_level_end {
  #   group_label: "Cluster"
  #   sql: ${TABLE}.CLUSTER_HIGHLEVEL_END ;;
  #   type: string
  # }

  # dimension: cluster_low_level_start {
  #   group_label: "Cluster"
  #   sql: ${TABLE}.CLUSTER_LOWLEVEL_START ;;
  #   type: string
  # }

  # dimension: cluster_low_level_end {
  #   group_label: "Cluster"
  #   sql: ${TABLE}.CLUSTER_LOWLEVEL_END ;;
  #   type: string
  # }

  # dimension: RFV_group_number_start {
  #   group_label: "RFV Group"
  #   sql: ${TABLE}.RFV_GROUP_NUM_START ;;
  #   type: number
  # }

  dimension: RFV_group_number {
    group_label: "RFV Group"
    sql: ${TABLE}.RFV_GROUP_NUM ;;
    type: number
  }

  # dimension: RFV_group_number_end {
  #   group_label: "RFV Group"
  #   sql: ${TABLE}.RFV_GROUP_NUM_END ;;
  #   type: number
  # }

    dimension: RFV_group {
    group_label: "RFV Group"
    sql: ${TABLE}.RFV_GROUP ;;
    type: string
  }

  # dimension: RFV_group_start {
  #   group_label: "RFV Group"
  #   sql: ${TABLE}.RFV_GROUP_START ;;
  #   type: string
  # }

  # dimension: RFV_group_end {
  #   group_label: "RFV Group"
  #   sql: ${TABLE}.RFV_GROUP_END ;;
  #   type: string
  # }

  dimension:BSEG_high_level {
    group_label: "BSEG"
    sql: ${TABLE}.BSEG_HIGHLEVEL ;;
    type: string
  }

  dimension:BSEG_low_level {
    group_label: "BSEG"
    sql: ${TABLE}.BSEG_LOWLEVEL ;;
    type: string
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
