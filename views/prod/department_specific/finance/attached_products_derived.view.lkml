include: "/explores/**/sales/single_line_transactions.explore.lkml"
# include: "/views/**/single_line_transactions.view"


view: attached_products_derived {
  derived_table: {
    explore_source: single_line_transactions {
      column: product_code { field: products.product_code }
      column: description { field: products.description }
      # column: non_single_line_transactions_total {}
      column: number_of_transactions { field: transactions.number_of_transactions }
      column: filter_match  { field: attached_products.filter_match  }
      column: attached_count  { field: attached_products.attached_count  }

      column: product_code_attached { field: attached_products.product_code_attached }
      column: product_description_attached { field: attached_products.product_description_attached }
      derived_column: attached_product_rank {
        sql: RANK () OVER (PARTITION BY product_code ORDER BY number_of_transactions DESC) ;;
      }

     filters: {
        field: base.select_date_type
        value: "Calendar"
      }
      filters: {
        field: base.select_date_reference
        value: "Transaction"
      }
      filters: {
        field: base.select_date_range
        value: "30 days"
      }
      filters: {
        field: products.product_code
        value: "69989,66027,90885,36950,91728,15960,42670,10938,73380,94239,74331,54341,49846,17219"
      }
      filters: {
        field: attached_products.product_code_attached
        value: "-0%"
      }
      filters: {
        field: attached_products.filter_match
        value: "No"
      }
    }
  }
  dimension: attached_product_rank {
    type: number
  }

  dimension: product_code {
    description: ""
  }
  dimension: description {
    description: ""
  }
  # dimension: non_single_line_transactions_total {
  #   label: "Transactions Non Single Line Transactions Total"
  #   description: ""
  #   type: number
  # }
  dimension: number_of_transactions {
    label: "Number of Transactions"
    description: "Number of orders"
    value_format: "#,##0;(#,##0)"
    type: number
  }
  dimension: product_code_attached {
    label: "Product Code Attached"
    description: ""
  }
  dimension: product_description_attached {
    description: ""
  }
  dimension: filter_match {
    description: ""
  }
  dimension: attached_count  {
    description: ""
  }
}
