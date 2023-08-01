view: top_10_test {

  derived_table: {
    #parameter value specifies which of the rankings from the inner table to use
    explore_source: base {
      bind_all_filters: yes
      column: Cluster { field: customer_segmentation.cluster }
      column: Net_sales { field: transactions.total_net_sales }
      derived_column: ranking {
        sql: rank() over (order by Net_sales desc) ;;
      }
    }
  }

  dimension: Cluster {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.Cluster ;;
  }

  dimension: cluster_rank {
    hidden: yes
    type: string
    sql: ${TABLE}.ranking ;;
  }

#### This parameter will allow a user to select a Top N ranking limit for bucketing the brands, almost like parameterizing the Row Limit in the UI
  parameter: top_rank_limit {
    view_label: " TOTT | Top N Ranking"
    type: unquoted
    default_value: "5"
    allowed_value: {
      label: "Top 5"
      value: "5"
    }
    allowed_value: {
      label: "Top 10"
      value: "10"
    }
    allowed_value: {
      label: "Top 20"
      value: "20"
    }
    allowed_value: {
      label: "Top 50"
      value: "50"
    }
  }

  dimension: brand_rank_top_brands_bigquery {
    #hidden: yes
    label_from_parameter: top_rank_limit
    type: string
    sql:
      CASE
        WHEN ${cluster_rank}<={% parameter top_rank_limit %}
          THEN
            CASE
              WHEN ${cluster_rank}<10 THEN  CONCAT('0', CAST(${cluster_rank} AS STRING))
              ELSE CAST(${cluster_rank} AS STRING)
            END
        ELSE 'Other'
      END
    ;;
  }

}
