view: availability_branch_ytd_py {

  derived_table: {
    sql:
    SELECT
    siteUID, round(sum(instock)/(sum(instock)+sum(outOfStock)),2) as availability_dim
    FROM `toolstation-data-storage.availability_new.BranchDepartmentAvailabilityHistory`
    where date < date_sub(current_date, interval 1 month) and (extract (year from date) = extract (year from current_date)-1)
--Currently YTD is current month - 2 not current month - 1
    group by all
    ;;
  }

  dimension: site_uid {
    type: string
    sql: ${TABLE}.siteUID ;;
    hidden: yes
    primary_key: yes
  }

  dimension: availability_dim {
    label: "Branch Availability YTD PY"
    type: number
    sql: ${TABLE}.availability_dim ;;
    hidden: yes
  }

  measure: availability {
    label: "Availability YTD PY"
    type: average
    sql: ${availability_dim} ;;
  }
}
