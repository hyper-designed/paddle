## 0.1.1

- Add `TaxMode.location` enum value. Paddle introduced this on 2025-10-29 as a non-breaking API change (auto-pick inclusive vs exclusive tax based on customer location at checkout). Without it, every webhook carrying a Price using the new tax mode fails JSON deserialization.

## 0.1.0

- Initial version.
