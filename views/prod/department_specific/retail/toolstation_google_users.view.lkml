view: toolstation_google_users {

derived_table: {
  sql:
  select *,
  row_number () over () as prim_key,
  from `toolstation-data-storage.HR.toolstation_google_users`
  ;;
}

  dimension: prim_key {
    sql: ${TABLE}.prim_key ;;
    hidden: yes
    type: string
  }

  dimension: employee_id {
    required_access_grants: [lz_testing]
    sql: ${TABLE}.employeeId ;;
    type: string
  }

  dimension: employeeRef {
    sql: ${TABLE}.employeeRef ;;
    type: string
    hidden: yes
  }

  dimension: name {
    required_access_grants: [lz_testing]
    sql: concat(${TABLE}.firstName," ",${TABLE}.lastName) ;;
    type: string
  }

  dimension: manager_id {
    sql: ${TABLE}.managerID ;;
    type: string
  }

  dimension: primary_email {
    sql: ${TABLE}.primaryEmail ;;
    type: string
    hidden: yes
  }

  dimension: job_title {
    sql: ${TABLE}.jobTitle ;;
    type: string
  }

  dimension: employee_type {
    sql: ${TABLE}.employeeType ;;
    type: string
  }

  dimension: siteUID {
    sql: ${TABLE}.siteUID ;;
    type: string
    hidden: yes
  }

  dimension: length_of_service_years{
    sql: ${TABLE}.lengthOfServiceYears ;;
    type: number
  }

  measure: number_of_colleagues {
    sql: ${employee_id} ;;
    type: count_distinct
  }

}
