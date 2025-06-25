# include: "retail.explore.lkml"

view: branch_performance_rank {
  derived_table: {
    explore_source: retail {
      bind_all_filters: yes
      column: site_uid { field: sites.site_uid }
      column: var_PY_Sales_Percent { field: scorecard_branch_dev_ytd25.var_PY_Sales_Percent }
      derived_column:var_PY_Sales_Percent_rank  {
        sql: rank() over (order by var_PY_Sales_Percent desc) ;;
      }
    }
  }

  dimension: site_uid {
    hidden: yes
    sql: ${TABLE}.site_uid ;;
  }

  dimension: var_PY_Sales_Percent {
    type: number
    hidden: yes
    sql: ${TABLE}.var_PY_Sales_Percent  ;;
  }

  dimension: var_PY_Sales_Percent_rank {
    type: number
    sql: ${TABLE}.var_PY_Sales_Percent_rank ;;
  }

}
