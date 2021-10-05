<h1>toolstation_dev <img style="color: #ffffff;float: right;height: 40px;" src="https://www.toolstation.com/img/toolstation.svg"></h1>
This .md file contains documentation for the toolstation_dev Looker repository.

### What is this repository for? ###
This repository will contain all models, dimension/measure definitions, along with any other relevant information for the Looker platform.

# Models Available #

### Transactions
View allows for drilling of BigQuery 'transactions'. Committed joins are listed below.

<b>Core Table:</b> sales.transactions
<b>Join(s):</b> range.products, ts_finance.dim_date, customer.allCustomers, locations.sites, supplier.suppliers

### Stock Intake ###
View allows for drilling of BigQuery 'purchaseOrders'. Committed joins are listed below.

<b>Core Table:</b> stock.purchaseOrders
<b>Join(s):</b> range.products, locations.sites, locations.distributionCentreNames

### How do I get set up? ###
### Contribution guidelines ###
### Who do I talk to? ###

- Mark O'Grady
- Jack Diamond
- Charles Granville
- Iqra Naz
