# If necessary, uncomment the line below to include explore_source.
include: "/explores/**/sales/single_line_transactions.explore.lkml"
# include: "/views/**/single_line_transactions.view"


view: attached_products_test {
  derived_table: {
    explore_source: single_line_transactions {
      column: product_code { field: products.product_code }
      column: description { field: products.description }
      # column: non_single_line_transactions_total {}
      column: number_of_transactions { field: transactions.number_of_transactions }
      column: product_code_attached { field: attached_products.product_code_attached }
      column: product_description_attached { field: attached_products.product_description_attached }
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
    }
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
    label: "Measures Number of Transactions"
    description: "Number of orders"
    value_format: "#,##0;(#,##0)"
    type: number
  }
  dimension: product_code_attached {
    label: "Transactions Product Code Attached"
    description: ""
  }
  dimension: product_description_attached {
    label: "Transactions Product Description Attached"
    description: ""
  }
}
