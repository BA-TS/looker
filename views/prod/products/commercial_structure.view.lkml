view: commercial_structure {

  derived_table: {
    sql:
      WITH
      matt_rockliff AS
      (
          SELECT
              10 AS department_id,'Hand Tools' AS department_name_raw, 'Hand Tools' AS department_name,'Sarah Gale' AS buyer_name,'Matt Rockliff' AS buying_manager, '' AS classification
          UNION ALL(SELECT 40,'Power Tools','Power Tools','Seb Falkiner','Matt Rockliff', '')
          UNION ALL(SELECT 60,'Automotive','Automotive','Lucy Trevelynn','Matt Rockliff', '')
          UNION ALL(SELECT 80,'Power Tool Accessories','Power Tool Accessories','Jack Antell','Matt Rockliff', '')
          UNION ALL(SELECT 90,'Screws & Fixings','Screws & Fixings','Jack Antell','Matt Rockliff', '')
          UNION ALL(SELECT 110,'Ladders & Storage','Ladders & Storage','Will Farrell','Matt Rockliff', '')
          UNION ALL(SELECT 130,'Landscaping','Landscaping','Matt Kent','Matt Rockliff', '')
          UNION ALL(SELECT 170,'Ironmongery & Security','Ironmongery & Security','Beth Priestley','Matt Rockliff', '')
          UNION ALL(SELECT 180,'Adhesives & Sealants','Adhesives & Sealants','Monica Cleere','Matt Rockliff', '')
          UNION ALL(SELECT 210,'Building & Joinery','Building & Joinery','Monica Cleere','Matt Rockliff', '')
          UNION ALL(SELECT 260,'Cleaning & Pest Control','Cleaning & Pest Control','Matt Kent','Matt Rockliff', '')
      ),
      dave_taylor AS
      (
          SELECT
              20,'Plumbing','Plumbing','Danielle Robinson','Dave Taylor',''
          UNION ALL(SELECT 70,'Workwear & Safety','Workwear & Safety','Hannah Phillips','Dave Taylor','')
          UNION ALL(SELECT 150,'Painting & Decorating','Painting & Decorating','Neil Hannaford','Dave Taylor','')
          UNION ALL(SELECT 190,'Electrical','Electrical','Colin Freeland','Dave Taylor','')
          UNION ALL(SELECT 220,'Lighting','Lighting','Russel Brittain','Dave Taylor','')
          UNION ALL(SELECT 230,'Central Heating','Central Heating','Danielle Robinson','Dave Taylor','')
          UNION ALL(SELECT 270,'Bathrooms','Bathrooms','Cara Yates','Dave Taylor','')
          UNION ALL(SELECT 280,'Kitchens','Kitchens','Cara Yates','Dave Taylor','')
          UNION ALL(SELECT 290,'Ventilation & Heating','Ventilation & Heating','Simon Oram','Dave Taylor','')
          UNION ALL(SELECT 300,'Smart Technology & Consumer Electrical','Smart Technology & Consumer Electrical','Simon Oram','Dave Taylor','')
      ),
      unallocated AS
      (
          SELECT
              1,'Uncatalogued','Uncatalogued','Unallocated','Unallocated',''
          UNION ALL(SELECT 2,'Deleted','Deleted','Unallocated','Unallocated','')
          UNION ALL(SELECT 50,'Clearance','Clearance','Unallocated','Unallocated','')
          UNION ALL(SELECT 900001,'Marketing Vouchers','Marketing Vouchers','Unallocated','Unallocated','')
      )

      SELECT
          *
      FROM
          matt_rockliff
      UNION ALL(SELECT * FROM dave_taylor)
      UNION ALL(SELECT * FROM unallocated);;
  datagroup_trigger: ts_range_datagroup
  }

  dimension: buyer {
    view_label: "Commercial"
    label: "Buyer"
    type: string
    sql: ${TABLE}.buyer ;;
  }

  dimension: buying_manager {
    view_label: "Commercial"
    label: "Buying Manager"
    type: string
    sql: ${TABLE}.buyingManager ;;
  }

  dimension: classification {
    view_label: "Commercial"
    label: "Classification"
    type: string
    sql: ${TABLE}.classification ;;
  }

  dimension: product_department {
    type: string
    sql: ${TABLE}.productDepartment ;;
    hidden: yes
  }

  dimension: product_department_uid {
    type: number
    value_format_name: id
    sql: ${TABLE}.productDepartmentUID ;;
    hidden: yes
  }
}
