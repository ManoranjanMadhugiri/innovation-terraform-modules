#!/bin/sh
export EC2_REGION=${region}
export CLOUD_DOMAIN=${env}.${domain}
export CLOUD_STACK=${env}.${domain}
export CLOUD_ENVIRONMENT=${env}
export CLOUD_APP=${env}.${domain}

export SERVICENAME=${service_name}
export DOMAINNAME=${domain}
export DYNOMITECLUSTER=${dynomite_clusterName}
export NODECOUNT=${node_count}
export ENV=${env}
