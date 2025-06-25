view: fasttrack_orderflag {
  derived_table: {
    sql: select * from
    `toolstation-data-storage.ts_staging.fastTrack_orderflag`
    ;;
  }

  dimension: parent_order_uid {
    sql: ${TABLE}.order_id ;;
    type: string
    hidden: yes
  }

  dimension: fast_track_order {
    group_label: "Flags"
    sql: ${parent_order_uid} is not null;;
    type: yesno
  }
}
