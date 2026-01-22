#!/bin/sh
helm upgrade --install opensearch  opensearch/opensearch -f openSearchVals.yaml -n observability
