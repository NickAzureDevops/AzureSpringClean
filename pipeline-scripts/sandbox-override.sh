#!/bin/bash
set -ex

# Define directories
export SUB_ASSIGNMENTS=$(find ./assignments/$SUB -type f -name 'assign.*.json')
export POLICIES=$(find ./policies -name '*.json' -type f)

# Deploy policies
echo "Deploying Policies"
for policy in ${POLICIES}; do
    echo "Deploying policy: ${policy}"
    az policy definition create --name $(basename ${policy} .json) --rules ${policy} --mode All --display-name $(basename ${policy} .json) --description "Policy from ${policy}"
done

# Deploy subscription assignments
echo "Deploying Subscription Assignments"
for assignment in ${SUB_ASSIGNMENTS}; do
    echo "Deploying policy assignment: ${assignment}"
    assignmentName=$(basename ${assignment} .json)
    az policy assignment create --name ${assignmentName} --policy $(jq -r '.properties.policyDefinitionId' ${assignment}) --scope $(jq -r '.properties.scope' ${assignment}) --params $(jq -r '.properties.parameters' ${assignment})
done