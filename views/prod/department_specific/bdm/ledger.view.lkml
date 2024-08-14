view: ledger {
  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    *
    from
    (
    select
    "BDM" as team,
    *
    from `toolstation-data-storage.retailReporting.BDM_LEDGER_LOOKER`
    union all
    select
    "KA" as team,
    * from
    `toolstation-data-storage.retailReporting.KEY_ACCOUNTS_LEDGER_LOOKER`
    )
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
    type: string
    sql: ${TABLE}.bdm ;;
    hidden: yes
  }

  dimension: team {
    type: string
    sql: ${TABLE}.team ;;
    hidden: yes
  }

  dimension: credit_limit {
    type: number
    sql: ${TABLE}.creditLimit ;;
    value_format_name: gbp_0
  }

  dimension: website_raw {
    type: string
    sql: concat("https://",replace(${TABLE}.website,"https://","")) ;;
    hidden: yes
  }

  dimension: website_label {
    type: string
    sql: replace(replace(replace(${TABLE}.website,"https:",""),"www.",""),"/","") ;;
    hidden: yes
  }

  dimension: website {
    type: string
    sql: ${website_raw} ;;
    html: <a href="{{ website_raw}}"target=”_blank”>{{ website_label }}</a> ;;
  }

  dimension: email_raw {
    type: string
    sql: ${TABLE}.email ;;
    hidden: yes
  }

  dimension: email {
    type: string
    sql: ${email_raw} ;;
    html: <a href="mail:to {{ email_raw}}">{{ email_raw }}</a> ;;
  }

  dimension: address {
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: contact {
    type: string
    sql: ${TABLE}.contact ;;
  }

  dimension: job_title {
    type: string
    sql: ${TABLE}.jobTitle ;;
  }

  dimension: office_number {
    type: string
    sql: ${TABLE}.officeNumber ;;
  }

  dimension: phone_number {
    type: string
    sql: ${TABLE}.phoneNumber ;;
  }

  dimension: account_number {
    type: string
    sql: ${TABLE}.accountNumber ;;
  }

  measure: average_credit_limit {
    type: average
    sql: ${credit_limit} ;;
    value_format_name: gbp_0
  }
}
