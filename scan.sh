#!/bin/sh
api_response=`curl -s -H 'content-type: application/json'   https://scan.api.redlock.io/v1/iac   --data-binary "@cloudformation_ecs.yaml"`
rules_matched_count=`jq '.result.rules_matched|length' <<< $api_response`
echo "Prisma Cloud  IaC Policy Violation count: $rules_matched_count";

if [ "$rules_matched_count" -ne 0 ];then
  echo "Build failed with Violation Count  $rules_matched_count because the following Prisma Cloud IaC Policies failed:";
  jq '.result.rules_matched' <<< $api_response
fi

exit $rules_matched_count
