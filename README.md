# azure-policy

## What is this for?

This repo stores Azure policy definitions and assignments.

## Overview of Azure Policy Definitions

In Azure Policy, definitions describe resource compliance conditions and the effect to take if a condition is met.

Policy definitions are written in JSON.

## Overview of Azure Policy Assignments

Policy assignments are used by Azure Policy to define which resources are assigned which policy definitions.

Policy assignments must have a scope over which they take effect and this scope can be either a subscription or a management group.

## Azure's built-in policy definitions

In the Azure portal, browse to Policy, then definitions. Search for the required definition, then select it. The Definition ID will be displayed.

For example:

`/providers/Microsoft.Authorization/policyDefinitions/59efceea-0c96-497e-a4a1-4eb2290dac15`

This can then be used as the policyDefinitionId in your assignment file.

## How to create a new policy definition

1. Create a new directory under `policies` for your policy.
2. Add a `policy.json` file in the new directory with your policy definition.