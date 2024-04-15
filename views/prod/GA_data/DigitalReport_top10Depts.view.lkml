view: digitalreport_top10depts {

    derived_table: {
      #parameter value specifies which of the rankings from the inner table to use
      explore_source: digital_reporting {
        bind_all_filters: yes
        column: Product_department { field: productv2.department}
        column: Net_sales { field: app_web_data.Totalrevenue }
        derived_column: ranking {
          sql: rank() over (order by Net_sales desc) ;;
        }
      }
    }

    dimension: Department {
      primary_key: yes
      hidden: yes
      type: string
      sql: ${TABLE}.Product_department ;;
    }

    dimension: sales_rank {
      hidden: yes
      type: string
      sql: ${TABLE}.ranking ;;
    }

#### This parameter will allow a user to select a Top N ranking limit for bucketing the brands, almost like parameterizing the Row Limit in the UI

#### Top customer Segments for number of customers ##########


    parameter: top_rank_limit_4 {
      label: "Top N Department by Sales"
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

    dimension: dept_rank_top_dept_bigquery_4 {
      hidden: yes
      label_from_parameter: top_rank_limit_4
      type: string
      sql:
      CASE
        WHEN ${sales_rank}<={% parameter top_rank_limit_4 %}
          THEN
            CASE
              WHEN ${sales_rank}<10 THEN  CONCAT('0', CAST(${sales_rank} AS STRING))
              ELSE CAST(${sales_rank} AS STRING)
            END
        ELSE "Other"
      END
    ;;
    }

  }
