#!/bin/bash
set -ex

SUB_ASSIGNMENTS=$(find ./assignments/$SUB -type f -name 'assign.*.json')
POLICIES=$(find ./policies -name policy.json -type f)
ENVIRONMENT=${ENVIRONMENT:-Sandbox}
ASSIGNMENTS_DIR="./${ENVIRONMENT}/assignments"
POLICIES_DIR="./${ENVIRONMENT}/policies"

mkdir -p ${ASSIGNMENTS_DIR} ${POLICIES_DIR}

echo "Creating Sandbox Policies"
for policy in ${POLICIES}; do
    FILE=$(basename ${policy})
    DIR=$(basename "$(dirname ${policy})")
    mkdir -p ${POLICIES_DIR}/${DIR}

    echo "Creating file: ${POLICIES_DIR}/${DIR}/${FILE}"
    npx json -f ${policy} \
    -e 'this.name=this.name + process.env.ENVIRONMENT' \
    -e 'this.properties.displayName=this.properties.displayName + " - " + process.env.ENVIRONMENT' \
    -e 'this.id=process.env.SUB + "/providers/Microsoft.Authorization/policyDefinitions/" + this.name' > ${POLICIES_DIR}/${DIR}/${FILE}

done

echo "Creating Sandbox Subscription Assignments"
for assignment in ${SUB_ASSIGNMENTS}; do
    FILE=$(basename ${assignment})
    DIR=$(basename "$(dirname ${assignment})")
    mkdir -p ${ASSIGNMENTS_DIR}/${DIR}

    echo "Creating file: ${ASSIGNMENTS_DIR}/${DIR}/${FILE}"
    npx json -f ${assignment} \
    -e 'this.properties.scope=process.env.SUB' \
    -e 'this.name=this.name + "_" + process.env.ENVIRONMENT' \
    -e 'this.properties.displayName=this.properties.displayName + " - " + process.env.ENVIRONMENT' \
    -e 'this.properties.policyDefinitionId=process.env.SUB + "/providers/Microsoft.Authorization/policyDefinitions/" + this.properties.policyDefinitionId.split("/").pop() + process.env.ENVIRONMENT' \
    -e 'this.properties.notScopes=[]' \
    -e 'this.id=process.env.SUB + "/providers/Microsoft.Authorization/policyAssignments/" + this.name' > ${ASSIGNMENTS_DIR}/${DIR}/${FILE}

done

echo "Deploying Policies and Assignments"
for policy in ${POLICIES_DIR}/*/*.json; do
    az policy definition create --name $(basename $policy .json) --rules $policy --mode All --display-name $(basename $policy .json) --description "Policy from $policy"
done

for assignment in ${ASSIGNMENTS_DIR}/*/*.json; do
    az policy assignment create --name $(basename $assignment .json) --policy $(jq -r '.properties.policyDefinitionId' $assignment) --scope ${SUB} --display-name $(basename $assignment .json)
done
