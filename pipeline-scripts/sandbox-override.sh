#!/bin/bash
set -ex

# Define directories
# Find all assignment files in the specified subscription directory
export SUB_ASSIGNMENTS=$(find ${assignmentsDirectory}/$SUB -type f -name 'assign.*.json')
# Find all policy files in the policies directory
export POLICIES=$(find ${policiesDirectory} -name '*.json' -type f)

# Deploy policies
echo "Deploying Policies"
for policy in ${POLICIES}; do
    echo "Deploying policy: ${policy}"
    # Create policy definition using the Azure CLI
    az policy definition create --name $(basename ${policy} .json) --rules ${policy} --mode All --display-name $(basename ${policy} .json) --description "Policy from ${policy}"
done

# Deploy subscription assignments
echo "Deploying Subscription Assignments"
for assignment in ${SUB_ASSIGNMENTS}; do
    echo "Deploying policy assignment: ${assignment}"
    assignmentName=$(basename ${assignment} .json)
    # Create policy assignment using the Azure CLI
    az policy assignment create --name ${assignmentName} --policy $(jq -r '.properties.policyDefinitionId' ${assignment}) --scope $(jq -r '.properties.scope' ${assignment}) --params $(jq -r '.properties.parameters' ${assignment})
done