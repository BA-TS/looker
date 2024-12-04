view: product_attributes_pivoted {
  derived_table: {
    sql:
      with base as (
      select productUID,attribute,attributeValue from `toolstation-data-storage.range.productAttributes`)

      select a.productUID,
      a.attributeValue as UN_transport_number,
      b.attributeValue as safety_data_sheet,
      c.attributeValue as hazardous,
      d.attributeValue as hazard_code,
      from base a
      left join base b using(productUID)
      left join base c using(productUID)
      left join base d using(productUID)
      where a.attribute  = "UN transport number"
      and b.attribute  = "Safety Data Sheet"
      and c.attribute  = "Hazardous"
      and d.attribute = "Hazard code"
      ;;
    datagroup_trigger: ts_transactions_datagroup
  }


  dimension: product_uid {
    group_label: "Product Details"
    label: "Product UID"
    primary_key:  yes
    type: string
    sql: ${TABLE}.productUID ;;
    hidden: yes
  }

  dimension: UN_transport_number {
    group_label: "Product Details"
    label: "UN Transport Number"
    type: string
    sql: ${TABLE}.UN_transport_number ;;
  }

  # dimension:safety_data_sheet {
  #   group_label: "Product Details"
  #   type: string
  #   sql: ${TABLE}.safety_data_sheet ;;
  # }

  dimension: safety_data_sheet_raw {
    type: string
    sql: concat("https://",replace(${TABLE}.safety_data_sheet,"https://","")) ;;
    hidden: yes
  }

  dimension: website_label {
    type: string
    sql: replace(replace(replace(${TABLE}.website,"https:",""),"www.",""),"/","") ;;
    hidden: yes
  }

  dimension: safety_data_sheet {
    group_label: "Product Details"
    type: string
    sql: ${safety_data_sheet_raw} ;;
    html: <a href="{{ ${safety_data_sheet_raw}}"target=”_blank”>{{ ${website_label} }}</a> ;;
  }

  dimension: hazardous {
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.hazardous ;;
  }

  dimension: hazard_code{
    group_label: "Product Details"
    type: string
    sql: ${TABLE}.hazard_code ;;
  }

}
