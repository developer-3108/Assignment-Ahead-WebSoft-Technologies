# Agent.md - Codebase Navigation Guide

**Project:** Assignment - SwiftUI Menu Application  
**Company:** Ahead WebSoft Technologies Pvt Ltd  
**Purpose:** Technical assignment demonstrating SwiftUI, MVVM architecture, and API integration

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Directory Structure](#directory-structure)
4. [Key Components](#key-components)
5. [Data Flow](#data-flow)
6. [API Integration](#api-integration)
7. [Navigation Guide](#navigation-guide)
8. [Conventions & Patterns](#conventions--patterns)
9. [Important Files Reference](#important-files-reference)

---

## Project Overview

This is a SwiftUI-based iOS application that displays a dynamic menu interface with sections, collapsible items, and user profile information. The app fetches menu data from a REST API and presents it in a clean, organized grid layout.

### Key Features
- Dynamic menu display with sections
- Collapsible "APPS" section with "See More" functionality
- User profile display
- Action buttons (Rate Us and Sign Out) extracted from API data
- Loading states during API calls
- Retry mechanism for failed API requests
- Custom background styling
- Two-column grid layout for menu items

---

## Architecture

The project follows the **MVVM (Model-View-ViewModel)** architectural pattern:

```
┌─────────────┐
│    View     │  (SwiftUI Views)
│  MenuScreen │
│ ContentView │
└──────┬──────┘
       │ @StateObject / @Published
       ▼
┌─────────────┐
│  ViewModel   │  (DataViewModel)
│ ObservableObject │
└──────┬──────┘
       │ Decodes
       ▼
┌─────────────┐
│    Model     │  (DataModel, Menu, MenuSection)
│  Decodable   │
└─────────────┘
```

### Architecture Layers

1. **View Layer** (`Assignment/View/`)
   - SwiftUI views and UI components
   - Extensions for view composition
   - Helper views for reusable components

2. **ViewModel Layer** (`Assignment/ViewModel/`)
   - Business logic and state management
   - API communication
   - Data transformation

3. **Model Layer** (`Assignment/Model/`)
   - Data structures conforming to `Decodable`
   - Domain models

---

## Directory Structure

```
Assignment/
├── AssignmentApp.swift          # App entry point
├── ContentView.swift             # Root view with loading overlay
│
├── Model/
│   └── DataModel.swift           # Core data models (DataModel, Result, Menu, MenuSection)
│
├── View/
│   ├── MenuScreen.swift          # Main menu screen
│   │
│   ├── Extensions/
│   │   ├── MenuScreen+Header.swift    # Header bar extension
│   │   └── MenuScren+Buttons.swift   # Button components extension
│   │
│   └── Helpers/
│       ├── BackgroundView.swift       # Custom background view
│       ├── ContentBoxView.swift       # Menu item card component
│       ├── LoadingView.swift          # Loading overlay component
│       └── UserProfile.swift          # User profile component
│
└── ViewModel/
    ├── DataViewModel.swift            # Main view model for menu data
    │
    └── Helpers/
        ├── Helpers.swift               # Debug logging utilities
        └── LoadingAnimationHelper.swift # Loading state singleton
```

---

## Key Components

### 1. **AssignmentApp.swift**
- **Purpose:** App entry point
- **Key:** `@main` struct that initializes the app with `ContentView`

### 2. **ContentView.swift**
- **Purpose:** Root view container
- **Features:**
  - Wraps `MenuScreen`
  - Manages global loading state via `LoadingAnimationHelper.shared`
  - Applies loading overlay using `.showLoadingView()` modifier

### 3. **MenuScreen.swift**
- **Purpose:** Main menu interface
- **State Management:**
  - `@StateObject var dataViewModel` - Manages menu data
  - `@State private var isAppsExpanded` - Controls collapsible section
- **Features:**
  - Two-column grid layout (`LazyVGrid`)
  - Section-based menu display
  - Collapsible "APPS" section (shows 4 items initially)
  - Action buttons (Rate Us and Sign Out) displayed at bottom from API data
  - Fetches data on appear

### 4. **DataViewModel.swift**
- **Purpose:** Business logic and API communication
- **Key Properties:**
  - `@Published var dataModel: DataModel?` - Observable menu data
  - `@Published var apiURL: String` - API endpoint
- **Key Methods:**
  - `fetchData(retryCount:)` - Async API call with retry mechanism
  - `groupedSections` - Transforms flat menu array into sections (filters out action buttons)
  - `actionButtons` - Returns "Rate Us" and "Sign Out" menu items for button display
- **Retry Logic:**
  - Maximum 3 retries
  - 2-second delay between retries
  - Automatic retry on network/decoding errors

### 5. **DataModel.swift**
- **Purpose:** Data structures for API response
- **Structures:**
  - `DataModel` - Root response model
  - `Result` - Contains menus array and metadata
  - `Menu` - Individual menu item (conforms to `Identifiable`)
  - `MenuSection` - Grouped menu sections with collapsible support

### 6. **ContentBoxView.swift**
- **Purpose:** Reusable menu item card component
- **Features:**
  - Async image loading from URL
  - Title display
  - White card with shadow styling
  - Fixed height (80pt)

### 7. **BackgroundView.swift**
- **Purpose:** Custom background color
- **Color:** Light gray (`rgb(242, 243, 247)`)
- **Extension:** `.showBackgroundView()` modifier for easy application

### 8. **LoadingView.swift**
- **Purpose:** Loading overlay component
- **Features:**
  - Semi-transparent black overlay
  - Centered progress indicator
  - Extension: `.showLoadingView(Bool)` modifier

### 9. **UserProfile.swift**
- **Purpose:** User profile display component
- **Features:**
  - Profile image (circular)
  - User name display
  - "Edit Profile" button

### 10. **MenuScren+Buttons.swift**
- **Purpose:** Button components and action button styling
- **Components:**
  - `SeeMoreButton` - Gray button for expanding collapsible sections
  - `ActionButtonView(menu:)` - Dynamic button styling based on menu item class
    - **Rate Us** (`core_main_sesapi_rate`): White background with shadow, icon and text
    - **Sign Out** (`core_mini_auth`): Red border, red text, transparent background

---

## Data Flow

### API Data Flow

```
1. MenuScreen.onAppear
   ↓
2. DataViewModel.fetchData()
   ↓
3. startLoadingAnimation() → LoadingAnimationHelper.shared.isLoading = true
   ↓
4. URLSession.shared.data(from: url)
   ↓
5. JSONDecoder().decode(DataModel.self, from: data)
   ↓
6. dataModel = decodedResponse (on MainActor)
   ↓
7. stopLoadingAnimation() → LoadingAnimationHelper.shared.isLoading = false
   ↓
8. groupedSections computed property transforms data
   ↓
9. MenuScreen renders sections in LazyVGrid
```

### State Updates Flow

```
DataViewModel.dataModel (Published)
    ↓
@StateObject in MenuScreen
    ↓
├─ groupedSections computed property (filters action buttons)
│  ↓
│  ForEach renders MenuSection array
│  ↓
│  LazyVGrid displays ContentBoxView items
│
└─ actionButtons computed property (extracts Rate Us & Sign Out)
   ↓
   ForEach renders action buttons
   ↓
   ActionButtonView displays styled buttons
```

---

## API Integration

### Endpoint
```
https://demo.socialnetworking.solutions/sesapi/navigation?restApi=Sesapi&sesapi_platform=1&auth_token=B179%20086bb56c32731633335762
```

### Response Structure
```json
{
  "result": {
    "menus": [...],
    "notification_count": 0,
    "friend_req_count": 0,
    "message_count": 0,
    "loggedin_user_id": 0
  },
  "session_id": "string"
}
```

### Menu Item Types
- **Type 0:** Section header (e.g., "APPS", "HELP & MORE")
- **Type 1:** Regular menu item

### Action Buttons
The last two items in the `menus` array are special action buttons:
- **Rate Us**: `class == "core_main_sesapi_rate"` - Displayed as white button with icon and shadow
- **Sign Out**: `class == "core_mini_auth"` - Displayed as red bordered button
These are automatically filtered out from regular sections and displayed as full-width buttons at the bottom of the screen.

### Data Transformation
The `groupedSections` computed property in `DataViewModel`:
1. Filters out action buttons (Rate Us and Sign Out) from the menu array
2. Iterates through remaining menu items
3. Groups items by section headers (type 0)
4. Creates `MenuSection` objects with:
   - Section title
   - Menu items array
   - Collapsible flag (true for "APPS" section)

The `actionButtons` computed property:
1. Filters menu array for action button items
2. Returns items where `class == "core_main_sesapi_rate"` (Rate Us) or `class == "core_mini_auth"` (Sign Out)
3. These buttons are displayed separately at the bottom of the screen

---

## Navigation Guide

### For Developers

**Starting Point:**
1. Begin with `AssignmentApp.swift` to understand app initialization
2. Check `ContentView.swift` for root view structure
3. Navigate to `MenuScreen.swift` for main UI logic

**Understanding Data:**
1. Check `DataModel.swift` for data structures
2. Review `DataViewModel.swift` for business logic
3. See `groupedSections` for data transformation logic

**UI Components:**
1. View components in `Assignment/View/Helpers/`
2. View extensions in `Assignment/View/Extensions/`
3. Reusable modifiers in helper files

**State Management:**
1. `@StateObject` for view models
2. `@Published` for observable properties
3. `LoadingAnimationHelper.shared` for global loading state

### For AI Agents

**When modifying menu display:**
- Edit `MenuScreen.swift` for layout changes
- Modify `ContentBoxView.swift` for item appearance
- Update `DataViewModel.groupedSections` for grouping logic
- Update `ActionButtonView(menu:)` in `MenuScren+Buttons.swift` for action button styling

**When adding new API calls:**
- Add methods to `DataViewModel.swift`
- Use `startLoadingAnimation()` / `stopLoadingAnimation()` for loading states
- Implement retry logic following existing pattern

**When adding new views:**
- Create in `Assignment/View/Helpers/` for reusable components
- Use extensions in `Assignment/View/Extensions/` for view composition
- Follow SwiftUI best practices

**When modifying data models:**
- Update `DataModel.swift` structures
- Ensure `CodingKeys` match API response
- Make models `Identifiable` if used in `ForEach`

---

## Conventions & Patterns

### Naming Conventions
- **Views:** PascalCase (e.g., `MenuScreen`, `ContentBoxView`)
- **ViewModels:** PascalCase with "ViewModel" suffix (e.g., `DataViewModel`)
- **Models:** PascalCase (e.g., `DataModel`, `Menu`)
- **Extensions:** `ViewName+Feature.swift` (e.g., `MenuScreen+Header.swift`)

### SwiftUI Patterns
- Use `@StateObject` for view model initialization
- Use `@Published` for observable properties
- Use `async/await` for asynchronous operations
- Use `MainActor.run` for UI updates from background threads

### Code Organization
- **Extensions:** Used to break large views into manageable pieces
- **Helpers:** Reusable components and utilities
- **Computed Properties:** Used for data transformation (e.g., `groupedSections`)

### Error Handling
- Retry mechanism with exponential backoff
- Debug logging via `debugLog()` function
- Loading states for user feedback

### State Management
- View-level state: `@State` for local UI state
- View model state: `@Published` in `ObservableObject`
- Global state: Singleton pattern (`LoadingAnimationHelper.shared`)

---

## Important Files Reference

### Core Files
| File | Purpose | Key Concepts |
|------|---------|--------------|
| `AssignmentApp.swift` | App entry point | `@main`, `WindowGroup` |
| `ContentView.swift` | Root view | Loading overlay, view composition |
| `MenuScreen.swift` | Main screen | `@StateObject`, `LazyVGrid`, sections |
| `DataViewModel.swift` | Business logic | `ObservableObject`, async/await, retry |
| `DataModel.swift` | Data structures | `Decodable`, `Identifiable`, `CodingKeys` |

### View Components
| File | Purpose | Usage |
|------|---------|-------|
| `ContentBoxView.swift` | Menu item card | Used in `ForEach` within `LazyVGrid` |
| `BackgroundView.swift` | Custom background | Applied via `.showBackgroundView()` |
| `LoadingView.swift` | Loading overlay | Applied via `.showLoadingView(Bool)` |
| `UserProfile.swift` | Profile display | Displayed at top of menu |

### Extensions
| File | Purpose | Extends |
|------|---------|---------|
| `MenuScreen+Header.swift` | Header bar UI | `MenuScreen` |
| `MenuScren+Buttons.swift` | Button components and action buttons | `MenuScreen` |

### Utilities
| File | Purpose | Key Functions |
|------|---------|---------------|
| `Helpers.swift` | Debug logging | `debugLog(message:type:)` |
| `LoadingAnimationHelper.swift` | Loading state | `startLoadingAnimation()`, `stopLoadingAnimation()` |

---

## Common Tasks

### Adding a New Menu Section
1. Ensure API returns section header (type 0)
2. Update `groupedSections` logic if needed
3. Section will automatically appear in `MenuScreen`

### Modifying Action Buttons
1. Action buttons are automatically extracted from API data
2. To change styling, edit `ActionButtonView(menu:)` in `MenuScren+Buttons.swift`
3. Button identification uses `class` property:
   - Rate Us: `"core_main_sesapi_rate"`
   - Sign Out: `"core_mini_auth"`

### Modifying Menu Item Appearance
1. Edit `ContentBoxView.swift`
2. Changes apply to all menu items

### Changing API Endpoint
1. Update `DataViewModel.apiURL` property
2. Or modify `fetchData()` method

### Adding Loading States
1. Call `startLoadingAnimation()` before async operation
2. Call `stopLoadingAnimation()` after completion
3. Loading overlay appears automatically via `ContentView`

### Debugging
- Use `debugLog(message:type:)` for console logging
- Logs only appear in DEBUG builds
- Check console for API call status and errors

---

## Technical Notes

### SwiftUI Features Used
- `LazyVGrid` for efficient grid layout
- `AsyncImage` for remote image loading
- `@StateObject` and `@Published` for reactive updates
- View extensions for code organization
- Custom view modifiers

### Async/Await Pattern
- All API calls use `async/await`
- `MainActor.run` ensures UI updates on main thread
- Retry logic implemented with `Task.sleep`

### Identifiable Protocol
- `Menu` conforms to `Identifiable` for `ForEach` usage
- Custom `id` computed property ensures uniqueness
- Combines `label`, `icon`, and `class` for unique IDs

---

## Quick Reference

### Key State Variables
- `dataViewModel.dataModel` - Current menu data
- `isAppsExpanded` - Controls "APPS" section expansion
- `LoadingAnimationHelper.shared.isLoading` - Global loading state

### Key Methods
- `fetchData(retryCount:)` - Fetch menu data from API
- `groupedSections` - Transform flat array to sections (excludes action buttons)
- `actionButtons` - Extract Rate Us and Sign Out items for button display
- `startLoadingAnimation()` / `stopLoadingAnimation()` - Loading state
- `ActionButtonView(menu:)` - Style action buttons based on menu item class

### Key Modifiers
- `.showBackgroundView()` - Apply custom background
- `.showLoadingView(Bool)` - Show/hide loading overlay

---

## Contact & Support

**Project:** Assignment - Ahead WebSoft Technologies Pvt Ltd  
**Created:** January 2026  
**Framework:** SwiftUI  
**Minimum iOS Version:** iOS 15+ (based on SwiftUI features used)

---

*This document is maintained to help developers and AI agents quickly understand and navigate the codebase structure, patterns, and conventions.*
