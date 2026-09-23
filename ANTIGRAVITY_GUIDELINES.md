# QuickBite App — Antigravity Working Guidelines

Place this file at the root of the `quickbite_app` project folder before starting.
Antigravity should read this file first (or paste its content into the first prompt)
so every following prompt is executed consistently.

---

## 1. Project Info
- **App name:** QuickBite – Campus Food Ordering App
- **Framework:** Flutter (Dart)
- **State management:** Provider
- **Navigation:** go_router
- **Purpose:** In-class activity MVP — cross-platform mobile app (Android + iOS, single codebase)

## 2. Folder Structure (must be followed exactly)
```
lib/
 ├─ models/       # MenuItem, CartItem, Order
 ├─ screens/      # splash, login, home, item_detail, cart, checkout, order_tracking, profile
 ├─ providers/    # cart_provider.dart, order_provider.dart
 ├─ widgets/      # reusable UI components (menu_card, cart_tile, etc.)
 ├─ data/         # menu.json or dummy data files
 └─ main.dart
```

## 3. Coding Rules
- Use **local dummy/JSON data** only — no backend/API calls needed.
- Keep each screen in its own file under `screens/`.
- Use `Provider` (ChangeNotifier) for cart state — not setState across screens.
- Keep UI simple and clean; consistent theme (colors + fonts) applied via `ThemeData` in `main.dart`.
- Layout must be responsive (use `MediaQuery` / `LayoutBuilder`), tested on phone and tablet sizes.
- Screen transitions should be smooth (default Flutter transitions are fine, no need for custom animations).

## 4. Git Commit Rules
- **Small, meaningful commits** — one logical change per commit.
- Use **Conventional Commits** format:
  - `chore:` setup/config changes
  - `feat:` new feature/screen
  - `style:` theming/UI polish, no logic change
  - `fix:` bug fixes
  - `test:` test cases
- Do **not** squash multiple screens into one commit.
- After each prompt, Antigravity should show the list of commits made.

## 5. Screenshot Rule (for report)
- After each major screen/feature is completed and running on the emulator,
  **take a screenshot** and save it inside a `screenshots/` folder at project root,
  named clearly: `01_splash.png`, `02_login.png`, `03_home.png`, etc.
- Do this for every screen: Splash, Login, Home, Item Detail, Cart, Checkout,
  Order Confirmation, Order Tracking, Profile.
- These screenshots will be manually inserted into the LaTeX report later.

## 6. Testing Rule
- Minimum 6 manual test cases covering: navigation, cart logic, input validation,
  and layout responsiveness.
- Record results in a simple table (`Test ID | Description | Steps | Expected | Actual | Pass/Fail`).
- Save this table as `test_log.md` at project root — it will be pasted into the report.

## 7. Prompt Execution Order
Follow the 7-prompt sequence given separately, in order, one at a time.
Do not skip ahead or merge prompts unless instructed.

## 8. Deliverables Checklist (for final report)
- [ ] Screenshots of all 9 screens (`screenshots/` folder)
- [ ] Key code snippets (cart logic, navigation, order status)
- [ ] Test log with Pass/Fail results
- [ ] GitHub repo link with full commit history
