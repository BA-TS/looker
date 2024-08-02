view: branch_department_availability {

derived_table: {
  sql:
    select distinct *, row_number() over () as primary_key from
    `toolstation-data-storage.availability_new.BranchDepartmentAvailability` ;;
    datagroup_trigger: ts_daily_datagroup
}

  dimension: primary_key {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.primary_key  ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.productDepartment ;;
  }

  dimension_group: availability {
    type: time
    datatype: date
    sql: ${TABLE}.date;;
    timeframes: [raw,date]
  }

  dimension: in_stock {
    type: number
    sql: ${TABLE}.inStock ;;
    hidden: yes
  }

  dimension: out_of_stock {
    type: number
    sql: ${TABLE}.outOfStock ;;
    hidden: yes
  }

  measure: total_in_stock {
    label: "In Stock"
    type: sum
    sql: ${in_stock} ;;
  }

  measure: total_out_of_stock {
    label: "Out of Stock"
    type: sum
    sql: ${out_of_stock} ;;
  }

}
