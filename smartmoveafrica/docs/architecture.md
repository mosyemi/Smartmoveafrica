# SmartMoveAfrica Architecture

## Layering
- `presentation/`: screens and widgets.
- `state/`: Riverpod providers, notifiers, and app state.
- `data/models/`: immutable data entities.
- `data/repositories/`: source orchestration and persistence abstraction.
- `data/services/`: cross-cutting logic like analytics, notifications, and location.

## Data Flow
1. UI triggers provider action.
2. Provider calls repository/service abstraction.
3. Repository returns mock data or persisted local results.
4. Provider updates state, UI rebuilds.

## Contracts (mock-first, API-ready)
- Repositories expose domain methods (`login`, `fetchReports`, `fetchMatatus`, `fetchFlights`).
- Services expose capability methods (`predictTraffic`, `requestLocation`, `buildNotifications`).
- Future API wiring only replaces repository internals, not UI signatures.

## Security Baseline
- Store session token and user id in `flutter_secure_storage`.
- Keep non-sensitive flags in `shared_preferences`.
- Avoid embedding secrets in Dart source.

## Testing Strategy
- Unit tests for provider business logic.
- Widget tests for primary navigation and CTA actions.
- Integration smoke test for onboarding -> auth -> dashboard flow.
