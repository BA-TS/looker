view: store_manager {
  derived_table: {
    explore_source: retail {
      bind_all_filters: yes
      column: site_uid { field: sites.site_uid }
      column: name { field: toolstation_google_users.name }
      column: employee_id { field: toolstation_google_users.employee_id }
      column: length_of_service_years { field: toolstation_google_users.length_of_service_years }
      filters: {
        field: toolstation_google_users.job_title
        value: "Store Manager"
      }
    }
  }

  dimension: site_uid {
    description: ""
    hidden: yes
    sql: ${TABLE}.site_uid ;;
    type: string
  }

  dimension: store_manager_name {
    sql: ${TABLE}.name;;
    type: string
  }

  dimension: employee_id {
    sql: ${TABLE}.employee_id ;;
    type: string
    hidden: yes
  }

  dimension: store_manager_length_of_service {
    sql: ${TABLE}.length_of_service_years ;;
    type: number
    label: "Length of Service (Store Manager)"

  }
}
