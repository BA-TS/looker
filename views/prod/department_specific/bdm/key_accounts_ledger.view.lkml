view: key_accounts_ledger {
  derived_table: {
    sql:
    select
    DISTINCT row_number() over () AS prim_key,
    *
    from `toolstation-data-storage.retailReporting.KEY_ACCOUNTS_LEDGER_LOOKER`
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
    group_label: "KA"
    type: string
    sql: ${TABLE}.bdm ;;
    hidden: yes
  }

  dimension: credit_limit {
    group_label: "KA"
    type: number
    sql: ${TABLE}.creditLimit ;;
  }

  dimension: website {
    group_label: "KA"
    type: string
    sql: ${TABLE}.website ;;
  }

  dimension: email {
    group_label: "KA"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: address {
    group_label: "KA"
    type: string
    sql: ${TABLE}.address ;;
  }

  dimension: notes {
    group_label: "KA"
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: contact {
    group_label: "KA"
    type: string
    sql: ${TABLE}.contact ;;
  }

  dimension: job_title {
    group_label: "KA"
    type: string
    sql: ${TABLE}.jobTitle ;;
  }

  dimension: office_number {
    group_label: "KA"
    type: string
    sql: ${TABLE}.officeNumber ;;
  }

  dimension: phone_number {
    group_label: "KA"
    type: string
    sql: ${TABLE}.phoneNumber ;;
  }

  dimension: account_number {
    group_label: "KA"
    type: string
    sql: ${TABLE}.accountNumber ;;
  }
}
