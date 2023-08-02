view: top_clusters_net_sales {

  derived_table: {
    #parameter value specifies which of the rankings from the inner table to use
    explore_source: base {
      bind_all_filters: yes
      column: Cluster { field: customer_segmentation.cluster }
      column: Net_sales { field: transactions.total_net_sales }
      column: Number_customers { field: customers.number_of_customers }
      derived_column: ranking {
        sql: rank() over (order by Net_sales desc) ;;
      }
      derived_column: ranking_2 {
        sql: rank() over (order by Number_customers desc) ;;
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

  dimension: customer_rank {
    hidden: yes
    type: string
    sql: ${TABLE}.ranking_2 ;;
  }
#### This parameter will allow a user to select a Top N ranking limit for bucketing the brands, almost like parameterizing the Row Limit in the UI
#### Customer Segments for top sales ###########
  parameter: top_rank_limit {
    label: "Top Sales - Customer Segment N Filter"
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
    hidden: yes
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
        ELSE "Other"
      END
    ;;
  }

#### Top customer Segments for number of customers ##########


  parameter: top_rank_limit_2 {
    label: "Top Customers - Customer Segment N Filter"
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

  dimension: brand_rank_top_brands_bigquery_2 {
    hidden: yes
    label_from_parameter: top_rank_limit_2
    type: string
    sql:
      CASE
        WHEN ${customer_rank}<={% parameter top_rank_limit_2 %}
          THEN
            CASE
              WHEN ${customer_rank}<10 THEN  CONCAT('0', CAST(${customer_rank} AS STRING))
              ELSE CAST(${customer_rank} AS STRING)
            END
        ELSE "Other"
      END
    ;;
  }

}
