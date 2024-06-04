view: ecrebobudget {
  derived_table: {
     sql: SELECT distinct row_number() over() as PK, * from (SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Trade 5% Discount" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(Trade_5__Discount, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1,Trade_5__Discount) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
-- SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Multibuy Total" as CampaignGroup
-- from (
-- SELECT distinct be.FiscalYearWeek as FYW,
-- round(safe_divide(Multibuy_Total, count(distinct dd.fullDate)),2) as daily_budget
-- FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
-- inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
-- group by 1, Multibuy_Total) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
-- Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Leyland" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(Leyland, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Leyland) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Screed" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(Screed, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Screed) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
-- Union Distinct
-- SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Garden Paint" as CampaignGroup
-- from (
-- SELECT distinct be.FiscalYearWeek as FYW, Garden_Paint,
-- round(safe_divide(Garden_Paint, count(distinct dd.fullDate)),2) as daily_budget
-- FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
-- inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
-- group by 1,2) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
-- Union Distinct
-- SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Multibuy" as CampaignGroup
-- from (
-- SELECT distinct be.FiscalYearWeek as FYW,
-- round(safe_divide(cast(Multibuy as int64), count(distinct dd.fullDate)),2) as daily_budget
-- FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
-- inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
-- group by 1,Multibuy) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Multibuy" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(Other__Multibuy_, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Other__Multibuy_) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Free Product Offers" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(Free_product_offers_, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Free_product_offers_) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Vouchers in store" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(Vouchers_in_store, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Vouchers_in_store) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Vouchers on app" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(cast(Vouchers_on_app as int64), count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Vouchers_on_app) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "App download discount" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(App_download_discount, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, App_download_discount) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Managed services" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(Managed_services, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Managed_services) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Staff Discount" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(Staff_Discount, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Staff_Discount) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "BLC Discount" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(BLC_Discount, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, BLC_Discount) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "CRM" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(cast(CRM as int64), count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, CRM) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "CRM - Loyalty" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(cast(CRM___Loyalty as int64), count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, CRM___Loyalty) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Other" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(cast(Other as int64), count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Other) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Affiliates" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(Affiliates, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Affiliates) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Balance" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(Balance, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Balance) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek
Union Distinct
SELECT distinct do.fiscalYearWeek, do.fullDate,daily_budget, "Total" as CampaignGroup
from (
SELECT distinct be.FiscalYearWeek as FYW,
round(safe_divide(Total, count(distinct dd.fullDate)),2) as daily_budget
FROM `toolstation-data-storage.ecrebo.2024_budget_ecrebo` as be
inner join `toolstation-data-storage.ts_finance.dim_date` as dd on be.FiscalYearWeek = dd.fiscalYearWeek
group by 1, Total) inner join `toolstation-data-storage.ts_finance.dim_date` as do on FYW = do.fiscalYearWeek)
       ;;

      sql_trigger_value: SELECT EXTRACT(DAYOFYEAR FROM CURRENT_DATE()) = 1 ;;
   }
#
#   # Define your dimensions and measures here, like this:
   dimension: PK {
    description: "PK"
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.PK ;;
   }
#
  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: ${TABLE}.fullDate ;;
  }
#
   measure: Budget {
    description: "Budget of each campaign"
    type: sum
    sql: ${TABLE}.daily_budget ;;
    value_format_name: gbp
   }

  dimension: campaign_group {
    description: "Campaign Group"
    type: string
    sql: ${TABLE}.CampaignGroup ;;
  }
 }
