<h1>Formatter <img style="color: #ffffff;float: right;height: 40px;" src="https://www.toolstation.com/img/toolstation.svg"></h1>
This .md file contains formatting strings for the toolstation_dev Looker repository.

# Formats Available #

<table>
  <tbody><tr><th>Format</th><th>Result</th></tr>
    <tr><td><code>0</code></td><td>Integer (123)</td></tr>
    <tr><td><code>00#</code></td><td>Integer zero-padded to 3 places (001)</td></tr>
    <tr><td><code>0 "String"</code></td><td>Integer followed by a string (123 String)<br>("String" can be replaced with any text string)</td></tr>
    <tr><td><code>0.##</code></td><td>Number up to 2 decimals (1. or 1.2 or 1.23)</td></tr>
    <tr><td><code>0.00</code></td><td>Number with exactly 2 decimals (1.23)</td></tr>
    <tr><td><code>00#.00</code></td><td>Number zero-padded to 3 places and exactly 2 decimals (001.23)</td></tr>
    <tr><td><code>#,##0</code></td><td>Number with comma between thousands (1,234)</td></tr>
    <tr><td><code>#,##0.00</code></td><td>Number with comma between thousands and 2 decimals (1,234.00)</td></tr>
    <tr><td><code>0.000,, "M"</code></td><td>Number in millions with 3 decimals (1.234 M)<br>Division by 1 million happens automatically</td></tr>
    <tr><td><code>0.000, "K"</code></td><td>Number in thousands with 3 decimals (1.234 K)<br>Division by 1 thousand happens automatically</td></tr>
    <tr><td><code>$0</code></td><td>Dollars with 0 decimals ($123)</td></tr>
    <tr><td><code>$0.00</code></td><td>Dollars with 2 decimals ($123.00)</td></tr>
    <tr><td><code>"€"0</code></td><td>Euros with 0 decimals (€123)</td></tr>
    <tr><td><code>$#,##0.00</code></td><td>Dollars with comma between thousands and 2 decimals ($1,234.00)</td></tr>
    <tr><td><code>$#.00;($#.00)</code></td><td>Dollars with 2 decimals, positive values displayed normally, negative values wrapped in parenthesis</td></tr>
    <tr><td><code>0\%</code></td><td>Display as percent with 0 decimals (1 becomes 1%)</td></tr>
    <tr><td><code>0.00\%</code></td><td>Display as percent with 2 decimals (1 becomes 1.00%)</td></tr>
    <tr><td><code>0%</code></td><td>Convert to percent with 0 decimals (.01 becomes 1%)</td></tr>
    <tr><td><code>0.00%</code></td><td>Convert to percent with 2 decimals (.01 becomes 1.00%)</td></tr>
</tbody></table>

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
