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


