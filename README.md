Solr Load Balancing
===================


This is just a summary of the modifications needed
to enable load balancing on Solr in case i forgot in a few months how to do it.


Load balancing is made possible by using [haproxy](http://www.haproxy.org/)

Solr Replication is done by following the [Solr Replication Guideline](https://wiki.apache.org/solr/SolrReplication)


Once everything is set on the localhost, the haproxy statistics can be seen on the page:

http://localhost/haproxy?stats


I started the master solr with

```
   $ bin/solr start -p 8984
```

and the slave solr with 

```
   $ bin/solr start -p 8985
```



## Docker

Via Docker, it is easier to see what this example is about.
In the directory docker/ there are a few things to take into consideration:

- haproxy/haproxy.cfg takes into account the names of the containers solr-master and solr-slave for the network connectivity
- in the file solr/slave/sortdemo/conf/solrconfig.xml the masterUrl for the replicationHandler is referencing solr-master host

Starting up the ecosystem is done via 

```
  sudo docker-compose up
```



## Test data

```
curl http://localhost/solr/sortdemo/update?commitWithin=3000 -d '
[
  {
    "id": "2014_1",
    "name": "Tyrion",
    "city": "New York",
    "year" : 2014,
    "month" : 1
  },
  {
    "id": "2015_2",
    "name": "John",
    "city": "New York",
    "year" : 2015,
    "month" : 2
  },
  {
    "id": "2014_2",
    "name": "Marc",
    "city": "San Francisco",
    "year" : 2014,
    "month" : 2
  },
  {
    "id": "2014_5",
    "name": "Mary",
    "city": "San Jose",
    "year" : 2014,
    "month" : 5
  },
  {
    "id": "2013_4",
    "name": "Barry",
    "city": "New Hampshire",
    "year" : 2013,
    "month" : 4
  },
  {
    "id": "2016_5",
    "name": "Betty",
    "city": "Cincinatti",
    "year" : 2015,
    "month" : 5
  }
]'




curl http://localhost:/solr/sortdemo/update?commitWithin=3000 -d '
[
  {
    "id": "201x_1",
    "name": "No Year",
    "city": "New York",
    "month" : 1
  },
  {
    "id": "2014_x",
    "name": "No Month",
    "city": "New York",
    "year" : 2014
  }
]'



curl http://localhost:/solr/sortdemo/select?indent=on&q=*:*&sort=city%20asc,%20name%20asc&wt=json

```
