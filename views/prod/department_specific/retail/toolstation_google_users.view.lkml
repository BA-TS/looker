view: toolstation_google_users {

derived_table: {
  sql:
  select *,
  row_number () over () as prim_key,
  from `toolstation-data-storage.HR.toolstation_google_users`
  where department = "Retail"
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

  dimension: is_store_manager {
    group_label: "Job Title Flags"
    sql: ${job_title} IN ("Store Manager","Store Manager Designate") ;;
    type: yesno
  }

  dimension: is_assistant_store_manager {
    group_label: "Job Title Flags"
    sql: ${job_title}="Assistant Store Manager" ;;
    type: yesno
  }

  dimension: is_store_supervisor {
    group_label: "Job Title Flags"
    sql: ${job_title}="Store Supervisor" ;;
    type: yesno
  }

  dimension: is_store_assistant {
    group_label: "Job Title Flags"
    sql: ${job_title} IN ("Senior Store Assistant","Store Assistant") ;;
    type: yesno
  }

  dimension: is_apprentice {
    group_label: "Job Title Flags"
    sql: ${job_title} IN ("Store Apprentice","Store Supervisor Apprentice") ;;
    type: yesno
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
    label: "Length of Service"
    sql: concat(cast(${TABLE}.lengthOfServiceYears as string)," Years") ;;
    type: string
  }

  dimension: length_of_service_tier{
    sql: ${length_of_service_years} ;;
    type: tier
    style: integer
    tiers: [0,1,2,5,10]
  }

  measure: number_of_colleagues {
    sql: ${employee_id} ;;
    type: count_distinct
  }

}
