# FIND 360 — Complete Project Report

**Project Name:** Find 360
**Project Location:** `C:\Users\udayp\OneDrive\Desktop\CEP`
**Report Date:** August 18, 2026
**Report Type:** Full Technical Documentation & Analysis Report
**Document Version:** 1.0

---

## TABLE OF CONTENTS

1. Executive Summary
2. Project Overview
3. Objectives and Purpose
4. Technology Stack
5. System Architecture
6. Complete File Structure
7. File-by-File Detailed Analysis
   - 7.1 index.html (Authentication / Login Page)
   - 7.2 callback.html (Authentication Routing Page)
   - 7.3 app.html (Main User Application)
   - 7.4 admin.html (Admin / Listing Dashboard)
   - 7.5 style.css (Complete Stylesheet)
   - 7.6 schema.sql (Database Schema)
   - 7.7 supabase-config.js (Configuration)
   - 7.8 supabase-js.js (Client Library)
   - 7.9 sw.js (Service Worker)
   - 7.10 manifest.json (PWA Manifest)
   - 7.11 icon.svg (App Icon)
   - 7.12 DESIGN.md (Design System)
8. Database Design — Deep Dive
   - 8.1 Tables
   - 8.2 Indexes
   - 8.3 Functions
   - 8.4 Triggers
   - 8.5 Row Level Security (RLS) Policies
9. Authentication & Authorization Flow
   - 9.1 Email/Password Sign-In
   - 9.2 Email/Password Sign-Up
   - 9.3 Google OAuth Sign-In
   - 9.4 Session Handling
   - 9.5 Role-Based Routing
10. Application Operation — How It Works
    - 10.1 User Journey (Discover → Favorites → Account)
    - 10.2 Admin Journey (Dashboard → Properties → Users)
    - 10.3 Listing Lifecycle (Submit → Approve → Live)
    - 10.4 Likes / Favorites System
    - 10.5 Search and Filters
    - 10.6 Image Upload System
11. External Services & Integrations
    - 11.1 Supabase (Auth + Database)
    - 11.2 Cloudinary (Image Hosting)
    - 11.3 Google OAuth
    - 11.4 Google Fonts & Material Symbols
12. Security Analysis
    - 12.1 Row Level Security
    - 12.2 SQL Injection Protection
    - 12.3 XSS Protection (Escaping)
    - 12.4 API Key Exposure
    - 12.5 Banned User Handling
    - 12.6 First-User-Admin Rule
13. Design System & UI/UX
    - 13.1 Color Palette
    - 13.2 Typography
    - 13.3 Spacing & Elevation
    - 13.4 Components
    - 13.5 Animations
    - 13.6 Responsive / Mobile Behavior
14. Progressive Web App (PWA) Features
15. Error Handling & Edge Cases
16. Performance Analysis
17. How to Run the Project
18. Deployment Guide
19. Recent Modifications (Mobile App Name & Welcome Text)
20. Customization Guide
21. Known Limitations
22. Future Enhancements
23. Appendix A — Key Code Snippets Explained
24. Appendix B — Glossary of Terms

## PART 2 — EXPANSION ROADMAP & STRATEGIC PLAN

25. Expansion into New Categories (Medicine & Groceries)
   - 25.1 Vision and Scope
   - 25.2 Database Strategy — Single Table vs. Separate Tables
   - 25.3 Recommended Schema Design
   - 25.4 Category-Specific Metadata — Medicine
   - 25.5 Category-Specific Metadata — Groceries
   - 25.6 Client-Side Impact of Multi-Category
   - 25.7 Migration Path for Existing Data
26. User Communication and Transactions
   - 26.1 Inquiry Flow — Three Options
   - 26.2 Recommended Inquiry System Design
   - 26.3 Inquiry Database Schema
   - 26.4 Inquiry State Machine
   - 26.5 Transaction Handling — Featured Listings
   - 26.6 Transaction Handling — Purchases & Rentals
   - 26.7 Payment Gateway Integration (Razorpay)
   - 26.8 Transaction Database Schema
   - 26.9 Webhook Security
27. Agent Role Functionality
   - 27.1 Current State of the Agent Role
   - 27.2 Planned Agent Features
   - 27.3 Agent Company Profile — Schema
   - 27.4 Multi-Client Listing Management
   - 27.5 Lead Analytics
   - 27.6 Commission & Tier Model
   - 27.7 Agent RLS Policy Changes
28. Verification and Moderation Criteria
   - 28.1 The Verification Problem
   - 28.2 Verification Policy — What "Verified" Means
   - 28.3 Required Documentation (Property)
   - 28.4 Document Upload & Private Storage Design
   - 28.5 Ownership Proof Schema
   - 28.6 Verification Workflow State Machine
   - 28.7 Category-Specific Verification (Medicine & Groceries)
   - 28.8 Legal & Compliance Notes
29. Deployment and PWA Strategy
   - 29.1 Current Deployment Status
   - 29.2 Phased Rollout Timeline
   - 29.3 Static Host Comparison
   - 29.4 Recommended Host & Domain Setup
   - 29.5 Service Worker Registration Plan
   - 29.6 Cache & Versioning Strategy
   - 29.7 Production Launch Checklist
   - 29.8 Rollback & Monitoring Plan

---

## 1. EXECUTIVE SUMMARY

**Find 360** is a modern, serverless web application built with **HTML, CSS, and vanilla JavaScript**, backed by **Supabase** (Authentication + PostgreSQL Database + Row Level Security) and **Cloudinary** (image hosting). The platform is a location-based property discovery app that allows users to:

- Browse verified properties across multiple Indian cities
- Search by keyword, city, and price range
- Save properties to favorites
- List their own properties for sale or rent
- Receive admin approval before listings go live
- Admin users get a full management dashboard with statistics, user management, and listing approval workflows

The application is **100% frontend** (no custom backend server code is required). All business logic is distributed between the client-side JavaScript and Supabase's built-in services (Row Level Security policies, triggers, and helper functions defined in `schema.sql`).

The app is also a **Progressive Web App (PWA)** — it has a manifest file, an app icon, and a service worker, which makes it installable on mobile devices and desktops, with offline-caching capabilities.

The total project size is approximately **300 KB of source code** (excluding the bundled Supabase client library `supabase-js.js` which is ~210 KB), making it extremely lightweight and fast to load.

---

## 2. PROJECT OVERVIEW

**Find 360** is designed around the tagline:

> "Everything around you, all in one place."

The original concept is a hyperlocal discovery platform. The current implementation focuses on **real-estate/property discovery**, but the architecture is designed to scale to other categories (medicine, groceries, services, etc.). In fact, the user-facing branding has recently been updated to communicate this broader vision on the login screen:

> "This is Find 360. You can find here properties, medicine, groceries here."

### 2.1 What the Platform Does

| Feature | Description |
|---|---|
| **Property Discovery** | Browse approved property listings across 13 Indian cities |
| **Search** | Live text search on title, location, and description |
| **Location Filter** | Filter by city using horizontal chip buttons |
| **Price Filter** | Filter using preset ranges (Under ₹50L, ₹50L–1Cr, ₹1–5Cr, ₹5Cr+) |
| **Favorites** | Heart/like system that persists to the database |
| **Listing** | Any user can submit a property listing |
| **Moderation** | Admin approves/rejects listings; only approved ones go public |
| **Verification** | Admin can mark listings as "Verified" |
| **Admin Dashboard** | Stats cards, recent listings, full CRUD on properties and users |
| **User Management** | Admin can change roles (user/agent/admin), ban, or delete users |
| **PWA** | Installable, works offline via service worker caching |
| **Auth** | Email/password + Google OAuth via Supabase Auth |

### 2.2 Supported Cities

Pune, Mumbai, Delhi, Bangalore, Hyderabad, Chennai, Kolkata, Ahmedabad, Jaipur, Nagpur, Indore, Nashik, Aurangabad.

---

## 3. OBJECTIVES AND PURPOSE

The project was built to achieve the following objectives:

1. **Demonstrate a serverless architecture** — a complete, production-style web app with no custom backend code, relying entirely on managed services (Supabase + Cloudinary).
2. **Implement secure multi-tenant data access** — using PostgreSQL Row Level Security so users can only see/act on data they are permitted to.
3. **Showcase role-based authorization** — with three roles: `user`, `agent`, and `admin`.
4. **Provide a complete moderation workflow** — user-submitted content is reviewed by an admin before becoming public.
5. **Deliver a mobile-first PWA experience** — with a bottom tab bar, installability, and offline support.
6. **Use a modern dark-mode design system** — a premium, minimalist look with teal accents.
7. **Be fully deployable to static hosting** — GitHub Pages, Netlify, Vercel, Cloudflare Pages, etc., with zero server configuration.

---

## 4. TECHNOLOGY STACK

| Layer | Technology | Version / Notes |
|---|---|---|
| **Language** | HTML5, CSS3, Vanilla JavaScript (ES6+) | No frameworks, no build tools |
| **Backend-as-a-Service** | Supabase | Auth + PostgreSQL + RLS + REST API |
| **Database** | PostgreSQL (hosted by Supabase) | Free tier |
| **Auth** | Supabase Auth (GoTrue) | Email/Password + Google OAuth |
| **Image Hosting** | Cloudinary | Unsigned upload preset |
| **Fonts** | Google Fonts: Inter + Instrument Serif | Display + Body |
| **Icons** | Material Symbols Outlined | Variable font icons |
| **PWA** | Web App Manifest + Service Worker | Custom cache strategy |
| **Hosting** | Any static host | Local: Python http.server |
| **Python** | (for local development only) | `python -m http.server 3000` |
| **npm/Node** | Not required | Project has no package.json |

### 4.1 Why Vanilla JavaScript?

The project deliberately avoids frameworks (React, Vue, Angular) and build tools (Webpack, Vite) to:

- Keep the app lightweight (~fastest possible first load)
- Remove dependency complexity
- Make the code transparent and easy to learn
- Allow direct deployment to any static host with zero build steps

All DOM manipulation is done with a tiny helper: `const $ = (id) => document.getElementById(id);`

---

## 5. SYSTEM ARCHITECTURE

### 5.1 High-Level Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                        BROWSER (Client)                     │
│                                                             │
│   index.html  ──►  callback.html  ──►  app.html / admin.html │
│                                                             │
│   ┌───────────────────────────────────────────────────┐    │
│   │  style.css        (design system / UI)            │    │
│   │  supabase-js.js   (Supabase client library)       │    │
│   │  supabase-config.js (API URL + anon key)          │    │
│   │  sw.js            (service worker / caching)      │    │
│   │  manifest.json    (PWA metadata)                  │    │
│   └───────────────────────────────────────────────────┘    │
└───────────────┬──────────────────┬─────────────────────────┘
                │ HTTPS REST       │ HTTPS REST (image upload)
                ▼                  ▼
   ┌────────────────────────┐  ┌────────────────────────┐
   │      SUPABASE          │  │      CLOUDINARY        │
   │  ┌──────────────────┐  │  │  (Image hosting)       │
   │  │ Auth (GoTrue)    │  │  └────────────────────────┘
   │  │ Email + Google   │  │
   │  ├──────────────────┤  │
   │  │ PostgreSQL       │  │
   │  │  users           │  │
   │  │  properties      │  │
   │  │  likes           │  │
   │  │  RLS + triggers  │  │
   │  └──────────────────┘  │
   └────────────────────────┘
```

### 5.2 Client-Side Flow

```
Page Request (browser)
        │
        ▼
index.html (login / signup)
        │  ── auth (email or Google)
        ▼
callback.html (session verify + role lookup + profile auto-create)
        │  ── role = admin ?
        ▼
   ┌─── admin.html ────────────┐
   │  Dashboard / Properties   │
   │  Users / Moderation       │
   └───────────────────────────┘
        │  ── role = user/agent ?
        ▼
app.html (Discover / Favorites / Account)
```

### 5.3 Server-Side Services (no custom code)

All server logic is implemented as **SQL in schema.sql** running inside Supabase:

- **Security Definer Functions** — `is_admin()`, `is_banned()`, `handle_new_user()`
- **Triggers** — `trg_new_user_role` (first user becomes admin)
- **Row Level Security** — 11 policies controlling every CRUD operation

---

## 6. COMPLETE FILE STRUCTURE

```
CEP/
├── index.html               (31 KB)  — Login/Signup page
├── callback.html            ( 5 KB)  — Auth routing page
├── app.html                 (18 KB)  — Main user app (Discover/Favorites/Account)
├── admin.html               (24 KB)  — Admin + user listing dashboard
├── style.css                (24 KB)  — Complete stylesheet (all pages)
├── schema.sql               ( 6 KB)  — Supabase database schema
├── supabase-config.js       (  0 KB) — Supabase client init (URL + key)
├── supabase-js.js           (211 KB) — Bundled Supabase JS client library
├── sw.js                    ( 2 KB)  — Service worker (offline cache)
├── manifest.json            (  0 KB) — PWA manifest
├── icon.svg                 (  1 KB) — App icon (SVG)
├── DESIGN.md                ( 2 KB)  — Design system documentation
└── PROJECT_REPORT.md        (this file) — Complete project report
```

| File | Size | Purpose |
|---|---|---|
| `index.html` | 31,127 bytes | Authentication entry point |
| `callback.html` | 4,675 bytes | Post-login routing & profile creation |
| `app.html` | 18,311 bytes | Main user experience |
| `admin.html` | 23,924 bytes | Dashboard for admins + listing management for all users |
| `style.css` | 23,924 bytes | All styling (single shared stylesheet) |
| `schema.sql` | 5,952 bytes | All database objects (tables, functions, RLS) |
| `supabase-config.js` | 219 bytes | Client configuration |
| `supabase-js.js` | 210,839 bytes | Official Supabase JS library (v2) |
| `sw.js` | 1,624 bytes | Service worker |
| `manifest.json` | 443 bytes | PWA metadata |
| `icon.svg` | 647 bytes | Vector app icon |

---

## 7. FILE-BY-FILE DETAILED ANALYSIS

### 7.1 index.html — Authentication Page (31 KB)

**Role in the system:** The entry point of the application. Handles login, signup, Google OAuth, and setup diagnostics.

#### 7.1.1 HTML Structure

The page is built as a **split-screen layout**:

```
<body class="auth-page">
├── .aurora                    (decorative animated glow orbs — desktop)
│   ├── .orb-1                 (teal glow, top-left)
│   ├── .orb-2                 (violet glow, bottom-right)
│   └── .orb-3                 (blue glow, center)
├── main.auth-wrap             (main grid: 2 columns)
│   ├── section.auth-brand     (left panel — brand story, hidden on mobile)
│   │   ├── .brand-kicker      ("Find 360" eyebrow text)
│   │   ├── h1.brand-title     (display headline with serif italic)
│   │   ├── p.brand-sub        (description)
│   │   ├── ul.brand-points    (3 feature bullets)
│   │   └── .brand-foot        (footer tagline)
│   └── section.auth-col       (right panel — auth card)
│       └── .auth-card
│           ├── .mobile-brand  (NEW — app name shown only on mobile)
│           ├── h2#auth-title  (dynamic heading)
│           ├── p#auth-sub     (dynamic subtitle)
│           ├── div#setup-note (setup diagnostics banner)
│           ├── button#google-btn (Google OAuth button w/ SVG logo)
│           ├── .divider       ("or with email")
│           ├── .tabs          (Sign in / Create account toggle)
│           ├── form#auth-form (email + password form)
│           │   ├── input#email
│           │   ├── input#password
│           │   ├── p#auth-status
│           │   └── button#auth-btn
│           └── p.auth-hint    (info about admin approval)
```

#### 7.1.2 Head Resources

- `manifest.json` — for PWA installability
- Google Fonts: **Inter** (400–700) + **Instrument Serif** (italic) + **Material Symbols Outlined**
- `style.css` — shared stylesheet
- `supabase-js.js` — Supabase library
- `supabase-config.js?v=6` — client init (cache-busting `?v=6` matches the service worker cache version)

#### 7.1.3 JavaScript Logic — Key Functions

| Function | Purpose |
|---|---|
| `$()` | `document.getElementById` shorthand |
| `callbackURL()` | Builds the redirect URL for OAuth based on current path |
| `setStatus()` | Updates the inline status message (success/error styling) |
| `setSetupNote()` | Shows the setup diagnostic banner (warn/err/ok) |
| `checkSetup()` | On load: detects `file://` protocol, tests DB connectivity, reports `PGRST204` (missing table) or `PGRST301` (network) errors |
| `setMode('signin'\|'signup')` | Toggles tab state, titles, button text, autocomplete attributes |
| Google button handler | `supabase.auth.signInWithOAuth({ provider: 'google', options: { redirectTo } })` then redirects to returned URL |
| Form submit handler | Sign-in: `signInWithPassword`; Sign-up: `signUp` with `full_name` in metadata |

#### 7.1.4 Important Behaviors

1. **Service Worker cleanup on load** — the page unregisters all service workers and deletes all caches. This forces fresh assets during development:
   ```js
   if ('serviceWorker' in navigator) {
       navigator.serviceWorker.getRegistrations().then(regs => regs.forEach(r => r.unregister()));
   }
   if (window.caches) {
       caches.keys().then(keys => Promise.all(keys.map(k => caches.delete(k))));
   }
   ```
   This is unusual (most apps *register* the SW here) but intentional in this project — see section 19.

2. **Setup health check** — if opened via `file://`, it displays:
   > "You opened the file directly. In the CEP folder run `python -m http.server 3000`, then open `http://localhost:3000`."

3. **OAuth hash handling** — if the URL contains `#access_token` or `#error=` (Google redirect), it restores the session and routes through `callback.html`.

4. **First user becomes admin** — enforced in the database trigger; on the client side, a hint explains the admin-approval flow.

#### 7.1.5 The Google Button SVG

The Google "G" logo is drawn with 4 inline SVG paths in brand colors (#4285F4 blue, #34A853 green, #FBBC05 yellow, #EA4335 red) — no external image needed.

---

### 7.2 callback.html — Authentication Routing Page (5 KB)

**Role in the system:** A lightweight intermediate page shown after authentication. It verifies the session, ensures the user exists in the `users` table (auto-creating if not), checks ban status, and routes to the correct app.

#### 7.2.1 Visual Design

A centered card with:
- A gradient teal logo tile with the `explore` Material icon
- A CSS spinner (`.spinner`)
- Status text ("Signing you in...", "Setting up your account...", "Welcome!")
- Error area with auto-redirect to `index.html` after 3.2 seconds on failure

#### 7.2.2 Logic Flow (`handle()`)

```
1. supabase.auth.getSession()
   └─ no session ─► showError("No active session...") → redirect to index.html

2. statusEl = "Setting up your account..."

3. Query users table: SELECT id, role, banned WHERE id = user.id
   └─ record missing ─► INSERT new user:
        { id, name, email, profile_photo_url, created_at }
      (role is auto-assigned by the database trigger — first user = admin)

4. Re-read record to obtain role

5. If banned ─► signOut() + showError("Your account has been banned by the admin.")

6. Route:
   - role === 'admin' ─► go('admin.html')   ("Opening dashboard...")
   - otherwise        ─► go('app.html')     ("Welcome!")
```

#### 7.2.3 Purpose of Auto-Creating the User

The `users` table is a mirror of Supabase's internal `auth.users` table. Because RLS policies reference `public.users` (e.g., `is_admin()`), every authenticated user must have a matching row here. The callback page guarantees this row exists before the user enters the app. This also is where the **"first user becomes admin"** trigger fires (the very first `INSERT` into `users` gets `role = 'admin'`).

---

### 7.3 app.html — Main User Application (18 KB)

**Role in the system:** The primary experience for regular users (and admins browsing the site). Contains three panels: **Discover**, **Favorites**, and **Account**.

#### 7.3.1 Layout

```
<body>
├── header.topbar               (sticky blurred header)
│   ├── .brand                  (logo dot + "Find 360")
│   └── .topbar-actions
│       ├── a.chip "List"       (→ admin.html)
│       └── a.chip#admin-pill   (admin-only quick link, hidden for users)
├── main.app
│   ├── section#panel-discover
│   │   ├── .section-head       ("Discover" + result count)
│   │   ├── .searchbar          (text search input)
│   │   ├── .chips-row#location-chips (city filter chips)
│   │   ├── .filters-row        (Price chip + Clear button)
│   │   ├── .price-panel#price-panel  (price presets grid)
│   │   ├── .props#properties-list    (property cards)
│   │   └── .empty#empty-state        (no-results message)
│   ├── section#panel-favorites
│   │   ├── .section-head
│   │   ├── .props#favorites-list
│   │   └── .empty#empty-favs
│   └── section#panel-account
│       ├── .profile-card       (photo/placeholder, name, email)
│       ├── a.menu-item "My Listings"  (→ admin.html)
│       ├── button.menu-item "My Favorites"
│       └── button.menu-item.danger "Sign out"
├── nav.tabbar                  (fixed bottom navigation)
│   ├── .tab Discover (search icon)
│   ├── .tab Favorites (heart icon)
│   └── .tab Account (person icon)
└── .toast#toast
```

#### 7.3.2 State Variables

```js
let user = null;          // Supabase auth user object
let role = 'user';        // 'user' | 'agent' | 'admin'
let allProperties = [];   // cached list of approved properties
let liked = new Set();    // in-memory set of liked property IDs
let activeLoc = null;     // active city filter
let activePrice = null;   // active price preset index
let query = '';           // live search text
```

#### 7.3.3 Constants

- **`LOCATIONS`** — 13 supported cities (array of strings).
- **`PRICE_PRESETS`** — 5 ranges with `{ label, min, max }`:
  - Any (null/null)
  - Under ₹50L (null / 50,00,000)
  - ₹50L–1Cr (50,00,000 / 1,00,00,000)
  - ₹1–5 Cr (1,00,00,000 / 5,00,00,000)
  - ₹5 Cr+ (5,00,00,000 / null)
- **`DEMO`** — 6 fallback demo properties used when the database is unreachable or empty (demonstrates the UI even before the DB is set up). Demo IDs start with `demo-`.

#### 7.3.4 Utility Functions

| Function | Purpose |
|---|---|
| `formatPrice(n)` | Formats numbers into Indian currency notation: ₹8.5 L, ₹1.5 Cr, ₹85,00,000 |
| `fmtDate(iso)` | Formats ISO dates as `18 Aug 2026` (en-IN locale) |
| `esc(s)` | HTML-escapes `& < > " '` to prevent XSS |

#### 7.3.5 Initialization (`DOMContentLoaded`)

```
1. supabase.auth.getSession()
   └─ no session ─► redirect to index.html

2. SELECT role, banned FROM users WHERE id = user.id
   └─ banned ─► signOut + alert + redirect to index.html

3. role = rec?.role || 'user'
   └─ admin ─► show admin-pill in topbar

4. loadProfile()      (avatar, name, email)
5. renderChips()      (city filter chips)
6. renderPricePanel() (price preset buttons)
7. setupSearch()      (debounced live search, 200ms)
8. loadProperties()   (fetch approved properties or DEMO fallback)
9. loadLikes()        (fetch user's liked property IDs)
```

#### 7.3.6 Search & Filtering Pipeline

`filterAndRender()` applies, in order:

1. **Text search** — `query` matched against title, location, description (lowercased `includes`)
2. **Location** — exact match on `p.location === activeLoc`
3. **Price** — range check against the selected preset (`min`/`max`)

Then re-renders the grid, updates the result count ("12 places found"), toggles the empty state, and shows/hides the "Clear" button.

Search uses **debouncing** (200 ms) so the database query — actually the in-memory filter — runs only after the user pauses typing.

#### 7.3.7 Property Cards (`cardHTML`)

Each card renders:
- **Image** — first URL from `image_urls`, lazy-loaded; if none, a `home` Material icon placeholder
- **Verified badge** — teal pill with `verified` icon, only if `p.verified`
- **Like button** — heart toggle, red when liked
- **Price** — big teal number
- **Title** — escaped text
- **Description** — clamped to 2 lines with `-webkit-line-clamp`
- **Meta row** — location icon + city, bed icon + BHK, calendar icon + date

#### 7.3.8 Likes / Favorites System

- `loadLikes()` — fetches all liked IDs: `SELECT property_id FROM likes WHERE user_id = ...`
- `toggleLike(id, btn, inFav)`:
  - Flips the `liked` Set (optimistic UI)
  - If the property is a **demo** (id starts with `demo-`), it is not persisted
  - Otherwise: delete row (if unliking) or insert `{ user_id, property_id }` (if liking)
  - Updates button classes/icons; re-renders favorites if on that panel

#### 7.3.9 Logout

`handleLogout()` → `supabase.auth.signOut()` → redirect to `index.html`.

#### 7.3.10 Toast

`showToast(msg)` shows a fixed-position toast at the bottom for 2 seconds.

---

### 7.4 admin.html — Admin & Listings Dashboard (24 KB)

**Role in the system:** A dual-purpose dashboard:
- **Admins** — full management: stats, all properties, moderation (approve/reject), user management (roles, bans, deletes).
- **Regular users** — "My Listings" view: submit their own listings and track status.

#### 7.4.1 Layout

```
<body>
├── .admin (flex)
│   ├── aside.admin-side        (246px sidebar)
│   │   ├── a.brand "Find 360"
│   │   ├── #side-label          ("Admin Panel" / "Your Dashboard")
│   │   ├── navlink Dashboard
│   │   ├── navlink Properties (label switches: "Properties"/"My Listings")
│   │   ├── navlink Users
│   │   └── .side-foot
│   │       ├── a.navlink "Browse Site" (→ app.html)
│   │       └── button.navlink "Sign out"
│   └── main.admin-main
│       ├── section#sec-dashboard
│       │   ├── .admin-head      (title + subtitle)
│       │   ├── .stats#stats-row (4 stat cards)
│       │   └── .table-wrap      (recent listings table)
│       ├── section#sec-properties
│       │   ├── .admin-head      (+ "Add property" button)
│       │   ├── .toolbar         (search)
│       │   └── .table-wrap      (full listings table)
│       └── section#sec-users
│           ├── .admin-head
│           ├── .toolbar         (search)
│           └── .table-wrap      (users table)
├── .overlay#overlay             (modal backdrop)
│   └── .modal                   (property form modal)
└── .toast#toast
```

#### 7.4.2 State & Constants

```js
let user = null;
let role = 'user';
let allProps = [];   // cached property rows
let allUsers = [];   // cached user rows
let editingId = null; // property id being edited (null = new)

const ROLES = ['user', 'agent', 'admin'];
const STATUS_BADGE = { pending: 'violet', approved: 'green', rejected: 'red' };
const CLOUD_NAME = 'qqqx8zqw';                 // Cloudinary cloud id
const UPLOAD_PRESET = 'find360_unsigne';       // unsigned upload preset
```

#### 7.4.3 Role-Adaptive UI (`applyRoleUI`)

The same page adapts its labels based on the user's role:

| Element | Admin | Regular User |
|---|---|---|
| Sidebar label | "Admin Panel" | "Your Dashboard" |
| Properties nav | "Properties" | "My Listings" |
| Dashboard title | "Admin Dashboard" | "My Dashboard" |
| Add button | "Add property" | "List a property" |
| Stat 4 label | "Users" (group icon) | "Rejected" (block icon) |

#### 7.4.4 Dashboard Stats (`loadStats`)

**Admin view** — 4 parallel head-only count queries:
1. Total properties
2. Verified properties (`verified = true`)
3. Pending properties (`status = 'pending'`)
4. Total users

**User view** — 4 parallel head-only count queries scoped to owner:
1. My total listings
2. Approved
3. Pending
4. Rejected

#### 7.4.5 Recent Listings (`loadRecent`)

- Shows the 6 most recent properties (`limit(6)`, ordered by `created_at desc`)
- Scoped to `owner_id` for non-admins
- Renders a compact table with title, location, price, and status badge

#### 7.4.6 Properties Table (`loadProperties` / `renderProps`)

- Admins: all properties; Users: only their own
- Client-side search on title/location (debounced 200ms)
- **Actions per row:**
  - Pending + admin → **Approve** / **Reject** buttons + Edit/Delete
  - Otherwise → Edit / Delete icon buttons

#### 7.4.7 Status Workflow (`setStatus`)

```
setStatus(id, 'approved')
  └─ UPDATE properties SET status = 'approved' WHERE id = id
  └─ toast "Listing approved — it is now live."
  └─ reload: properties + recent + stats
```

#### 7.4.8 Property Modal (`openPropertyModal` / `saveProperty`)

The modal form fields:
- Title (required)
- Price ₹ (number, min 0, step 10,000 — required)
- BHK / Type (text: "3 BHK, Plot, Villa")
- Location (required, with `<datalist>` city suggestions)
- Description (textarea)
- Photos — upload button OR comma-separated URL textarea
- "Mark as verified" switch (admin control)

**Save behavior:**
- **New listing (user):** `owner_id = user.id`, `status = 'pending'` → toast "Listing submitted — awaiting admin approval."
- **New listing (admin):** `owner_id = null`, `status = 'approved'` → goes live instantly
- **Edit (user):** status resets to `'pending'` (must be re-approved)
- **Edit (admin):** status preserved

#### 7.4.9 Image Upload (`uploadToCloudinary`)

```
uploadToCloudinary(file):
  1. Build FormData: { file, upload_preset: 'find360_unsigne' }
  2. POST https://api.cloudinary.com/v1_1/qqqx8zqw/image/upload
  3. Return data.secure_url
```

- Multiple files supported (loop)
- Each uploaded URL is appended to the `#f-images` textarea (comma-separated)
- `renderUploadPreview()` shows thumbnail chips with remove buttons
- Button shows "Uploading..." and disables during upload; failures show a toast

#### 7.4.10 Users Table (`loadUsers` / `renderUsers`)

Columns: User (avatar + name + banned badge), Email, Role, Joined, Actions.

- **Admins** get an inline `<select>` to change roles with a protective confirm when changing **their own** admin status:
  > "This is your own account. Removing admin access will lock you out of admin controls. Continue?"
- **Ban/Unban** — icon button with confirm; banned users cannot sign in (checked in all pages + callback)
- **Delete user** — icon button with confirm:
  > "Delete user \"X\"? Their likes and listings stay visible but the account is removed."
- Non-admins see plain text roles and "—" for actions

#### 7.4.11 Delete Property

`confirm('Delete this listing permanently?')` → `DELETE FROM properties WHERE id = ...` → reload all views.

---

### 7.5 style.css — Complete Stylesheet (24 KB, 326 lines)

#### 7.5.1 Design Tokens (`:root`)

```css
:root {
    --bg: #070c1a;              /* deep ink canvas */
    --surface: #0f1626;         /* cards */
    --surface-2: #131b2e;       /* raised surfaces */
    --ink: #e7ecf7;             /* primary text */
    --muted: #8a94a8;           /* secondary text */
    --line: #222c44;            /* borders */
    --primary: #2dd4bf;         /* bright teal */
    --primary-strong: #14b8a6;
    --primary-soft: rgba(45, 212, 191, 0.12);
    --accent: #a78bfa;          /* violet */
    --error: #f87171;           /* red */
    --radius: 16px;
    --shadow-soft: 0 6px 24px rgba(0, 0, 0, 0.35);
    --shadow-pop: 0 24px 70px rgba(0, 0, 0, 0.55);
    --font: 'Inter', system-ui, ...;
    --font-display: 'Instrument Serif', Georgia, serif;
}
```

#### 7.5.2 Section-by-Section Breakdown

| CSS Section | Lines | Content |
|---|---|---|
| Root tokens | 1–18 | Colors, shadows, fonts |
| Reset & base | 20–37 | Box-sizing, body, focus states, selection |
| Animations | 39–48 | `fadeUp`, `fadeIn`, `pop`, `spin`, `floaty` keyframes + stagger delays |
| Buttons | 50–71 | `.btn`, primary/ghost/danger, Google button, small variant |
| Inputs | 73–84 | `.field`, `.input`, focus glow states |
| Chips/Badges | 86–103 | `.chip` pills, `.badge-pill` (green/gray/violet/red) |
| Toast/Spinner | 105–114 | Fixed toast, rotating spinner |
| Setup note | 116–126 | Diagnostic banner (warn/err/ok) |
| Login page | 128–178 | Aurora orbs, split layout, brand panel, auth card, tabs, divider |
| App shell | 180–248 | Topbar, searchbar, chips row, price panel, panels, property cards, empty state, tabbar, account |
| Admin | 250–311 | Sidebar, nav links, stat cards, tables, modal, upload chips, switch, role select |
| Responsive | 313–326 | Mobile adaptations + `.mobile-brand` |

#### 7.5.3 Key Components Detailed

**Aurora background (login):**
```css
.aurora { position: fixed; inset: 0; z-index: 0; pointer-events: none; }
.orb { position: absolute; border-radius: 50%; filter: blur(90px); opacity: 0.4;
       animation: floaty 16s ease-in-out infinite; }
.orb-1 { width: 520px; height: 520px;
         background: radial-gradient(circle, rgba(45,212,191,0.32), transparent 62%);
         top: -140px; left: -90px; }
```
Three blurred radial-gradient orbs (teal, violet, blue) slowly float behind the login card.

**Property card hover:**
```css
.prop:hover { transform: translateY(-3px);
              border-color: rgba(45, 212, 191, 0.4);
              box-shadow: 0 16px 44px rgba(0, 0, 0, 0.45); }
```

**Bottom tab bar (mobile-first):**
```css
.tabbar { position: fixed; bottom: 0; left: 0; right: 0; z-index: 100;
          display: flex; background: rgba(10, 15, 28, 0.92);
          backdrop-filter: blur(14px); border-top: 1px solid var(--line);
          height: 66px; padding-bottom: env(safe-area-inset-bottom); }
```

**Sticky topbar:**
```css
.topbar { position: sticky; top: 0; z-index: 50;
          background: rgba(10, 15, 28, 0.82);
          backdrop-filter: blur(14px); border-bottom: 1px solid var(--line); }
```

**Modal:**
```css
.modal { background: var(--surface); border: 1px solid var(--line);
         width: 100%; max-width: 540px; border-radius: 24px; padding: 28px;
         box-shadow: var(--shadow-pop);
         animation: pop 0.25s cubic-bezier(0.16, 1, 0.3, 1);
         max-height: 92dvh; overflow: auto; }
```

#### 7.5.4 Responsive Breakpoint

Only **one** media query exists: `@media (max-width: 900px)`:

```css
@media (max-width: 900px) {
    .auth-wrap { grid-template-columns: 1fr; max-width: 440px; }
    .auth-brand { display: none; }          /* hide brand panel on mobile */
    .auth-col { padding: 44px 28px; }
    .admin-side { position: fixed; bottom: 0; top: auto; left: 0; right: 0;
                  width: auto; height: auto; flex-direction: row;
                  align-items: center; padding: 8px 10px; z-index: 100; gap: 4px;
                  border-top: 1px solid var(--line); border-right: none; }
    .admin-side .brand, .admin-side-label, .side-foot { display: none; }
    .navlink { flex-direction: column; gap: 2px; font-size: 10.5px;
               padding: 8px 6px; margin-bottom: 0; border-radius: 12px; }
    .navlink .material-symbols-outlined { font-size: 21px; }
    .admin-main { padding: 20px 16px 90px; }
    .form-row { grid-template-columns: 1fr; }
}
```

Key mobile behaviors:
- Login becomes a **single column** card
- The brand/story panel **hides** entirely — this is why the `.mobile-brand` element was added
- The admin sidebar turns into a **bottom navigation bar**
- Admin brand/label/footer hidden; nav links become icon-stacked columns
- Admin content gets extra bottom padding (90px) so the bottom nav doesn't cover it
- Modal form rows stack into a single column

#### 7.5.5 The `.mobile-brand` Addition (Recent Change)

```css
.mobile-brand { display: none; }
@media (max-width: 900px) {
    .mobile-brand { display: block; margin-bottom: 20px; }
    ...
}
```

Because the brand panel is hidden on mobile, a compact "FIND 360" kicker now appears at the top of the auth card on phones. It reuses the existing `.brand-kicker` styling (uppercase, letter-spaced, teal).

---

### 7.6 schema.sql — Database Schema (6 KB, 146 lines)

This is the complete Supabase database definition. It is **idempotent** (safe to re-run) — every object is created with `IF NOT EXISTS` or `CREATE OR REPLACE`, and policies are dropped before creation.

Full breakdown in **Section 8** below.

---

### 7.7 supabase-config.js — Client Configuration (219 bytes)

```js
const SUPABASE_URL = "https://omvrscqvcgvbedgcyfdj.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_jxgH3_VMqG9Zf2k0k9PbWw_qMNGthOc";
var supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
```

- `SUPABASE_URL` — the project endpoint
- `SUPABASE_ANON_KEY` — the **publishable** (anon) key. It is safe to expose because RLS policies enforce security on the server side.
- `window.supabase` — global exposed by `supabase-js.js`
- `var supabase` — global singleton used by all pages

**Note:** The key format `sb_publishable_...` is the new-style publishable key used by recent Supabase versions.

---

### 7.8 supabase-js.js — Supabase Client Library (211 KB)

A single-file, browser-bundled copy of the official **Supabase JavaScript Client (v2)**. It provides:

- `supabase.auth.*` — signInWithPassword, signUp, signInWithOAuth, getSession, signOut
- `supabase.from(table).select().insert().update().delete().eq().order().limit()` — PostgREST query builder
- `supabase.storage.*` — (available but not used in this project)

It communicates with Supabase's **PostgREST** API over HTTPS. Because it is served as a local static file, the app has no external JS dependency at runtime (besides Google Fonts), which improves reliability.

---

### 7.9 sw.js — Service Worker (2 KB, 55 lines)

The service worker implements a **cache-first with network update** strategy:

```js
const CACHE_NAME = 'find360-v6';
const ASSETS = ['/', '/index.html', '/callback.html', '/app.html', '/admin.html',
                '/style.css', '/supabase-js.js', '/supabase-config.js?v=6',
                '/manifest.json', '/icon.svg'];
```

**Install:** pre-caches all static assets, calls `skipWaiting()`.

**Activate:** deletes all caches except `find360-v6`, calls `clients.claim()`.

**Fetch interception (4 rules):**

| Request | Strategy |
|---|---|
| `supabase-config.js` | Network-first with cache fallback (always fresh config) |
| URLs containing `supabase`, `googleapis`, `gstatic` | Network only, cache fallback on failure (never serve stale API responses) |
| `mode === 'navigate'` (page loads) | Network-first with cache fallback (fresh pages, offline-safe) |
| Everything else (static assets) | **Cache-first** with network fallback |

Note: As of this report, the service worker is **not registered** anywhere in the app — `index.html` actively unregisters any existing SW. This is a deliberate dev-mode safeguard so stale cached assets never break development. To enable PWA offline mode, register `sw.js` in each page (see Section 19 & 23).

---

### 7.10 manifest.json — PWA Manifest (443 bytes)

```json
{
    "name": "Find 360",
    "short_name": "Find360",
    "description": "Everything around you, all in one place.",
    "start_url": "/index.html",
    "display": "standalone",
    "background_color": "#070c1a",
    "theme_color": "#070c1a",
    "orientation": "portrait",
    "icons": [{ "src": "icon.svg", "sizes": "any", "type": "image/svg+xml", "purpose": "any" }]
}
```

- **standalone** display → app opens without browser chrome (like a native app)
- **portrait** orientation → forces portrait on mobile installs
- Colors match the app theme for seamless splash screens

---

### 7.11 icon.svg — App Icon (647 bytes)

An SVG vector icon (likely a teal "explore"/compass mark on dark background). Because it is SVG, it scales to any size (`sizes: "any"`) and stays crisp on any device. Used by the PWA manifest.

---

### 7.12 DESIGN.md — Design System Documentation (2 KB)

The project's written design language:

**Brand:** "High-end minimalism with a calm, premium feel on a deep navy-ink canvas. Teal glows on near-black surfaces, generous whitespace, and a serif display accent for emotional headlines."

**Key rules:**
- Colors: bg `#070c1a`, surface `#0f1626`, primary teal `#2dd4bf`, accent violet `#a78bfa`, error `#f87171`
- Typography: **Inter** for UI, **Instrument Serif** for the display headline
- Elevation: tonal layering + 1px borders + soft black shadows; modal shadow `0 24px 70px`
- Shapes: buttons/inputs 14px, chips 9999px, cards 20–22px, modal 24px
- Components: login split-screen with aurora, app shell with 3-tab bottom bar, admin with sidebar/stat cards/tables

---

## 8. DATABASE DESIGN — DEEP DIVE

### 8.1 Tables

#### 8.1.1 `public.users`

```sql
create table if not exists public.users (
    id uuid primary key references auth.users(id) on delete cascade,
    name text default '',
    email text,
    profile_photo_url text default '',
    role text not null default 'user' check (role in ('user', 'admin', 'agent')),
    banned boolean not null default false,
    created_at timestamptz not null default now()
);
```

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` PK | Linked 1:1 to Supabase's `auth.users`; cascade delete |
| `name` | `text` | Display name (from Google or email prefix) |
| `email` | `text` | User email |
| `profile_photo_url` | `text` | Avatar URL (Google picture) |
| `role` | `text` | CHECK constraint: only `user`, `admin`, `agent` |
| `banned` | `boolean` | Banned flag; default `false` |
| `created_at` | `timestamptz` | Auto timestamp |

#### 8.1.2 `public.properties`

```sql
create table if not exists public.properties (
    id uuid primary key default gen_random_uuid(),
    title text not null,
    price bigint not null,
    location text not null,
    bhk text default '',
    description text default '',
    image_urls text[] default '{}',
    owner_id uuid references public.users(id) on delete set null,
    verified boolean default false,
    status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
    created_at timestamptz not null default now()
);
```

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` PK | Auto-generated |
| `title` | `text` (required) | Listing headline |
| `price` | `bigint` (required) | Price in rupees (no decimals) |
| `location` | `text` (required) | City / locality |
| `bhk` | `text` | "3 BHK", "Plot", "Villa"… |
| `description` | `text` | Free text |
| `image_urls` | `text[]` | Postgres array of Cloudinary URLs |
| `owner_id` | `uuid` FK → users | `SET NULL` if owner deleted (listings survive) |
| `verified` | `boolean` | Admin verification flag |
| `status` | `text` | CHECK: `pending` / `approved` / `rejected`; default `pending` |
| `created_at` | `timestamptz` | Auto timestamp |

#### 8.1.3 `public.likes`

```sql
create table if not exists public.likes (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references public.users(id) on delete cascade,
    property_id uuid not null references public.properties(id) on delete cascade,
    created_at timestamptz not null default now(),
    unique (user_id, property_id)
);
```

| Column | Type | Notes |
|---|---|---|
| `id` | `uuid` PK | Auto-generated |
| `user_id` | `uuid` FK → users | Cascade delete |
| `property_id` | `uuid` FK → properties | Cascade delete |
| `created_at` | `timestamptz` | Auto timestamp |
| — | UNIQUE(user_id, property_id) | Prevents duplicate likes |

### 8.2 Indexes

```sql
create index if not exists idx_properties_location on public.properties(location);
create index if not exists idx_properties_price   on public.properties(price);
create index if not exists idx_properties_owner   on public.properties(owner_id);
create index if not exists idx_properties_status  on public.properties(status);
create index if not exists idx_likes_user         on public.likes(user_id);
create index if not exists idx_likes_property     on public.likes(property_id);
```

These 6 indexes accelerate:
- Location filtering (`WHERE location = 'Pune'`)
- Price-range filtering
- Owner scoping (My Listings)
- Status filtering (pending queue, approved feed)
- Like lookups by user or property

### 8.3 Functions

#### 8.3.1 `is_admin()`

```sql
create or replace function public.is_admin()
returns boolean language sql security definer stable as $$
    select exists (
        select 1 from public.users where id = auth.uid() and role = 'admin'
    );
$$;
```

- `security definer` → runs with owner privileges so RLS never blocks it
- `stable` → optimizer can cache within a query
- Used by all RLS policies to gate admin powers

#### 8.3.2 `is_banned()`

```sql
create or replace function public.is_banned()
returns boolean language sql security definer stable as $$
    select coalesce((select banned from public.users where id = auth.uid()), false);
$$;
```

- Returns `false` for non-existent/unknown users
- Used to block banned users from inserting/updating/deleting properties

#### 8.3.3 `handle_new_user()` (trigger function)

```sql
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer as $$
begin
    if (select count(*) from public.users) = 0 then
        new.role := 'admin';
    else
        new.role := 'user';
    end if;
    return new;
end;
$$;
```

- **The first account ever created becomes the admin** — the core bootstrap rule of the platform
- All later signups get `role = 'user'`
- Runs `before insert` so the role is set before the row is written

### 8.4 Triggers

```sql
drop trigger if exists trg_new_user_role on public.users;
create trigger trg_new_user_role
before insert on public.users
for each row execute function public.handle_new_user();
```

### 8.5 Row Level Security (RLS) Policies

RLS is **enabled** on all three tables:
```sql
alter table public.users enable row level security;
alter table public.properties enable row level security;
alter table public.likes enable row level security;
```

#### 8.5.1 `users` policies (4)

| Policy | Operation | Rule |
|---|---|---|
| Users can view own profile | SELECT | `auth.uid() = id OR is_admin()` |
| Only admins can update users | UPDATE | `is_admin()` |
| Enable insert for signup | INSERT | `auth.uid() = id` |
| Only admins can delete users | DELETE | `is_admin()` |

→ Users can only see/edit **themselves**; admins can manage everyone.

#### 8.5.2 `properties` policies (4)

| Policy | Operation | Rule |
|---|---|---|
| Anyone can view approved properties | SELECT | `status = 'approved' OR auth.uid() = owner_id OR is_admin()` |
| Users can list their own properties | INSERT | `is_admin() OR (auth.uid() = owner_id AND NOT is_banned())` |
| Owners can update their properties | UPDATE | `is_admin() OR (auth.uid() = owner_id AND NOT is_banned())` |
| Owners can delete their properties | DELETE | `is_admin() OR (auth.uid() = owner_id AND NOT is_banned())` |

→ Public feed = approved only; owners manage their own; banned users lose write access; admins bypass everything.

#### 8.5.3 `likes` policies (3)

| Policy | Operation | Rule |
|---|---|---|
| Users can view own likes | SELECT | `auth.uid() = user_id OR is_admin()` |
| Users can add likes | INSERT | `auth.uid() = user_id` |
| Users can remove likes | DELETE | `auth.uid() = user_id` |

→ Users can only like/unlike for themselves.

#### 8.5.4 Security Model Summary

| Scenario | Allowed? | Enforced by |
|---|---|---|
| Anonymous visitor reads approved listings | ✅ | SELECT policy (`status='approved'`) |
| User reads own pending listing | ✅ | `auth.uid() = owner_id` |
| User reads someone else's pending listing | ❌ | RLS blocks |
| Banned user submits a listing | ❌ | `NOT is_banned()` in INSERT |
| User changes their own role | ❌ | UPDATE policy is admin-only |
| Admin edits any listing/user | ✅ | `is_admin()` |

---

## 9. AUTHENTICATION & AUTHORIZATION FLOW

### 9.1 Email/Password Sign-In (`index.html`)

```js
const { error } = await supabase.auth.signInWithPassword({ email, password });
if (error) { /* show message, re-enable button */ }
window.location.href = 'callback.html';
```

### 9.2 Email/Password Sign-Up (`index.html`)

```js
const { data, error } = await supabase.auth.signUp({
    email, password,
    options: { data: { full_name: email.split('@')[0] } }
});
```

- If `data.session` exists → email confirmation is **off** in Supabase → straight to `callback.html`
- If no session → confirmation email required; user is told:
  > "Confirmation email sent. Click the link, then sign in."
  > Plus a hint: "Supabase → Authentication → Providers → Email → turn off **Confirm email** for instant sign-in."

### 9.3 Google OAuth Sign-In (`index.html`)

```js
const { data, error } = await supabase.auth.signInWithOAuth({
    provider: 'google',
    options: { redirectTo: callbackURL() }
});
if (data && data.url) window.location.href = data.url;
```

`callbackURL()` builds the redirect target dynamically:
```js
function callbackURL() {
    const p = window.location.pathname;
    const base = p.substring(0, p.lastIndexOf('/') + 1);
    return window.location.origin + base + 'callback.html';
}
```
This works on any deployment path (root, subfolder, etc.).

**Required config:** the URL must be whitelisted in Supabase → Authentication → URL Configuration → Redirect URLs. The UI shows an inline warning when the OAuth flow fails:
> "Add `<callbackURL>` to Supabase → Authentication → URL Configuration → Redirect URLs."

### 9.4 Session Handling

Every protected page checks the session on load:
```js
const { data: { session } } = await supabase.auth.getSession();
if (!session) { window.location.href = 'index.html'; return; }
```

Sessions are stored by supabase-js in **localStorage** (`sb-<ref>-auth-token`), auto-refreshed by the library.

### 9.5 Role-Based Routing (`callback.html`)

| Role | Destination |
|---|---|
| `admin` | `admin.html` (full dashboard) |
| `user` / `agent` | `app.html` (discovery app) |

Role is re-checked on every page load (via `users` table), so an admin demoted or a user promoted takes effect on next navigation.

---

## 10. APPLICATION OPERATION — HOW IT WORKS

### 10.1 User Journey

```
1. Open http://localhost:3000          → index.html
2. Sign in (Google / email)            → callback.html
3. First-ever account                  → auto-assigned ADMIN role (DB trigger)
4. Route: admin → admin.html
         user  → app.html
5. Discover tab:
   - Browse property cards (approved only)
   - Search by keyword (debounced)
   - Tap city chips to filter
   - Tap Price → choose a preset
   - Tap Clear to reset all filters
6. Tap ❤ on any card                  → saved to likes table (or demo-only in memory)
7. Favorites tab                        → all liked properties (across page reloads)
8. Account tab:
   - Avatar, name, email (from Google or metadata)
   - "My Listings" → admin.html (their own listings)
   - "My Favorites" → jumps to favorites tab
   - "Sign out" → returns to index.html
```

### 10.2 Admin Journey

```
1. Sign in (admin account)             → callback.html → admin.html
2. Dashboard tab:
   - 4 stat cards: Properties, Verified, Pending, Users
   - Recent 6 listings table
3. Properties tab:
   - Search all listings
   - Pending rows show Approve / Reject buttons
   - Approve → status approved → listing becomes public immediately
   - Edit / Delete any listing
   - "Add property" → creates listing with status approved (instant live)
4. Users tab:
   - Search users
   - Change roles via inline dropdown (user/agent/admin)
   - Ban / Unban users (banned users can't sign in or write)
   - Delete users (listings survive — owner becomes NULL)
```

### 10.3 Listing Lifecycle

```
            ┌──────────────────────────────────────────────┐
            │                ADMIN ACTION                  │
            ▼                                              │
  ┌───────────────────┐   approve   ┌───────────────┐      │
  │ status = pending  │────────────►│  approved     │──┐   │
  │ (user submitted)  │             │  (public)     │  │   │
  └───────────────────┘             └───────────────┘  │   │
            │                                              │
            └── reject ──► status = rejected (hidden)      │
                                                            │
   User edits listing ──► status resets to pending ─────────┘
```

### 10.4 Likes / Favorites System

- Stored in `public.likes` with a UNIQUE pair constraint
- The in-memory `Set` gives instant UI feedback (optimistic updates)
- Demo properties (fallback data) are never persisted — they don't exist in the DB
- Favorites persist across sessions because they're DB-backed

### 10.5 Search and Filters

- **Search** — live, debounced 200ms, case-insensitive substring match on title/location/description (client-side on the cached list)
- **Location chips** — horizontal scrollable row; "All" resets
- **Price presets** — grid panel toggled by the Price chip; values in lakhs/crores

All three combine (AND logic) in `filterAndRender()`.

### 10.6 Image Upload System

```
User clicks "Upload photos"
  → hidden <input type="file" accept="image/*" multiple>
  → for each file: POST to Cloudinary (unsigned preset)
  → returns secure_url
  → appended to #f-images textarea (comma-separated) + preview chip
  → saved as text[] in properties.image_urls on Save
```

Note: The upload preset is **unsigned** (no auth signature), which keeps the client simple but means anyone with the preset name can upload to that Cloudinary folder — acceptable for a demo app; production should use signed uploads (see Section 23).

---

## 11. EXTERNAL SERVICES & INTEGRATIONS

### 11.1 Supabase (https://omvrscqvcgvbedgcyfdj.supabase.co)

| Service | Used For | How |
|---|---|---|
| Auth | Email/password + Google OAuth | supabase.auth.* |
| PostgREST API | All CRUD | supabase.from('table')... |
| PostgreSQL | Data + logic | schema.sql (functions, triggers, RLS) |
| RLS | Authorization | Policies in schema.sql |

### 11.2 Cloudinary

- **Cloud name:** `qqqx8zqw`
- **Upload preset:** `find360_unsigne` (unsigned)
- **Endpoint:** `https://api.cloudinary.com/v1_1/qqqx8zqw/image/upload`
- **Usage:** property photo hosting; returns `secure_url` stored as text

### 11.3 Google OAuth

- Provider configured in Supabase (client ID/secret managed there)
- The page only calls `signInWithOAuth({ provider: 'google' })`; Supabase handles the OAuth dance and redirects back with `#access_token=...`

### 11.4 Google Fonts & Material Symbols

- **Inter** (400/500/600/700) — body & UI
- **Instrument Serif** (regular + italic) — display headlines
- **Material Symbols Outlined** — variable icon font with weight/fill axes

All loaded via one Google Fonts stylesheet link per page.

---

## 12. SECURITY ANALYSIS

### 12.1 Row Level Security (Strong)

The **strongest** security feature. Even though the anon key is public, RLS guarantees:
- No anonymous writes (all writes require `auth.uid()`)
- No cross-user data access
- Admin-only management operations
- Banned users blocked from writes

### 12.2 SQL Injection (Safe)

All queries go through **PostgREST** parameterized queries (the supabase-js query builder). No raw SQL is ever interpolated from user input, so SQL injection is not possible through the app.

### 12.3 XSS Protection (Good)

All user-controlled strings rendered into HTML go through `esc()`:
```js
function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, c =>
        ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
}
```
Exception: `renderUploadPreview()` uses raw URL strings in `src` attributes (`'<img src="' + esc(u) + '"...'`). URLs are escaped with `esc()` — this mitigates `"` injection, but a `javascript:` URL could still be assigned to `src` by a malicious user entering URLs manually. Low risk in practice, but noted.

### 12.4 API Key Exposure (Acceptable)

The Supabase **anon key** is embedded in `supabase-config.js` — this is by design and safe because RLS is the real gate. The Cloudinary unsigned preset is also public — by design for this demo.

### 12.5 Banned User Handling (Good)

Ban checks run on **every** protected page load and in `callback.html`. Banned users are signed out immediately with a clear message. RLS also independently blocks their writes even if a stale session exists.

### 12.6 First-User-Admin Rule (Secure by Design)

Bootstrap trust: the very first `users` row gets `role = 'admin'`. Since `users.id` references `auth.users(id)`, only a real authenticated user can create a row (RLS: `auth.uid() = id`). No race-condition bypass is possible because the check runs inside a single SQL statement in the trigger.

### 12.7 Other Notes

- Passwords are never handled by this code — Supabase Auth (GoTrue) manages hashing (bcrypt) server-side
- No secrets, tokens, or keys beyond the anon key are stored in the client
- `autocomplete` attributes set correctly (`current-password` / `new-password`)
- Password min-length 6 enforced client-side (`minlength="6"`)

---

## 13. DESIGN SYSTEM & UI/UX

### 13.1 Color Palette

| Token | Hex | Usage |
|---|---|---|
| `--bg` | `#070c1a` | App background |
| `--surface` | `#0f1626` | Cards, panels |
| `--surface-2` | `#131b2e` | Raised elements |
| `--primary` | `#2dd4bf` | Teal — actions, prices, active states |
| `--primary-strong` | `#14b8a6` | Hover/gradient teal |
| `--ink` | `#e7ecf7` | Primary text |
| `--muted` | `#8a94a8` | Secondary text |
| `--line` | `#222c44` | Borders |
| `--accent` | `#a78bfa` | Violet — aurora only |
| `--error` | `#f87171` | Errors, likes, danger |

### 13.2 Typography

- **Inter** — all UI text (400/500/600/700)
- **Instrument Serif** — the login headline with italic em accents ("all in one place.")
- Material Symbols — iconography

### 13.3 Elevation & Depth

- Tonal layering (bg → surface → surface-2) instead of heavy shadows
- 1px borders (`--line`) define edges
- Soft shadows: cards `0 6px 24px`, hover `0 16px 44px`, modals `0 24px 70px`
- Backdrop blur on topbar, tabbar, and overlay

### 13.4 Component Library (built-in)

| Component | Class(es) | Notes |
|---|---|---|
| Buttons | `.btn`, `.btn-primary`, `.btn-ghost`, `.btn-danger`, `.btn-google`, `.btn-sm` | 14px radius, gradient primary |
| Inputs | `.input`, `.field` | 50px height, focus glow ring |
| Chips | `.chip` | Pill, active state teal |
| Badges | `.badge-pill .green/.gray/.violet/.red` | Status pills |
| Cards | `.prop` | 22px radius, hover lift |
| Modal | `.overlay` + `.modal` | Blur backdrop, pop animation |
| Tables | `.table-wrap` + `table` | Responsive scroll |
| Switch | `.switch` | Custom toggle (verified) |
| Toast | `.toast` | Bottom-center notifications |
| Tabs | `.tabs`/`.tab-btn`, `.tabbar`/`.tab` | Login tabs + app bottom nav |

### 13.5 Animations

| Animation | Used For |
|---|---|
| `fadeUp` | Entrance staggering on auth card (0.1–0.3s delays) |
| `fadeIn` | Overlay appearance |
| `pop` | Auth wrap + modal (springy cubic-bezier) |
| `spin` | Spinner |
| `floaty` | Aurora orbs (16s loop, staggered) |

### 13.6 Responsive / Mobile Behavior

| Viewport | Behavior |
|---|---|
| > 900px | Split login, sidebar admin, grid property cards |
| ≤ 900px | Single-column login + mobile brand, bottom nav (app + admin), stacked forms |

---

## 14. PROGRESSIVE WEB APP (PWA) FEATURES

| Feature | Status | Files |
|---|---|---|
| Web App Manifest | ✅ Present | `manifest.json` |
| App icon (any size, SVG) | ✅ Present | `icon.svg` |
| Standalone display mode | ✅ | `display: "standalone"` |
| Portrait orientation lock | ✅ | `orientation: "portrait"` |
| Service worker with caching | ✅ Code present | `sw.js` |
| Offline support | ⚠️ Ready but SW not registered (dev safeguard) | — |
| Theme color / splash | ✅ | `theme_color` + `background_color` |

**Current state:** the manifest is linked in every page (so browsers can offer "Add to Home Screen"), but `index.html` explicitly unregisters service workers and clears caches. This means installability is enabled, but offline mode is currently disabled during development. Re-enabling = registering `sw.js` (see Section 23).

---

## 15. ERROR HANDLING & EDGE CASES

| Scenario | Handling |
|---|---|
| No Supabase session | Redirect to `index.html` |
| DB not reachable / table missing | `checkSetup()` shows actionable banner with exact fix |
| `file://` protocol opened | Banner instructs: `python -m http.server 3000` |
| OAuth redirect not whitelisted | Error status + hint to add redirect URL in Supabase |
| Email confirmation on | Message + hint to disable confirm email |
| Properties table empty | Demo properties shown so UI is never empty |
| Properties query errors | Falls back to `DEMO` array |
| Banned user | Signed out with alert on every entry point |
| Upload failure (Cloudinary) | Toast with error, button re-enabled |
| Invalid property form | Toast: "Title, price and location are required." |
| Admin demoting self | Confirm warning before allowing |
| Deleting property | Confirm dialog before delete |
| Deleting user | Confirm dialog; listings preserved (FK set null) |
| Duplicate like | Prevented by UNIQUE(user_id, property_id) |

---

## 16. PERFORMANCE ANALYSIS

### 16.1 Load Performance

- **Total payload:** ~250 KB core (CSS 24 KB + HTML ~90 KB + config ~0.2 KB) + 211 KB Supabase client = ~300 KB
- **No framework overhead** — no React/Vue runtime, no build step
- **Google Fonts** — font-display swap (`&display=swap`), non-blocking text rendering
- **Lazy images** — `loading="lazy"` on property card images
- **Preconnects** — `rel="preconnect"` for fonts.googleapis.com and fonts.gstatic.com

### 16.2 Runtime Performance

- **Caching** — all DB reads cached in memory (`allProperties`, `allUsers`, `allProps`); filtering is client-side
- **Debounced search** — 200 ms debounce prevents per-keystroke work
- **Parallel queries** — dashboard stats use `Promise.all` (4 simultaneous head-count queries)
- **Head-only counts** — `{ count: 'exact', head: true }` avoids fetching rows for stats
- **Optimistic UI** — likes update instantly, then sync to DB

### 16.3 Database Performance

- 6 targeted indexes (location, price, owner, status, likes×2)
- `security definer` + `stable` functions avoid RLS recursion overhead
- `maybeSingle()` used where a single row is expected

---

## 17. HOW TO RUN THE PROJECT

### Method 1 — Python (recommended, simplest)

```powershell
cd "C:\Users\udayp\OneDrive\Desktop\CEP"
python -m http.server 3000
```

Then open: **http://localhost:3000**

### Method 2 — Node.js (if npm available)

```powershell
cd "C:\Users\udayp\OneDrive\Desktop\CEP"
npx serve .
```

### Method 3 — PHP

```powershell
cd "C:\Users\udayp\OneDrive\Desktop\CEP"
php -S localhost:3000
```

### Method 4 — VS Code Live Server extension

Right-click `index.html` → "Open with Live Server".

### Important Notes

- ❌ **Do NOT open `index.html` directly by double-clicking** (file:// protocol) — the app detects this and shows a setup error; Supabase auth also requires an http(s) origin.
- ❌ `npm run dev` will **not** work — there is no `package.json` (no npm scripts). Use the methods above.
- ✅ First account created = **admin**.
- If the database isn't set up yet, run `schema.sql` in **Supabase → SQL Editor**.
- Add the callback URL (e.g. `http://localhost:3000/callback.html`) to **Supabase → Authentication → URL Configuration → Redirect URLs** for Google sign-in.

---

## 18. DEPLOYMENT GUIDE

### 18.1 Prerequisites

1. Supabase project with `schema.sql` executed
2. Google OAuth provider configured (Supabase dashboard)
3. Redirect URLs whitelisted
4. Cloudinary account (if using image upload) with the matching unsigned preset

### 18.2 Static Hosting (any of these)

| Host | Steps |
|---|---|
| **Netlify** | Drag-and-drop the `CEP` folder into Netlify Drop; or `netlify deploy` |
| **Vercel** | `vercel deploy` — pure static, no build command |
| **GitHub Pages** | Push folder to a repo → Settings → Pages → branch root |
| **Cloudflare Pages** | Upload folder via dashboard or Wrangler CLI |
| **Surge.sh** | `npx surge CEP --domain find360.surge.sh` |

### 18.3 Post-Deploy Checklist

- [ ] Open the deployed URL — verify login page renders
- [ ] Verify the database connection banner is green (no warnings)
- [ ] Add `https://yourdomain.com/callback.html` to Supabase redirect URLs
- [ ] Test Google sign-in end-to-end
- [ ] Create the first account (becomes admin)
- [ ] Submit a listing from a second account; approve it from the admin
- [ ] Test like/favorite persistence
- [ ] Test mobile viewport (≤900px) — bottom navs, mobile brand
- [ ] (Optional) Register the service worker to enable offline/PWA install

---

## 19. RECENT MODIFICATIONS (THIS SESSION)

Two user-requested edits were applied to the login page:

### 19.1 Mobile App Name Added

**File:** `index.html` — added inside `.auth-card`:
```html
<div class="mobile-brand anim-fade-up">
    <span class="brand-kicker">Find 360</span>
</div>
```

**File:** `style.css` — new rule + responsive block:
```css
.mobile-brand { display: none; }
@media (max-width: 900px) {
    .mobile-brand { display: block; margin-bottom: 20px; }
    ...
}
```

**Effect:** On phones (≤900px), the brand panel is hidden, so a compact "FIND 360" kicker now shows at the top of the sign-in card. On desktop it stays hidden (the full brand panel is visible there).

### 19.2 "Welcome back" Replaced

**File:** `index.html` — static markup:
```html
<h2 class="anim-fade-up" id="auth-title">This is Find 360</h2>
<p class="auth-sub anim-fade-up anim-fade-up-1" id="auth-sub">You can find here properties, medicine, groceries here.</p>
```

**File:** `index.html` — JavaScript (`setMode`) updated so the text persists when switching tabs:
```js
$('auth-title').textContent = m === 'signin' ? 'This is Find 360' : 'Create your account';
$('auth-sub').textContent = m === 'signin'
    ? 'You can find here properties, medicine, groceries here.'
    : 'Join free and start exploring today.';
```

**Effect:** The heading now reads "This is Find 360" and the subtitle reads "You can find here properties, medicine, groceries here." (Sign-up mode still shows "Create your account" / "Join free and start exploring today.")

**Verification:** Refresh `http://localhost:3000` — mobile view shows "FIND 360" above the heading.

---

## 20. CUSTOMIZATION GUIDE

### 20.1 Changing Branding / Text

- **App name:** `manifest.json` → `name` / `short_name`; `index.html`/`app.html`/`admin.html` `.brand` text
- **Headlines:** `index.html` — `.brand-title`, `#auth-title`, `#auth-sub`
- **Taglines:** `.brand-sub`, `.brand-foot`, `DESIGN.md`
- **Browser tab titles:** `<title>` in each HTML file

### 20.2 Changing Colors

Edit the `:root` tokens in `style.css` (lines 1–18):
```css
--primary: #2dd4bf;   /* → your brand color */
--bg: #070c1a;        /* → your background */
```
CSS variables propagate everywhere automatically.

### 20.3 Changing Supported Cities

`app.html`:
```js
const LOCATIONS = ['Pune', 'Mumbai', ...];
```
And the `<datalist>` in `admin.html` (`#loc-suggest`).

### 20.4 Changing Price Presets

`app.html` → `PRICE_PRESETS` array (label/min/max in rupees).

### 20.5 Changing Demo Data

`app.html` → `DEMO` array (6 objects with id starting `demo-`).

### 20.6 Changing Cloudinary Account

`admin.html`:
```js
const CLOUD_NAME = 'qqqx8zqw';
const UPLOAD_PRESET = 'find360_unsigne';
```
Must match your Cloudinary cloud + unsigned upload preset.

### 20.7 Changing Supabase Project

`supabase-config.js`:
```js
const SUPABASE_URL = "https://YOUR-PROJECT.supabase.co";
const SUPABASE_ANON_KEY = "your-anon-key";
```
Then run `schema.sql` in the new project.

### 20.8 Extending to Medicine / Groceries (the broader Find 360 vision)

The architecture supports additional categories with minimal work:
- Add a `category` column to `properties` (or new tables with the same RLS pattern)
- Add category chips on `app.html` Discover panel
- Extend the filter pipeline in `filterAndRender()`

---

## 21. KNOWN LIMITATIONS

1. **Service worker not registered** — offline PWA mode is coded but disabled (index.html unregisters it). Register it in production.
2. **No pagination** — all properties load at once; fine for small datasets, add pagination for scale.
3. **No property detail page** — cards show a summary; no full-page detail view with gallery/contact.
4. **No photo validation** — URLs accepted as raw text; a `javascript:` URL could theoretically be entered (escaped, but not scheme-validated).
5. **Unsigned Cloudinary uploads** — convenient but not authenticated; production should use signed uploads.
6. **No email verification enforcement** — depends on Supabase config (Confirm email setting).
7. **Single admin bootstrap** — the first user is admin; if that account is lost, there's no recovery path in-app (manage via Supabase SQL).
8. **No contact/chat between buyer and seller** — listings have no contact info or inquiry flow.
9. **No location maps** — no map integration (Google Maps/Mapbox).
10. **`agent` role has no special UI** — the role exists in the DB but behaves like `user` in the UI.
11. **Cache version coupling** — `sw.js` cache name `find360-v6` and `supabase-config.js?v=6` must be bumped together.
12. **No automated tests** — manual testing only.
13. **Search is client-side only** — on very large datasets, move filtering to PostgREST queries.

---

## 22. FUTURE ENHANCEMENTS

### Authentication & Users
- Password reset flow (`supabase.auth.resetPasswordForEmail`)
- Email verification UX improvements
- Self-service profile editing (photo, name, phone)
- Multi-admin management UI

### Properties
- Property detail page with image gallery, map, and contact
- Categories: medicine, groceries, services (Find 360 vision)
- Pagination / infinite scroll
- Property negotiation / inquiry requests
- Advanced filters (BHK count, furnished, area sq.ft.)

### Platform
- Real-time updates via Supabase Realtime (live like counts, instant moderation)
- Edge functions (Deno) for signed uploads, notifications
- Stripe/UPI payments for featured listings
- i18n (Hindi + English)
- Light mode theme
- Analytics (Supabase Analytics or PostHog)
- Automated tests (Playwright/Cypress)
- PWA: register SW, push notifications, share targets

---

## 23. APPENDIX A — KEY CODE SNIPPETS EXPLAINED

### A.1 The Supabase Client Singleton (`supabase-config.js`)

```js
const SUPABASE_URL = "https://omvrscqvcgvbedgcyfdj.supabase.co";
const SUPABASE_ANON_KEY = "sb_publishable_jxgH3_VMqG9Zf2k0k9PbWw_qMNGthOc";
var supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
```
Creates one shared client instance used across all pages. The anon key is safe to expose; RLS protects the data.

### A.2 The Escaping Helper

```js
function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, c =>
        ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
}
```
Converts HTML-special characters so user text renders as text, never as markup (XSS defense).

### A.3 Price Formatting

```js
function formatPrice(n) {
    if (n >= 10000000) return '₹' + (n / 10000000).toFixed(2).replace(/\.?0+$/, '') + ' Cr';
    if (n >= 100000) return '₹' + (n / 100000).toFixed(1).replace(/\.0$/, '') + ' L';
    return '₹' + n.toLocaleString('en-IN');
}
```
₹85,00,000 → "₹85,00,000" (or "₹85 L" via admin table). ₹1,50,00,000 → "₹1.5 Cr". Indian number conventions.

### A.4 The First-User-Admin Trigger

```sql
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer as $$
begin
    if (select count(*) from public.users) = 0 then
        new.role := 'admin';
    else
        new.role := 'user';
    end if;
    return new;
end;
$$;
```
Runs before insert; if the table is empty, the new user becomes admin.

### A.5 RLS Select Policy for Properties

```sql
create policy "Anyone can view approved properties" on public.properties
    for select using (status = 'approved' or auth.uid() = owner_id or public.is_admin());
```
Anonymous users see only approved; owners see their own pending ones; admins see everything.

### A.6 Debounced Search

```js
let debounce;
$('search-input').addEventListener('input', (e) => {
    clearTimeout(debounce);
    debounce = setTimeout(() => { query = e.target.value.toLowerCase().trim(); filterAndRender(); }, 200);
});
```
Waits 200ms after the last keystroke before filtering.

### A.7 Parallel Dashboard Counts

```js
const [props, verified, pending, users] = await Promise.all([
    supabase.from('properties').select('id', { count: 'exact', head: true }),
    supabase.from('properties').select('id', { count: 'exact', head: true }).eq('verified', true),
    supabase.from('properties').select('id', { count: 'exact', head: true }).eq('status', 'pending'),
    supabase.from('users').select('id', { count: 'exact', head: true })
]);
```
Four count queries run concurrently; `head: true` fetches no rows — just counts.

### A.8 Cloudinary Upload

```js
async function uploadToCloudinary(file) {
    const fd = new FormData();
    fd.append('file', file);
    fd.append('upload_preset', UPLOAD_PRESET);
    const res = await fetch('https://api.cloudinary.com/v1_1/' + CLOUD_NAME + '/image/upload',
        { method: 'POST', body: fd });
    if (!res.ok) throw new Error('Upload failed (' + res.status + ')');
    const data = await res.json();
    return data.secure_url;
}
```
Multipart POST to Cloudinary with the unsigned preset; returns a public HTTPS URL.

### A.9 Service Worker Fetch Strategy

```js
self.addEventListener('fetch', (e) => {
    // config: always network-first
    if (e.request.url.includes('supabase-config.js')) { ... }
    // APIs/fonts: never cache stale
    if (e.request.url.includes('supabase') || ...) { network w/ cache fallback }
    // pages: network-first
    if (e.request.mode === 'navigate') { network w/ cache fallback }
    // static assets: cache-first
    e.respondWith(caches.match(e.request).then(cached => cached || fetch(e.request)));
});
```

---

## 24. APPENDIX B — GLOSSARY OF TERMS

| Term | Meaning |
|---|---|
| **BaaS** | Backend-as-a-Service — managed cloud backend (Supabase) |
| **PostgREST** | Turns the PostgreSQL database into a REST API |
| **RLS** | Row Level Security — per-row access control in PostgreSQL |
| **security definer** | SQL function that runs with the definer's privileges (bypasses RLS) |
| **anon key** | Public publishable API key for Supabase client |
| **OAuth** | Open authorization protocol (Google) |
| **PWA** | Progressive Web App — installable web app |
| **Service Worker** | Script that intercepts network requests for caching/offline |
| **Manifest** | JSON file describing app metadata for installation |
| **BHK** | Bedroom, Hall, Kitchen (Indian real estate unit) |
| **Cr / L** | Crore (10,000,000) / Lakh (100,000) — Indian units of currency |
| **timestamptz** | PostgreSQL timestamp with timezone |
| **uuid** | Universally unique identifier (Postgres gen_random_uuid) |
| **FormData** | Browser API for multipart/form-data uploads |
| **Debounce** | Technique to delay execution until input pauses |
| **XSS** | Cross-Site Scripting — injecting scripts via user input |
| **datalist** | HTML autocomplete suggestions for an input |
| **maybeSingle()** | Supabase query modifier expecting 0 or 1 rows |
| **head: true** | Supabase option to fetch only a count, no rows |
| **dvh** | Dynamic viewport height unit (CSS) |

---

## CONCLUSION

**Find 360** is a well-architected, security-conscious, serverless web application that demonstrates:

- A complete **user→moderation→admin** workflow implemented entirely with RLS
- A **premium dark design system** shared across four pages
- **Mobile-first responsive** design with bottom navigation and adaptive layouts
- **PWA-ready** code (manifest + service worker)
- **Zero build tooling** — deployable anywhere static files can be hosted

With its recent mobile-branding updates, the platform is positioned to grow beyond property discovery into the broader "everything around you" vision (properties, medicine, groceries, and more).

---

# PART 2 — EXPANSION ROADMAP & STRATEGIC PLAN

*This part answers the five strategic questions about the project's future:
(1) expansion into medicine & groceries, (2) user communication and transactions,
(3) agent role functionality, (4) verification & moderation criteria, and
(5) deployment & PWA strategy.*

---

## 25. EXPANSION INTO NEW CATEGORIES (MEDICINE & GROCERIES)

### 25.1 Vision and Scope

The Find 360 vision, as stated on the login screen, is:

> "This is Find 360. You can find here properties, medicine, groceries here."

The platform is intended to become a **multi-category hyperlocal marketplace**:

| Category | Example Items | Current State |
|---|---|---|
| **Properties** | Homes, plots, villas (BHK / Price) | ✅ Fully implemented |
| **Medicine** | Medicines, health products, pharmacies | 🔲 Planned |
| **Groceries** | Staples, produce, FMCG items | 🔲 Planned |
| (Future) | Services, vehicles, rentals | ❓ Open |

### 25.2 Database Strategy — Single Table vs. Separate Tables

This is the **most important architectural decision** for expansion. Two viable approaches exist:

#### Option A — Single `listings` Table with a `category` Column (RECOMMENDED)

```
listings (renamed from properties)
├── category        ('property' | 'medicine' | 'grocery')
├── common columns  (title, price, location, description, images, status, verified)
└── category_metadata (JSONB — category-specific fields)
```

**Advantages:**
- One unified search/filter pipeline (city chips, price, keyword work for all categories with tiny changes)
- One approval workflow for admins
- One likes/favorites system across all categories
- One RLS policy set (no duplication)
- Simplest migration: `ALTER TABLE properties RENAME TO listings; ALTER TABLE ... ADD COLUMN category`
- JSONB metadata avoids rigid schemas while items evolve

**Disadvantages:**
- JSONB columns are less typed — validation must be enforced at the application/trigger level
- Queries on metadata fields are slower unless GIN indexes are added

#### Option B — Separate Tables per Category

```
properties  (existing — stays as-is)
medicines
groceries
```

**Advantages:**
- Strictly typed columns per category
- No JSONB validation concerns

**Disadvantages:**
- Duplicates the entire RLS policy set ×3
- Duplicates likes, favorites, status workflow ×3
- Every filter/search feature must be written three times
- Admin dashboard needs three parallel management UIs
- Hardest long-term maintenance for a small codebase

#### Decision Matrix

| Criterion | Option A (single + JSONB) | Option B (separate tables) |
|---|---|---|
| Development effort | Low | High (3× duplication) |
| Code maintenance | Low | High |
| Typed validation | Medium (app-level) | High (DB-level) |
| Query performance on metadata | Medium (needs GIN) | High |
| Future categories (services, cars…) | Add one row | Add a whole new table + policies + UI |
| Existing data migration | Trivial rename | Requires data copy scripts |

**RECOMMENDATION: Option A — single `listings` table with `category` column and a `category_metadata` JSONB column.** It matches the project's "small, serverless, no-build" philosophy and keeps the admin experience unified.

### 25.3 Recommended Schema Design

```sql
-- ===== Rename existing table =====
alter table public.properties rename to listings;

-- ===== Add category columns =====
alter table public.listings add column if not exists category text
    not null default 'property'
    check (category in ('property', 'medicine', 'grocery'));

alter table public.listings add column if not exists category_metadata jsonb
    not null default '{}'::jsonb;

-- ===== GIN index for metadata searches =====
create index if not exists idx_listings_category on public.listings(category);
create index if not exists idx_listings_metadata on public.listings
    using gin (category_metadata);

-- ===== Existing indexes remain valid (renamed automatically) =====
-- idx_properties_location → idx_listings_location (auto-renamed with table)
```

**Impact on existing code:** the old `properties` table name continues to work as a view or via a compatibility rename (`create view properties as select * from listings`), so `app.html` / `admin.html` keep functioning unchanged until their queries are updated to the new name.

### 25.4 Category-Specific Metadata — Medicine

For **medicine**, the fields that differ from properties:

| Field | Type | Required | Purpose |
|---|---|---|---|
| `generic_name` | text | Yes | e.g., "Paracetamol" (brand = title) |
| `strength` | text | Yes | e.g., "500 mg" |
| `dosage_form` | text | Yes | Tablet, Syrup, Injection, Cream… |
| `pack_size` | text | Yes | e.g., "Strip of 10 tablets" |
| `manufacturer` | text | Optional | Company name |
| `expiry_date` | date | Yes | MUST be future-dated to list |
| `requires_prescription` | boolean | Yes | Rx-only flag (Schedule H/H1) |
| `batch_number` | text | Optional | Traceability |
| `mrp` | numeric | Yes | Max retail price (₹) |
| `quantity_available` | integer | Yes | Stock count |
| `category` | text | — | "medicine" (top-level) |
| `subcategory` | text | Optional | Analgesic, Antibiotic, Vitamin… |

**Example JSON:**
```json
{
  "generic_name": "Paracetamol",
  "strength": "500 mg",
  "dosage_form": "Tablet",
  "pack_size": "Strip of 15",
  "expiry_date": "2028-06-30",
  "requires_prescription": false,
  "batch_number": "PCM-2501",
  "mrp": 32.5,
  "quantity_available": 240
}
```

**Business rules for medicine:**
- `expiry_date` must be ≥ 90 days from today (reject listings expiring sooner)
- Prescription-only items show a red "Rx Required" badge; a valid prescription upload is mandatory before listing (see Section 28.7)
- GST-inclusive pricing; MRP cannot be exceeded (legal requirement in India — DPCO)

### 25.5 Category-Specific Metadata — Groceries

For **groceries**, the differing fields:

| Field | Type | Required | Purpose |
|---|---|---|---|
| `unit` | text | Yes | kg, g, L, ml, pcs, dozen |
| `quantity` | numeric | Yes | e.g., 5 (with unit = kg) |
| `brand` | text | Optional | Brand or "Local/Unbranded" |
| `food_type` | text | Optional | Veg / Non-veg / Vegan |
| `storage` | text | Optional | Ambient, Chilled, Frozen |
| `best_before_date` | date | Optional | For perishables |
| `origin` | text | Optional | "Farms of Nashik" |
| `stock` | integer | Yes | Available quantity |
| `mrp` | numeric | Optional | MRP for FMCG |
| `subcategory` | text | Optional | Staples, Dairy, Produce, Snacks… |

**Example JSON:**
```json
{
  "unit": "kg",
  "quantity": 5,
  "brand": "Local Farm",
  "food_type": "veg",
  "storage": "ambient",
  "best_before_date": "2026-12-01",
  "origin": "Nashik",
  "stock": 200,
  "mrp": 180
}
```

### 25.6 Client-Side Impact of Multi-Category

| Area | Change |
|---|---|
| `app.html` Discover | Add category chips row: **Properties | Medicine | Groceries** |
| Filters | Price chip applies to property only; category-specific filter chips (strength/unit) generated from metadata |
| Property cards | Card renders metadata rows per category (e.g., "500 mg · Strip of 15 · Exp 06/2028") |
| `admin.html` modal | Dynamic form fields per category; medicine adds expiry + Rx checkbox; grocery adds unit + quantity |
| Likes/Favorites | Unchanged — the `likes` table references `listings.id` generically |
| Search | Search across `title`, `location`, `description`, plus `category_metadata` (via `->>` operators) |

**Suggested query extension for metadata search:**
```js
supabase.from('listings').select('*')
  .eq('status', 'approved')
  .or('title.ilike.%' + q + '%,description.ilike.%' + q + '%')
```

### 25.7 Migration Path for Existing Data

```sql
-- 1. Rename table
alter table public.properties rename to listings;

-- 2. Backfill category for all existing rows
update public.listings set category = 'property'
    where category is null;

-- 3. Move BHK (a property-only field) into metadata (optional cleanup)
update public.listings set category_metadata = jsonb_build_object('bhk', bhk)
    where bhk is not null and bhk <> '';

-- 4. Compatibility view so old code keeps working during transition
create or replace view public.properties as select * from public.listings;
```

Rollback: `drop view properties; alter table listings rename to properties;`

---

## 26. USER COMMUNICATION AND TRANSACTIONS

### 26.1 Inquiry Flow — Three Options

The report identified that there is **no contact/chat system** between interested users and listing owners. Three approaches are considered:

#### Option 1 — External Link (WhatsApp) — QUICKEST TO SHIP

```js
// "WhatsApp me" button
const wa = 'https://wa.me/' + seller_phone +
          '?text=' + encodeURIComponent(
            'Hi, I am interested in "' + listing.title + '" (' +
            listing.location + '). Is it still available?');
```

| Pros | Cons |
|---|---|
| Zero backend work | Requires the seller's phone to be public |
| Works instantly | No conversation history in-app |
| Everyone has WhatsApp in India | No lead tracking for analytics |

#### Option 2 — Email Trigger

```js
// mailto fallback or Supabase Edge Function sending via Resend/SendGrid
window.location.href = 'mailto:' + seller_email + '?subject=...';
```

| Pros | Cons |
|---|---|
| No backend | Email often lands in spam |
| Formal trail | Slow response time |
| — | No structured data captured |

#### Option 3 — In-App Inquiry System (RECOMMENDED as the proper solution)

An `inquiries` table stores every lead; the owner sees inquiries in their dashboard; optional notification via Edge Function.

### 26.2 Recommended Inquiry System Design

**Combined strategy:**
1. **Phase 1 (immediate):** "Inquire" button → opens an inquiry modal (message + optional WhatsApp deep-link) → saves to `inquiries` table → owner gets notified in-dashboard.
2. **Phase 2:** Email notification via Supabase Edge Function (Resend/SendGrid) on new inquiry.
3. **Phase 3 (optional):** Real-time chat using Supabase Realtime channels scoped to an inquiry row.

### 26.3 Inquiry Database Schema

```sql
create table if not exists public.inquiries (
    id uuid primary key default gen_random_uuid(),
    listing_id uuid not null references public.listings(id) on delete cascade,
    buyer_id uuid not null references public.users(id) on delete cascade,
    seller_id uuid not null references public.users(id) on delete cascade,
    message text default '',
    buyer_phone text default '',
    status text not null default 'new'
        check (status in ('new', 'viewed', 'responded', 'closed')),
    created_at timestamptz not null default now()
);

create index if not exists idx_inquiries_seller on public.inquiries(seller_id);
create index if not exists idx_inquiries_listing on public.inquiries(listing_id);

alter table public.inquiries enable row level security;

-- Buyers see inquiries they sent
create policy "Buyers see own inquiries" on public.inquiries
    for select using (auth.uid() = buyer_id or public.is_admin());

-- Sellers/admins see inquiries on their listings
create policy "Sellers see inquiries on their listings" on public.inquiries
    for select using (
        auth.uid() = seller_id
        or auth.uid() in (select owner_id from public.listings where id = listing_id)
        or public.is_admin()
    );

-- Only the buyer can create
create policy "Buyers create inquiries" on public.inquiries
    for insert with check (auth.uid() = buyer_id);
```

**Key design note:** `seller_id` is denormalized (copied from the listing's owner at insert time) so inquiries survive even if the listing is later deleted or reassigned — historical leads are preserved.

### 26.4 Inquiry State Machine

```
new ──► viewed ──► responded ──► closed
  └────────┴──────────┘
     (owner marks status; buyer can close)
```

| State | Meaning | Who changes it |
|---|---|---|
| `new` | Buyer sent inquiry | System (auto) |
| `viewed` | Seller opened it | Seller dashboard |
| `responded` | Seller replied (or marked via WhatsApp) | Seller |
| `closed` | Deal done / no longer interested | Either party |

### 26.5 Transaction Handling — Featured Listings

**Plan: paid "Featured" placements** — sellers pay to pin their listing to the top of Discover.

| Aspect | Design |
|---|---|
| Feature column | `listings.featured_until timestamptz` (null = not featured) |
| Pricing (suggested) | ₹299 / 7 days, ₹999 / 30 days |
| Sort order | `featured_until > now()` first, then `created_at desc` |
| UI | Gold "Featured" badge + pinned card style |
| Payment | Razorpay (India) — see 26.7 |
| Auto-expiry | Edge Function cron (pg_cron or Supabase scheduled function) sets `featured_until = null` when expired |

### 26.6 Transaction Handling — Purchases & Rentals

**For properties:** Find 360 should remain a **lead-generation platform**, NOT a payment processor:
- Rent/deposit payments happen offline between parties
- The platform monetizes via featured listings, subscriptions, and lead fees

**For groceries/medicine:** payments ARE relevant. Design:

| Mode | Approach |
|---|---|
| Direct purchase | Razorpay Order API + checkout; delivery handled offline/manual (no logistics integration in v1) |
| COD | "Cash on Delivery" flag on listing; no online payment |
| Pharmacy prescription flow | Order placed as "Rx Pending" → pharmacist verifies → accepts/rejects → payment captured on accept |

### 26.7 Payment Gateway Integration (Razorpay)

Razorpay is the standard choice for the Indian market (UPI, cards, netbanking, wallets). Integration outline:

```
Client (admin.html / checkout page)
   │  1. POST /api/create-order (Edge Function)
   │     { amount, listing_id, purpose: 'featured' | 'purchase' }
   ▼
Supabase Edge Function (Deno)
   │  2. Razorpay Orders API → order_id (server-side; secret key NEVER in client)
   ▼
Client
   │  3. razorpay.checkout.open({ order_id, prefill: {email, phone} })
   ▼
Razorpay Checkout
   │  4. success → payment_id + signature returned
   ▼
Client → Edge Function
   │  5. POST /api/verify-payment { payment_id, order_id, signature }
   ▼
Edge Function (verify HMAC-SHA256 signature)
   │  6. valid → insert into payments + activate feature/order
   ▼
Database (payments, orders tables)
```

**Security:** the key secret lives only in the Edge Function environment variable. Verification uses Razorpay's HMAC-SHA256 signature (`sha256(order_id + "|" + payment_id, secret)`), never trust client-side success callbacks alone.

### 26.8 Transaction Database Schema

```sql
create table if not exists public.orders (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references public.users(id),
    listing_id uuid references public.listings(id),
    kind text not null check (kind in ('featured', 'purchase')),
    amount_paise bigint not null,
    currency text not null default 'INR',
    status text not null default 'created'
        check (status in ('created', 'paid', 'failed', 'refunded')),
    rzp_order_id text,
    rzp_payment_id text,
    rzp_signature text,
    created_at timestamptz not null default now(),
    paid_at timestamptz
);

-- Featured placements attach here
alter table public.listings add column if not exists featured_until timestamptz;
```

RLS: users see their own orders; admins see all. Payment verification is performed by the Edge Function (service role), which bypasses RLS via the service-role key.

### 26.9 Webhook Security

- Enable Razorpay **webhooks** (payment.authorized / payment.failed) pointing to a Supabase Edge Function endpoint
- Validate the `X-Razorpay-Signature` header (HMAC-SHA256 with webhook secret)
- Webhook handler marks orders paid and triggers feature activation
- Idempotency: webhooks can fire multiple times; check `orders.status` before updating

---

## 27. AGENT ROLE FUNCTIONALITY

### 27.1 Current State of the Agent Role

Today, `agent` is only a **label**:
- Stored as `users.role` (`check (role in ('user','admin','agent'))`)
- No RLS special-casing (`is_admin()` only checks `role = 'admin'`)
- No distinct UI in `app.html` or `admin.html` — agents see the same views as regular users

### 27.2 Planned Agent Features

The agent role is intended to serve **professional real-estate brokers / property dealers**:

| Feature | Description | Priority |
|---|---|---|
| **Company Profile** | Business name, GSTIN, license no., office address, logo, phone | P1 |
| **Multi-Client Listings** | Listings owned by the agency; clients linked via a `clients` table | P1 |
| **Lead Dashboard** | Inquiries on agent listings, with buyer contact + status | P1 |
| **Lead Analytics** | Views, likes, inquiries per listing; weekly/monthly trends | P2 |
| **Client Management** | Add/remove clients, each with their own listings under the agency | P2 |
| **Commission Tracking** | Deals closed per month, commission % per client | P3 |
| **Verified Agency Badge** | Admin-verified agencies show a gold badge on all their listings | P2 |

### 27.3 Agent Company Profile — Schema

```sql
alter table public.users add column if not exists agent_profile jsonb;

-- Or a normalized profile table:
create table if not exists public.agent_profiles (
    user_id uuid primary key references public.users(id) on delete cascade,
    business_name text not null,
    gstin text default '',
    license_number text default '',
    phone text default '',
    office_address text default '',
    logo_url text default '',
    verified_agency boolean not null default false,
    created_at timestamptz not null default now()
);
```

**RLS:** agents can edit their own profile; admins toggle `verified_agency`; the badge renders on all listings where `owner_id = agent_id`.

### 27.4 Multi-Client Listing Management

Option: introduce a `listing_clients` link so an agency can manage listings belonging to different property owners:

```sql
create table if not exists public.listing_clients (
    id uuid primary key default gen_random_uuid(),
    agent_id uuid not null references public.users(id),
    client_name text not null,
    client_phone text default '',
    client_email text default '',
    commission_pct numeric default 0,
    created_at timestamptz not null default now()
);

alter table public.listings add column if not exists client_id uuid
    references public.listing_clients(id) on delete set null;
```

**RLS design:** allow agents to `insert/update` listings where `owner_id = agent_id` (extend existing policies with `role = 'agent'`), and only view/manage listings linked to their own clients.

### 27.5 Lead Analytics

Dashboards for agents (new `agent` view inside `admin.html` or a new `agent.html`):

| Metric | Query |
|---|---|
| Views | `listing_views` table or Supabase Realtime presence counters |
| Likes | `select count(*) from likes where property_id in (agent listings)` |
| Inquiries | `select count(*) from inquiries where seller_id = agent.id` |
| Conversion | inquiries → responded → closed ratios |
| Trend | `date_trunc('day', created_at)` group-by charts (Chart.js, like the slides skill) |

### 27.6 Commission & Tier Model

| Tier | Criteria | Benefit |
|---|---|---|
| Free Agent | Any registered agent | Up to 5 active listings |
| Pro Agent (₹999/mo) | Paid subscription | Unlimited listings + analytics |
| Verified Agency | Admin approval + docs | Gold badge, higher search rank |

Commission tracking is a P3 (Phase 3) item — recorded manually per closed deal.

### 27.7 Agent RLS Policy Changes

```sql
-- Extend property insert/update/delete for agents (their own listings)
create policy "Agents manage their listings" on public.listings
    for all using (
        auth.uid() = owner_id
        and (select role from public.users where id = auth.uid()) = 'agent'
    );

-- Optional: agents may insert listings owned by their linked clients
create policy "Agents list for clients" on public.listings
    for insert with check (
        (select role from public.users where id = auth.uid()) = 'agent'
        and exists (
            select 1 from public.listing_clients
            where id = client_id and agent_id = auth.uid()
        )
    );
```

**Note:** any RLS change requires re-running in Supabase SQL Editor; the schema file is the single source of truth.

---

## 28. VERIFICATION AND MODERATION CRITERIA

### 28.1 The Verification Problem

Currently the admin has a simple **"Mark as verified" switch** with no offline/documentary evidence requirement. For a trustworthy marketplace ("Verified homes" is a core promise), the verification process must be defined and enforced.

### 28.2 Verification Policy — What "Verified" Means

**Definition:** *A listing is "Verified" only when the admin has confirmed the seller's identity AND (for properties) documentary ownership evidence, using the workflow below.*

Three-tier trust model:

| Level | Meaning | Visual |
|---|---|---|
| **Unverified** | Submitted, approved for public view, but not verified | No badge |
| **Verified** | Identity + documents checked by admin | Teal `verified` badge (existing) |
| **Featured** | Verified + paid placement | Gold badge + pinned |

### 28.3 Required Documentation (Property)

Before marking a property listing as verified, the **seller must submit**:

| Document | Purpose | Required |
|---|---|---|
| Government Photo ID (Aadhaar/PAN/Passport/Driving licence) | Identity of seller | Yes |
| Proof of Ownership — Sale Deed / Title Deed | Confirms the seller owns the property | Yes |
| Latest Property Tax receipt | Shows the property exists & is up-to-date | Yes |
| (For resale) Encumbrance certificate (optional) | Free from legal claims | Recommended |
| (For agents) Agency license / RERA registration | Agency legitimacy | If agent |

**Screening checklist the admin runs before clicking "Verified":**
1. Photo ID matches the user's name/profile
2. Sale deed name matches the photo ID
3. Property tax receipt address matches the listing location
4. Document photos are clear and not edited (admin's judgment)
5. Optional: 15-minute video call confirmation (P2)

### 28.4 Document Upload & Private Storage Design

**Documents must NEVER be public.** Use a **private Supabase Storage bucket**:

```js
// Client: upload to private bucket (only the owner can upload)
const { error } = await supabase.storage
    .from('verification-docs')
    .upload(`users/${user.id}/${listing.id}/sale-deed.jpg`, file);

// Admin: signed URL (10-minute expiry) — RLS-gated read
const { data } = await supabase.storage
    .from('verification-docs')
    .createSignedUrl(path, 600);   // 10 minutes only
```

| Bucket | Public? | Policy |
|---|---|---|
| `listing-images` | ✅ Public (rendered in cards) | Anyone can read |
| `verification-docs` | 🔒 Private | Upload: owner only; Read: owner + admin via signed URLs |

### 28.5 Ownership Proof Schema

```sql
create table if not exists public.verification_docs (
    id uuid primary key default gen_random_uuid(),
    listing_id uuid not null references public.listings(id) on delete cascade,
    owner_id uuid not null references public.users(id) on delete cascade,
    doc_type text not null
        check (doc_type in ('govt_id', 'sale_deed', 'tax_receipt', 'encumbrance', 'agency_license')),
    file_path text not null,            -- storage path (private bucket)
    status text not null default 'pending'
        check (status in ('pending', 'approved', 'rejected')),
    admin_note text default '',
    created_at timestamptz not null default now(),
    reviewed_at timestamptz
);

alter table public.listings add column if not exists verification_status text
    not null default 'none'
    check (verification_status in ('none', 'documents_submitted', 'verified', 'rejected'));
```

**RLS:**
- Owner: can `insert` own docs, `select` own docs
- Admin: can `select` all, `update` status
- Everyone else: **no access at all** (not even existence)

### 28.6 Verification Workflow State Machine

```
                    submit docs              admin reviews
  none ──────────────► documents_submitted ──────┬──────► verified
      ▲                                          │
      │                                          └──────► rejected (admin_note sent to owner)
      └────────────── edit/re-submit ◄────────────────────┘
```

```
1. Seller saves listing (status = approved for public view; verification_status = none)
2. Seller uploads docs via "Submit verification docs" in their dashboard
   → verification_status = documents_submitted
3. Admin dashboard: new "Verification queue" section with signed URLs
4. Admin approves → verified = true, verification_status = verified
   Admin rejects  → verification_status = rejected + admin_note (owner sees reason)
5. Owner edits docs → back to documents_submitted
```

The existing `verified` boolean stays as the public badge; `verification_status` is the internal workflow tracker.

### 28.7 Category-Specific Verification (Medicine & Groceries)

| Category | Additional requirements |
|---|---|
| **Medicine** | Pharmacy/chemist license (DL-XX license number), drug wholesaler license; prescription-only items additionally need a sample prescription; batch + expiry validation at listing time |
| **Groceries** | FSSAI license number for packaged goods; for produce — source farm/APMC acknowledgment (optional); food safety hygiene self-declaration |

Suggestion: store license numbers in `category_metadata` (`"license_no": "DL-12345"`) and show a "Licensed" badge after admin verification.

### 28.8 Legal & Compliance Notes

- **India real estate:** RERA registration for new projects; documentation varies by state (Maharashtra: Property Card, 7/12 extract)
- **Medicine:** sales only via licensed pharmacists; Schedule H/H1 drugs require prescription — the platform should display a statutory disclaimer
- **Groceries:** FSSAI licensing (registration vs. license based on turnover)
- **Data privacy:** verification documents are sensitive personal data — keep in private storage, add automatic deletion after N months (retention policy), and never expose in the public UI

---

## 29. DEPLOYMENT AND PWA STRATEGY

### 29.1 Current Deployment Status

| Item | Status |
|---|---|
| Local development | ✅ Works (`python -m http.server 3000`) |
| Supabase project | ✅ Live (`omvrscqvcgvbedgcyfdj`) |
| Schema | ✅ Applied (idempotent, re-runnable) |
| Service worker | ⚠️ Written but NOT registered (dev safeguard) |
| Static host | ❌ Not selected yet |
| Custom domain | ❌ Not configured |
| Production testing | ❌ Not performed |

### 29.2 Phased Rollout Timeline

| Phase | Duration | Activities | Exit Criteria |
|---|---|---|---|
| **Phase 1 — Local Hardening** | Weeks 1–2 | Fix known limitations (SW registration, pagination, XSS URL validation); document testing | All features pass manual test checklist locally |
| **Phase 2 — Staging** | Week 3 | Deploy to free static host with subdomain; separate Supabase staging project (optional); end-to-end test of auth/callback/redirects on real domain | Google OAuth works on the domain; no console errors |
| **Phase 3 — Soft Launch** | Weeks 4–6 | Invite 10–20 beta users; collect feedback; verify moderation flow; enable service worker + offline | Stable week of uptime, 0 critical bugs |
| **Phase 4 — Public Launch** | Week 7+ | Custom domain (e.g., find360.in), SSL, analytics, monitoring, paid features (featured listings) | Launch checklist (29.7) fully green |

### 29.3 Static Host Comparison

| Host | Free Tier | Build | SSL | Custom Domain | Global CDN | Best For |
|---|---|---|---|---|---|---|
| **Netlify** | ✅ | None needed | ✅ | ✅ (free) | ✅ | Easiest; drag-and-drop deploys; forms + functions (Edge Functions) |
| **Vercel** | ✅ | None needed | ✅ | ✅ (free) | ✅ | Great DX; serverless functions if needed later |
| **GitHub Pages** | ✅ | None | ✅ (custom via Cloudflare optional) | ✅ | ✅ | Free forever; git-based workflow |
| **Cloudflare Pages** | ✅ | None | ✅ | ✅ (free, fast) | ✅ (best TTFB) | Speed + free unlimited bandwidth |
| **Surge.sh** | ✅ | None | ✅ | ✅ (paid) | ⚠️ | Quick throwaway demos |

**RECOMMENDATION:** **Netlify** (easiest launch + built-in form/function support for future Edge Functions, e.g., payment verification & inquiry emails) with **Cloudflare as an alternative** if performance becomes a priority.

### 29.4 Recommended Host & Domain Setup

```
1. Create Netlify account → "Add new site" → Deploy manually (drag folder CEP)
2. Site name: find360 → https://find360.netlify.app
3. Supabase → Authentication → URL Configuration:
   Redirect URLs += https://find360.netlify.app/callback.html
   Site URL = https://find360.netlify.app
4. Google Cloud Console → OAuth consent screen → add new authorized domain
5. Test Google + email auth on the live URL
6. (Later) Buy domain (find360.in / find360.in) → Netlify → Domain management → add domain + SSL
7. Redeploy on every change: drag folder again (or connect GitHub repo for auto-deploys)
```

**Env-switching tip:** keep `supabase-config.js` pointing at the same project for dev+prod (simple), or create `supabase-config.prod.js` and swap via a tiny build flag later.

### 29.5 Service Worker Registration Plan

Currently `index.html` **unregisters** SWs and clears caches on load. Production plan:

**Step 1 — Register on all pages** (replace the unregister block in `index.html`):

```js
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('sw.js')
            .then(reg => console.log('SW registered:', reg.scope))
            .catch(err => console.error('SW registration failed:', err));
    });
}
```

**Step 2 — Keep dev mode clean** (use a flag):

```js
const IS_PROD = location.hostname !== 'localhost' && location.protocol !== 'file:';
if (IS_PROD) { /* register sw.js */ }
else { /* unregister + clear caches (current behavior) */ }
```

**Step 3 — Update caching scope:** ensure `sw.js`'s `ASSETS` list includes any new files (e.g., future `agent.html`, icons, images).

### 29.6 Cache & Versioning Strategy

| Item | Strategy |
|---|---|
| Cache name | Bump `CACHE_NAME` on every deploy: `find360-v7`, `v8`… |
| `supabase-config.js` | Always network-first (never serve stale keys) |
| Pages (navigate) | Network-first, cache fallback → users always see fresh pages online |
| Static assets (css/js) | Cache-first → instant loads after first visit |
| Supabase API + fonts | Network-only with cache fallback (never stale data) |
| Index.html SW cleanup | Removed in production (would break offline install) |

**One rule to remember:** every time you change `supabase-config.js` or page markup, bump the cache version — otherwise old users get stale assets.

### 29.7 Production Launch Checklist

- [ ] `schema.sql` re-run; all tables/policies/triggers verified
- [ ] Verification docs workflow (Section 28) implemented & tested
- [ ] Inquiries table live (Section 26)
- [ ] Service worker registered with `IS_PROD` flag; offline test passes (airplane mode → app loads)
- [ ] `manifest.json` icons exist in multiple sizes (512px PNG recommended for Play Store-style installs)
- [ ] Google OAuth tested on final domain
- [ ] Redirect URLs + Site URL updated in Supabase
- [ ] Cloudinary preset + cloud name confirmed for production
- [ ] Security review: no secrets in client; RLS policies spot-checked via SQL
- [ ] Performance: Lighthouse ≥ 90 (Perf/A11y/Best Practices)
- [ ] Analytics installed (Supabase Analytics or a privacy-friendly tool)
- [ ] Uptime monitoring (UptimeRobot free tier)
- [ ] Error tracking (Sentry free tier) — optional but recommended
- [ ] Legal pages: Terms of Service, Privacy Policy (esp. for medicine — statutory disclaimers)
- [ ] First-user-admin bootstrap re-confirmed on fresh signup

### 29.8 Rollback & Monitoring Plan

- **Rollback:** static hosts keep previous deploys — Netlify "Deploys → Publish previous deploy" in one click; or `git revert` + redeploy
- **Database rollback:** schema is additive/idempotent; revert scripts are provided per feature (e.g., `drop table inquiries`)
- **Monitoring:** UptimeRobot pings the login page; Supabase dashboard for API errors; `auth` sign-in failure rate alert
- **Backups:** Supabase free tier provides daily backups; export `schema.sql` after every schema change (keep in repo)

---

## PART 2 — SUMMARY

The five strategic questions resolve into these concrete plans:

| Question | Answer |
|---|---|
| **New categories DB** | Single `listings` table (renamed from `properties`) + `category` column + `category_metadata` JSONB + GIN index |
| **Medicine/grocery fields** | Medicine: generic name, strength, expiry, Rx flag, batch, MRP, stock. Groceries: unit, quantity, brand, food type, storage, best-before |
| **Communication** | In-app `inquiries` table + WhatsApp deep-links; email notifications via Edge Function in Phase 2 |
| **Transactions** | Featured listings paid via Razorpay (Phase 3); purchases via Razorpay Order API; properties stay lead-gen only |
| **Agent role** | Company profile, client-linked listings, lead dashboard, analytics, commission tiers, verified agency badge |
| **Verification** | Document-based workflow (ID + sale deed + tax receipt) in a PRIVATE storage bucket, admin review queue, state machine |
| **Deployment** | Netlify recommended; phased timeline (hardening → staging → soft launch → public); SW enabled in production with cache versioning |

---

*End of Report — Find 360 Project Documentation v1.0*
