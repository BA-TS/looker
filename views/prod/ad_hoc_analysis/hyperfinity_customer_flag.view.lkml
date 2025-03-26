view: hyperfinity_customer_flag {
  required_access_grants: [can_use_customer_information]

  fields_hidden_by_default: yes

  derived_table: {
    sql:
    select * from `toolstation-data-storage.crm_reporting.zzHYPERFINITYCUSTOMERFLAG_Dan`;;
  }

  dimension: customer_uid {
    type: string
    primary_key: yes
    sql: ${TABLE}.hf_COMBINED_ID ;;
    label: "Customer UID"
    hidden: yes
  }

  dimension: hyperfinity_flag {
    type: yesno
    group_label: "Flags"
    sql: ${customer_uid} is not null;;
  }

}
