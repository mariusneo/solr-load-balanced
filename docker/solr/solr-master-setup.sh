#!/bin/bash
set -e

if [[ "$VERBOSE" = "yes" ]]; then
    set -x
fi
sentinel=/opt/docker-solr/collection_created
if [ -f $sentinel ]; then
  echo "collection already exists"
else
  mkdir -p /mysolrhome
  cp -r /opt/solr/server/solr/* /mysolrhome
  cp -r /mysolrhome/configsets/data_driven_schema_configs /mysolrhome/gettingstarted
  touch /mysolrhome/gettingstarted/core.properties
  sed -E -i -e 's,(<field name="_text_" type="text_general" indexed="true" stored="false" multiValued="true"/>),<!-- \1 -->,' \
    -e 's,(<copyField source="\*" dest="_text_"/>),<!-- \1 -->,' \
    /mysolrhome/gettingstarted/conf/managed-schema
  touch $sentinel
fi
exec solr -f
