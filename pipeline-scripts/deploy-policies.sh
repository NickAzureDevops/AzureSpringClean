#!/bin/bash
set -ex

export SUB="$1"
export POLICIES_DIR="$2"
export ASSIGNMENTS_DIR="$3"

echo "Deploying Policies"
for policy in $(find ${POLICIES_DIR} -name '*.json' -type f); do
  policy_name=$(basename "${policy}" .json)
  display_name=$(jq -r '.properties.displayName' "${policy}")
  echo "Validating policy: ${policy}"
  if jq -e '.properties.policyRule' "${policy}" >/dev/null && jq -e '.properties.parameters' "${policy}" >/dev/null; then
    policy_rule=$(jq -c '.properties.policyRule' "${policy}")
    parameters=$(jq -c '.properties.parameters' "${policy}")
    echo "Creating policy definition: $display_name"
    az policy definition create --name $policy_name --rules "${policy_rule}" --params "${parameters}" --mode All --display-name "${display_name}" --description "Policy from ${policy}" || {
      echo "Error: Failed to create policy definition: $display_name"
      exit 1
    }
  else
    echo "Error: Policy file ${policy} does not have a valid 'policyRule' or 'parameters' field."
    exit 1
  fi
done

echo "Deploying Subscription Assignments"
for assignment in $(find ${ASSIGNMENTS_DIR} -type f -name 'assign.*.json'); do
  assignment_name=$(basename "${assignment}" .json)
  policy_definition_id=$(jq -r '.properties.policyDefinitionId' "${assignment}")
  echo "Deploying assignment: ${assignment}"
  az policy assignment create --name $assignment_name --policy "${policy_definition_id}" --scope "/subscriptions/$SUB" --display-name "$assignment_name" || {
    echo "Error: Failed to create policy assignment: $assignment_name"
    exit 1
  }
done

echo "Script completed successfully"