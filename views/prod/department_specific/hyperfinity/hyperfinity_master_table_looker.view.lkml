view: hyperfinity_master_table_looker {
  derived_table: {
    sql:
      select *,
      row_number () over () as prim_key,
      from `toolstation-data-storage.crm_reporting.HYPERFINITY_MASTER_TABLE_FOR_LOOKER`
      where customerUID is not null
      ;;
  }

  dimension: prim_key {
    type:number
    sql:${TABLE}.prim_key;;
    primary_key: yes
    hidden:yes
  }

  dimension: customerUID {
    type:string
    sql:${TABLE}.customerUID;;
    hidden:yes
  }

  dimension: calendar_year_month {
    type:string
    sql:${TABLE}.CALENDARYEARMONTH;;
    hidden:yes
  }

  dimension: RFV_group_number_start {
    group_label: "RFV Group"
    type:number
    sql:${TABLE}.RFV_GROUP_NUM_START;;
  }

  dimension: RFV_group_number_end {
    group_label: "RFV Group"
    type:number
    sql:${TABLE}.RFV_GROUP_NUM_END;;
  }

  dimension: RFV_group_start {
    group_label: "RFV Group"
    type:string
    sql:${TABLE}.RFV_GROUP_START;;
  }

  dimension: RFV_group_end {
    group_label: "RFV Group"
    type:string
    sql:${TABLE}.RFV_GROUP_END;;
  }

  dimension: cluster_high_level_start {
    group_label: "Cluster Level"
    type:string
    sql:${TABLE}.CLUSTER_HIGHLEVEL_START;;
  }

  dimension: cluster_high_level_end {
    group_label: "Cluster Level"
    type:string
    sql:${TABLE}.CLUSTER_HIGHLEVEL_end;;
  }

  dimension: cluster_low_level_start {
    group_label: "Cluster Level"
    type:string
    sql:${TABLE}.CLUSTER_LOWLEVEL_START;;
  }

  dimension: cluster_low_level_end {
    group_label: "Cluster Level"
    type:string
    sql:${TABLE}.CLUSTER_LOWLEVEL_end;;
  }
}
