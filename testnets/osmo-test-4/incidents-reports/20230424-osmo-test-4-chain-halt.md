# 2023-04-24 osmo-test-4 chain halt incident report

| &nbsp;   | &nbsp;                                           |
|----------|--------------------------------------------------|
| Incident | Chain halt due to a problem in the CacheKV store |
| Chain-id | `osmo-test-4`                                    |
| Date     | 2023-04-24 19:32:57.448021073 (UTC)              |
| Block    | 10264944                                         |
| Authors  | Niccolo Raspa, Nicholas Lara                     |

## Overview

On 2023-04-24, the `osmo-test-4` testnet halted due to a single-thread concurrency issue in the CacheKV (an in-memory store utilized by the SDK) implementation that caused a deadlock. 
This report provides a detailed account of the incident, including its root cause, impact, and remediation measures taken.

## Incident Details

The osmosis testnet experienced a chain halt due to a single-thread concurrency issue in the CacheKV implementation, an in-memory store used by the SDK. The issue had previously been detected and fixed upstream on a later version of the cosmos-sdk than the one used by osmosis (https://github.com/cosmos/cosmos-sdk/pull/14350). We were aware of this, but hadn’t included it in a `v15.x` release because it is consensus-breaking. While mainnet is theoretically susceptible to the same issue, the issue is not present in practice as contract upload is permissioned.

## Root Cause

The issue was caused by a single-thread concurrency problem in the CacheKV implementation.
Although the issue was detected, it was not included in the version of the cosmos-sdk fork that Osmosis was using.

## Impact

The chain halt caused by the issue affected the Osmosis testnet, leading to network downtime.

## Remediation Measures

The fix involved unifying the cache using `tidwall/btree` and leveraging the copy-on-write feature to do iteration on an isolated view, allowing for safe modifications while iteration. The fix was backported from the cosmos-sdk repository to the osmosis fork of the cosmos sdk, and applied to the osmosis testnet, successfully resolving the chain halt.

A new `v15.0.0-rc4-testnet` tag was created explicitly for `osmo-test-4` (https://github.com/osmosis-labs/osmosis/releases/tag/v15.0.0-rc4-testnet). The validator was then restarted using the new binary version.

On 26/04/2023 at 19:18 (UTC), a message was posted on Discord (https://discord.com/channels/798583171548840026/888527537989369906/1100863521954209873) to inform integrators that the testnet functionality had resumed.
