view: store_manager {
  derived_table: {
    explore_source: retail {
      bind_all_filters: yes
      column: site_uid { field: sites.site_uid }
      column: name { field: toolstation_google_users.name }
      column: employee_id { field: toolstation_google_users.employee_id }
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
}
