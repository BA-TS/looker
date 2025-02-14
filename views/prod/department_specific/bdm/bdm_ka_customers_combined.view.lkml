include: "/views/**/transactions.view"

view: bdm_ka_customers_combined {
  derived_table: {
    sql:
       select
        DISTINCT row_number() over () AS prim_key,
        customerUID,
        min(coalesce(startDate,date_sub(current_date,interval 3 year))) as startDate,
        max(coalesce(endDate,current_date)) as endDate,
        from
        `toolstation-data-storage.retailReporting.BDM_KA_CUSTOMERS_LIST`
        where bdm is not null
        group by all
        ;;
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

  dimension: combined_bdm_ka {
    # view_label: "Customers"
    label: "Combined BDM KA Customers"
    type: yesno
    sql: ${customer_uid} is not null ;;
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
