view: digitalreporting_singlelinetransactions {
  derived_table: {
    explore_source: digital_reporting {
      bind_all_filters: yes
      column: OrderID { field: app_web_data.OrderID}
      column: productCode { field: productv2.product_code}
      column: productDept { field: productv2.department}
      derived_column: SLT {
        sql: case when  count(distinct case when productCode >= '10000' and lower(productDept) not in ('uncatalogued') then productCode else null end) over (partition by OrderID) = 1 then "true" else "false" end ;;
      }
    }
  }


dimension: OrderID {
  primary_key: yes
  hidden: yes
  type: string
  sql: concat(${TABLE}.OrderID, ${TABLE}.productCode) ;;
}

  dimension: productCode {
    hidden: yes
    type: string
    sql: ${TABLE}.productCode ;;
  }

  dimension: productDept {
    hidden: yes
    type: string
    sql: ${TABLE}.productDept ;;
  }

  dimension: SLT {
    type: string
    sql: ${TABLE}.SLT ;;
  }
}
