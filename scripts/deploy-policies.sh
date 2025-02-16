#!/bin/bash
set -ex

export SUB="$1"
export ENVIRONMENT="Sandbox"
export POLICIES_DIR="$2"
export ASSIGNMENTS_DIR="$3"

echo "Deploying Policies"
for policy in $(find ${POLICIES_DIR} -name '*.json' -type f); do
  policy_name=$(basename "${policy}" .json)$(echo $ENVIRONMENT | tr '[:upper:]' '[:lower:]')
  echo "Validating policy: ${policy}"
  if jq -e '.properties' "${policy}" >/dev/null; then
    az policy definition create --name $policy_name --rules "${policy}" --mode All --display-name "${policy_name} - $ENVIRONMENT" --description "Policy from ${policy}"
  else
    echo "Error: Policy file ${policy} does not have a valid 'properties' field."
    exit 1
  fi
done

echo "Deploying Subscription Assignments"
for assignment in $(find ${ASSIGNMENTS_DIR} -type f -name 'assign.*.json'); do
  assignment_name=$(basename "${assignment}" .json)_$ENVIRONMENT
  policy_definition_id=$(jq -r '.properties.policyDefinitionId' "${assignment}")$ENVIRONMENT
  echo "Deploying assignment: ${assignment}"
  az policy assignment create --name $assignment_name --policy "${policy_definition_id}" --scope "/subscriptions/$SUB" --display-name "$assignment_name"
done