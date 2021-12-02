<table style="undefined;table-layout: fixed; width: 1141px">
<colgroup>
<col style="width: 227.88889px">
<col style="width: 218.88889px">
<col style="width: 87.88889px">
<col style="width: 97.88889px">
<col style="width: 83.88889px">
<col style="width: 328.88889px">
<col style="width: 95.88889px">
</colgroup>
<thead>
  <tr>
    <th>Measures</th>
    <th>LookerID</th>
    <th>LookerView</th>
    <th>LookerGroup</th>
    <th>Description</th>
    <th>Calculation</th>
    <th>Explore(s)</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Gross Sales</td>
    <td>total_gross_sales</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>sum(grossSalesValue)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Net Sales</td>
    <td>total_net_sales</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>sum(netSalesValue)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>COGS</td>
    <td>total_cogs</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>sum(COGS)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Unit Funding</td>
    <td>total_unit_funding</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>sum(unitFunding)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Margin (Excluding Funding)</td>
    <td>total_margin_excl_funding</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>sum(marginExclFunding)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Margin (Including Funding)</td>
    <td>total_margin_incl_funding</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>sum(marginInclFunding)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Margin Rate (Excluding Funding)</td>
    <td>total_margin_rate_excl_funding</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>safe_divide(total_margin_excl_funding, total_net_sales)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Margin Rate (Including Funding)</td>
    <td>total_margin_rate_incl_funding</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>safe_divide(total_margin_incl_funding, total_net_sales)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Units</td>
    <td>total_units</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>sum(case when product_code like '0%' then 0 else quantity end)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Units (System Codes)</td>
    <td>total_units_incl_system_codes</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>sum(quantity)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Number of Transactions</td>
    <td>number_of_transactions</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>count_distinct(parent_order_uid)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Number of Customers</td>
    <td>number_of_unique_customers</td>
    <td>Measures</td>
    <td>Core</td>
    <td></td>
    <td>count_distinct(customer_uid)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Gross Sales AOV</td>
    <td>aov_gross_sales</td>
    <td>Measures</td>
    <td>AOV</td>
    <td></td>
    <td>safe_divide(total_gross_sales, number_of_transactions)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Net Sales AOV</td>
    <td>aov_net_sales</td>
    <td>Measures</td>
    <td>AOV</td>
    <td></td>
    <td>safe_divide(total_net_sales, number_of_transactions)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Margin (Excluding Funding) AOV</td>
    <td>aov_margin_excl_funding</td>
    <td>Measures</td>
    <td>AOV</td>
    <td></td>
    <td>safe_divide(total_margin_excl_funding, number_of_transactions)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Margin (Including Funding) AOV</td>
    <td>aov_margin_incl_funding</td>
    <td>Measures</td>
    <td>AOV</td>
    <td></td>
    <td>safe_divide(total_margin_incl_funding, number_of_transactions)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Units AOV</td>
    <td>aov_units</td>
    <td>Measures</td>
    <td>AOV</td>
    <td></td>
    <td>safe_divide(total_units, number_of_transactions)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Units (System Codes) AOV</td>
    <td>aov_units_incl_system_codes</td>
    <td>Measures</td>
    <td>AOV</td>
    <td></td>
    <td>safe_divide(total_units_incl_system_codes, number_of_transactions)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Price AOV</td>
    <td>aov_price</td>
    <td>Measures</td>
    <td>AOV</td>
    <td></td>
    <td>safe_divide(aov_net_sales, aov_units)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Gross Sales (LFL)</td>
    <td>lfl_gross_sales</td>
    <td>Measures</td>
    <td>LFL</td>
    <td></td>
    <td>sum(case when is_lfl then gross_sales_value else 0 end)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Net Sales (LFL)</td>
    <td>lfl_net_sales</td>
    <td>Measures</td>
    <td>LFL</td>
    <td></td>
    <td>sum(case when is_lfl then net_sales_value else 0 end)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Margin (Excluding Funding) (LFL)</td>
    <td>lfl_margin_excl_funding</td>
    <td>Measures</td>
    <td>LFL</td>
    <td></td>
    <td>sum(case when is_lfl then margin_excl_funding else 0 end)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Margin (Including Funding) (LFL)</td>
    <td>lfl_margin_incl_funding</td>
    <td>Measures</td>
    <td>LFL</td>
    <td></td>
    <td>sum(case when is_lfl then margin_incl_funding else 0 end)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Margin Rate (Excluding Funding) (LFL)</td>
    <td>lfl_total_margin_rate_excl_funding</td>
    <td>Measures</td>
    <td>LFL</td>
    <td></td>
    <td>safe_divide(lfl_total_margin_excl_funding, lfl_total_net_sales)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Margin Rate (Including Funding) (LFL)</td>
    <td>lfl_total_margin_rate_incl_funding</td>
    <td>Measures</td>
    <td>LFL</td>
    <td></td>
    <td>safe_divide(lfl_total_margin_incl_funding, lfl_total_net_sales)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Number of Customers (LFL)</td>
    <td>lfl_number_of_customers</td>
    <td>Measures</td>
    <td>LFL</td>
    <td></td>
    <td>sum(case when is_lfl then customer_uid else 0 end)</td>
    <td>Transactions</td>
  </tr>
  <tr>
    <td>Units (LFL)</td>
    <td>lfl_number_of_units</td>
    <td>Measures</td>
    <td>LFL</td>
    <td></td>
    <td>sum(case when is_lfl and product_code not like '0%' then quantity else 0 end)</td>
    <td>Transactions</td>
  </tr>
</tbody>
</table>
