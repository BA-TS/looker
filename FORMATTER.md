<h1>Formatter <img style="color: #ffffff;float: right;height: 40px;" src="https://www.toolstation.com/img/toolstation.svg"></h1>
This .md file contains formatting strings for the toolstation_dev Looker repository.

# Formats Available #

### Positive £ with 'M' / 'K' / ''

With decimals:
```sh
[>=1000000] [$£-en-GB] #,##0.00,, "M"; [>=1000] [$£-en-GB] #,##0.00, "K"; [$£-en-GB] #,##0.00
```

Without decimals:
```sh
[>=1000000] [$£-en-GB] #,##0,, "M"; [>=1000] [$£-en-GB] #,##0, "K"; [$£-en-GB] #,##0
```

### Negative £ with 'M' / 'K' / ''

With decimals:
```sh
[<=-1000000] [$£-en-GB] #,##0.00,, "M"; [<=-1000] [$£-en-GB] #,##0.00, "K";[$£-en-GB] #,##0.00
```

Without decimals:
```sh
[<=-1000000] [$£-en-GB] #,##0,, "M"; [<=-1000] [$£-en-GB] #,##0, "K";[$£-en-GB] #,##0
```

### Positive/Negative £ with 'M' / 'K' / ''

NOTE: there is an issue currently with using this as it appears unable to do 'all' of the options (i.e. one must be excluded for it work) -- examples below will <b><u>NOT</u></b> show positive M (e.g. 2.5M) but will instead show positive K (e.g. 2,500K)

With decimals:
```sh
[>=1000000] [$£-en-GB] #,##0.00,, "M"; [>=1000] [$£-en-GB] #,##0.00, "K"; [<-1000000] [$£-en-GB] #,##0.00,, "M"; [<-1000] [$£-en-GB] #,##0.00, "K"; [$£-en-GB] #,##0.00
```

Without decimals:
```sh
[>=1000000] [$£-en-GB] #,##0,, "M"; [>=1000] [$£-en-GB] #,##0, "K"; [<-1000000] [$£-en-GB] #,##0,, "M"; [<-1000] [$£-en-GB] #,##0, "K"; [$£-en-GB] #,##0
```

### Who do I talk to? ###

- Charles Granville
