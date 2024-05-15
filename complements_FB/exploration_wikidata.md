


```SQL
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
SELECT ?p ?propLabel ?eff #('   ' as ?notes)
WHERE {
{
  select ?p  (count(*) as ?eff)
  where {
      ?item ?p wd:Q49776
  }
  GROUP BY ?p 
}
?prop wikibase:directClaim ?p .

SERVICE wikibase:label { bd:serviceParam wikibase:language "en". } 


}  
ORDER BY DESC(?eff)
```


| p         |           propLabel      | eff |
| --------- | ------------------------ | --- |
| wdt:P31   | instance of              | 631 |
| wdt:P921  | main subject             | 59  |
| wdt:P279  | subclass of              | 29  |
| wdt:P5137 | item for this sense      | 22  |
| wdt:P180  | depicts                  | 10  |
| wdt:P971  | category combines topics | 10  |
| wdt:P793  | significant event        | 9   |



```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
SELECT ?item ?itemLabel
  WHERE {
      ?item wdt:P279 wd:Q49776

SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }    
    
    }
```





```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
SELECT ?item ?itemLabel
  WHERE {
      wd:Q49776 wdt:P279 ?item
SERVICE wikibase:label { bd:serviceParam wikibase:language "en". }

    }
```


|  URI      |     label |
| ---------- | ----------------- |
| wd:Q273120 | protest           |
| wd:Q628191 | industrial action |



```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
SELECT ?p ?propLabel ?eff #('   ' as ?notes)
WHERE {
{
  select ?p  (count(*) as ?eff)
  where {
      ?item wdt:P31 wd:Q273120;
           ?p ?o
  }
  GROUP BY ?p 
}
?prop wikibase:directClaim ?p .

SERVICE wikibase:label { bd:serviceParam wikibase:language "en". } 


}  
ORDER BY DESC(?eff)
```

| p         |   propLabel                                      |  eff |
| --------- | ------------------------------------------------ | ---- |
| wdt:P31   | instance of                                      | 1558 |
| wdt:P17   | country                                          | 709  |
| wdt:P276  | location                                         | 560  |
| wdt:P585  | point in time                                    | 543  |
| wdt:P373  | Commons category                                 | 535  |
| wdt:P18   | image                                            | 457  |
| wdt:P2671 | Google Knowledge Graph ID                        | 409  |
| wdt:P646  | Freebase ID                                      | 370  |
| wdt:P580  | start time                                       | 225  |
| wdt:P361  | part of                                          | 205  |
| wdt:P131  | located in the administrative territorial entity | 178  |
| wdt:P625  | coordinate location                              | 144  |
| wdt:P710  | participant                                      | 135  |
| wdt:P582  | end time                                         | 121  |
| wdt:P828  | has cause                                        | 117  |
| wdt:P527  | has part(s)                                      | 97   |
| wdt:P2572 | hashtag                                          | 74   |
| wdt:P1120 | number of deaths                                 | 63   |
| wdt:P5004 | in opposition to                                 | 63   |
| wdt:P664  | organizer                                        | 59   |
| wdt:P1339 | number of injured                                | 59   |



15 mai 2024: quasiment rien concernant la Suisse

```
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>

SELECT ?item ?itemLabel ?year ?year_l ?point_in_time ?country ?countryLabel

WHERE {
    {
    SELECT ?item ?itemLabel ?year ?point_in_time ?country ?countryLabel
      WHERE {
          ?item wdt:P31 wd:Q273120.
        
        OPTIONAL {
          ?item wdt:P17  ?country
                }
        OPTIONAL {
          ?item wdt:P585  ?point_in_time
                }
      
    BIND(REPLACE(str(?point_in_time), "(.*)([0-9]{4})(.*)", "$2") AS ?year)

    SERVICE wikibase:label { bd:serviceParam wikibase:language "en". } 
        
        }
    }   

  BIND(REPLACE(str(?itemLabel), "(.*)([0-9]{4})(.*)", "$2") AS ?year_l)    
}
ORDER BY ?year_l ?year
```