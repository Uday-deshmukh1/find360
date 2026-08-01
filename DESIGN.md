# Find 360 - Design System (Dark)

## Brand
High-end minimalism with a calm, premium feel on a deep navy-ink canvas. Teal glows on near-black surfaces, generous whitespace, and a serif display accent for emotional headlines.

## Colors
- `--bg: #070c1a` deep ink canvas
- `--surface: #0f1626` cards, `--surface-2: #131b2e` raised surfaces
- `--primary: #2dd4bf` bright teal - actions, active states, prices, verified
- `--ink: #e7ecf7` primary text, `--muted: #8a94a8` secondary text
- `--line: #222c44` borders
- `--accent: #a78bfa` violet - aurora orbs / gradients only
- `--error: #f87171`

## Typography
- Body & UI: **Inter** (400/500/600/700)
- Display: **Instrument Serif** (italic accents) for the login headline only

## Elevation
- Depth is created with tonal layering (bg -> surface -> surface-2), borders, and soft black shadows
- Cards: 1px `--line` border, `0 6px 24px rgba(0,0,0,.35)`
- Hover: lift + teal border glow
- Modals: `0 24px 70px rgba(0,0,0,.55)` + blurred dark overlay

## Shapes
- Buttons/inputs: `14px`, chips `9999px`, cards `20-22px`, modal `24px`

## Components
- **Login** - split screen: dark gradient brand panel (aurora orbs) + card with Google + email sign-in/sign-up tabs, live setup health-check banner
- **App** - sticky blurred topbar, search bar, location chips, price presets, property cards with verify badge + like button, 3-tab bottom bar
- **Admin** - dark sidebar, stat cards, searchable tables with inline role select, property modal (title/price/location/bhk/description/images/verified switch)

## Pages
1. `index.html` - login / sign up / setup diagnostics
2. `callback.html` - auth routing by role (admin -> admin.html)
3. `app.html` - discover / favorites / account
4. `admin.html` - dashboard / properties CRUD / users
