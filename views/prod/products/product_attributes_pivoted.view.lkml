view: product_attributes_pivoted {
  derived_table: {
    sql:
      with base as (
      select productUID,attribute,attributeValue from `toolstation-data-storage.range.productAttributes`)

      select a0.productUID as productUID,
      a.attributeValue as UN_transport_number,
      b.attributeValue as safety_data_sheet,
      c.attributeValue as hazardous,
      d.attributeValue as hazard_code,
      from base a0
      left join base a using(productUID)
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
    label: "Product UID TEST"
    primary_key:  yes
    type: string
    sql: ${TABLE}.productUID ;;
    # hidden: yes
    required_access_grants: [lz_only]
  }

  dimension: UN_transport_number {
    label: "UN Transport Number"
    type: string
    sql: ${TABLE}.UN_transport_number ;;
  }

  dimension:safety_data_sheet {
    type: string
    sql: ${TABLE}.safety_data_sheet ;;
  }

  # dimension: safety_data_sheet_raw {
  #   type: string
  #   sql: concat("https://",replace(${TABLE}.safety_data_sheet,"https://","")) ;;
  #   hidden: yes
  # }

  # dimension: website_label {
  #   type: string
  #   sql: replace(replace(replace(${TABLE}.website,"https:",""),"www.",""),"/","") ;;
  #   hidden: yes
  # }

  # dimension: safety_data_sheet {
  #   type: string
  #   sql: ${safety_data_sheet_raw} ;;
  #   html: <a href="{{safety_data_sheet_raw}}"target=”_blank”>{{ website_label }}</a>;;
  # }

  dimension: hazardous {
    type: string
    sql: ${TABLE}.hazardous ;;
  }

  dimension: hazard_code{
    type: string
    sql: ${TABLE}.hazard_code ;;
  }

}
