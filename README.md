# azure-policy

## What is this for?

This repo stores azure policy definitions and assignments.

## Overview of Azure Policy Definitions

In Azure Policy, definitions describe resource compliance conditions and the effect to take if a condition is met.

Policy definitions are written in JSON.

## Overview of Azure Policy Assignments

Policy assignments are used by Azure Policy to define which resources are assigned which policy definitions.

Policies assignments must have a scope over which they take effect and this scope can be either a subscription or a management group.

## Azure's built-in policy definitions

In the Azure portal, browse to Policy, then definitions.  Search for the required definition, then select it.  The Definition ID will be displayed.

For example

`/providers/Microsoft.Authorization/policyDefinitions/`

This can then be used as the policyDefinitionId in your assignment assign.mynewpolicy.json file

## How to create a new policy definition

Create a new sub-directory under `policies` and name it for the purpose of the policy e.g. tagging.

## Use Azure Policy to enforce compliance during resource deployment

Example built-in policies:
- **Require Tags on Resources**: Ensure all resources have metadata for cost and management tracking.
- **Deny Public IPs on Virtual Machines**: Prevent deployment of publicly exposed VMs.

## Demo: Attach an Azure Policy initiative to your subscription or resource group

Example: "Enable Monitoring in Defender for Cloud" policy.

## How to create a new policy assignment and test under subscription assignment

Policies that are to be assigned to a subscription or group of subscriptions are located within the appropriate subscription directory under `assignments/subscriptions`.

When you've decided on a scope, create a policy assignment file in the appropriate directory. Name the file assign.policyname.json e.g. `assign.diagnostics.json`.
