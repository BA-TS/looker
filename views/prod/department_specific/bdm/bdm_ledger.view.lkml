view: bdm_ledger {
  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    *
    from `toolstation-data-storage.retailReporting.BDM_LEDGER_LOOKER`
    where bdm is not null
    ;;

    datagroup_trigger: ts_daily_datagroup
  }

  dimension: prim_key {
    type: string
    sql: ${TABLE}.prim_key ;;
    primary_key: yes
    hidden: yes
  }

  dimension: customer_uid {
    type: string
    sql: ${TABLE}.customerUID ;;
    hidden: yes
  }

  dimension: bdm {
    label: "BDM"
    group_label: "BDM"
    type: string
    sql: ${TABLE}.bdm ;;
    hidden: yes
  }

  dimension: credit_limit {
    group_label: "BDM"
    type: number
    sql: ${TABLE}.creditLimit ;;
  }

  dimension: website_raw {
    group_label: "BDM"
    type: string
    sql: concat("https://",replace(${TABLE}.website,"https://","")) ;;
    hidden: yes
  }

  dimension: website_label {
    group_label: "BDM"
    type: string
    sql: replace(replace(replace(${TABLE}.website,"https:",""),"www.",""),"/","") ;;
    hidden: yes
  }

  dimension: website {
    group_label: "BDM"
    type: string
    sql: ${website_raw} ;;
    html: <a href="{{ website_raw}}">{{ website_label }}</a> ;;
  }

  dimension: email {
    group_label: "BDM"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: address {
    group_label: "BDM"
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: notes {
    group_label: "BDM"
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: contact {
    group_label: "BDM"
    type: string
    sql: ${TABLE}.contact ;;
  }

  dimension: job_title {
    group_label: "BDM"
    type: string
    sql: ${TABLE}.jobTitle ;;
  }

  dimension: office_number {
    group_label: "BDM"
    type: string
    sql: ${TABLE}.officeNumber ;;
  }

  dimension: phone_number {
    group_label: "BDM"
    type: string
    sql: ${TABLE}.phoneNumber ;;
  }

  dimension: account_number {
    group_label: "BDM"
    type: string
    sql: ${TABLE}.accountNumber ;;
  }
 }
