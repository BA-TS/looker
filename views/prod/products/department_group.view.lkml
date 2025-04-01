view: department_group {

  derived_table: {
    sql:
    select * from `toolstation-data-storage.range.Department_Groups`
    ;;
   datagroup_trigger: ts_monthly_datagroup
  }

  dimension: department {
    group_label: "Department Group"
    type: string
    sql: ${TABLE}.department ;;
    primary_key: yes
    hidden: yes
  }

  dimension: department_type {
    group_label: "Department Group"
    type: string
    sql: ${TABLE}.Department_Type ;;
  }

  dimension: senior_department_group {
    group_label: "Department Group"
    type: string
    sql: ${TABLE}.Senior_Department_Group ;;
  }
}
