include: "/views/**/transactions.view"

view: bdm_ka_customers2 {
  derived_table: {
    sql:
       select
        DISTINCT row_number() over () AS prim_key,
        team,
        replace(replace(trim(bdm),"Craig","London"),"London","Damien") as bdm,
        customerUID,
        min(coalesce(startDate,date_sub(current_date,interval 3 year))) as startDate,
        max(coalesce(endDate,current_date)) as endDate,
        customerName
        from
        `toolstation-data-storage.retailReporting.BDM_KA_CUSTOMERS_LIST`
        where bdm is not null
        group by all
        ;;
    datagroup_trigger: ts_daily_datagroup
  }

  dimension: prim_key {
    type: string
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: customer_uid {
    # view_label: "Customers"
    label: "Customer UID"
    type: string
    sql: ${TABLE}.customerUID ;;
  }

  dimension: team {
    label: "Team (BDM or KA)"
    type: string
    sql: ${TABLE}.team ;;
  }

  dimension: bdm {
    label: "Name"
    type: string
    sql: ${TABLE}.bdm ;;
  }

  dimension_group: start {
    # view_label: "Customers"
    group_label: "Start and End Dates"
    type: time
    datatype: date
    sql: ${TABLE}.startDate ;;
    timeframes: [
      date,
      month,
      year
    ]
  }

  dimension_group: end {
    # view_label: "Customers"
    group_label: "Start and End Dates"
    type: time
    datatype: date
    sql: ${TABLE}.endDate;;
    timeframes: [
      date,
      month,
      year
    ]
  }

}
