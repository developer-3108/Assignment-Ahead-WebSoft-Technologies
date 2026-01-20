# Assignment - SwiftUI Menu Application

> **Technical Assignment**  
> Developed for **Ahead WebSoft Technologies Pvt Ltd**  
> This project demonstrates SwiftUI, MVVM architecture, and REST API integration

---

## 📱 Project Overview

This is a SwiftUI-based iOS application that displays a dynamic menu interface with sections, collapsible items, and user profile information. The app fetches menu data from a REST API and presents it in a clean, organized two-column grid layout.

### ✨ Key Features

- 🎯 **Dynamic Menu Display** - Sections with organized menu items
- 📦 **Collapsible Sections** - "APPS" section with "See More" functionality (shows 4 items initially)
- 👤 **User Profile** - Profile display with edit option
- ⏳ **Loading States** - Visual feedback during API calls
- 🔄 **Retry Mechanism** - Automatic retry (up to 3 attempts) for failed API requests
- 🎨 **Custom Styling** - Custom background colors and card-based UI
- 📱 **Responsive Grid** - Two-column layout for menu items
- 🖼️ **Async Image Loading** - Remote images loaded asynchronously

---

## 🏗️ Architecture

This project follows the **MVVM (Model-View-ViewModel)** architectural pattern:

```
View (SwiftUI) → ViewModel (ObservableObject) → Model (Decodable)
```

### Architecture Layers

- **View Layer**: SwiftUI views and UI components (`Assignment/View/`)
- **ViewModel Layer**: Business logic and state management (`Assignment/ViewModel/`)
- **Model Layer**: Data structures and domain models (`Assignment/Model/`)

---

## 🛠️ Technologies & Frameworks

- **SwiftUI** - Modern declarative UI framework
- **Combine** - Reactive programming for state management
- **Async/Await** - Modern concurrency for API calls
- **URLSession** - Network requests
- **Codable** - JSON decoding

---

## 📂 Project Structure

```
Assignment/
├── AssignmentApp.swift          # App entry point
├── ContentView.swift             # Root view with loading overlay
│
├── Model/
│   └── DataModel.swift           # Core data models
│
├── View/
│   ├── MenuScreen.swift          # Main menu screen
│   ├── Extensions/               # View extensions
│   └── Helpers/                  # Reusable UI components
│
└── ViewModel/
    ├── DataViewModel.swift       # Main view model
    └── Helpers/                  # Utility functions
```

---

## 🚀 Getting Started

### Prerequisites

- Xcode 14.0 or later
- iOS 15.0+ (based on SwiftUI features used)
- Swift 5.7+

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd Assignment
   ```

2. Open the project in Xcode:
   ```bash
   open Assignment.xcodeproj
   ```

3. Build and run the project (⌘R)

### Configuration

The API endpoint is configured in `DataViewModel.swift`:
```swift
@Published var apiURL: String = "https://demo.socialnetworking.solutions/sesapi/navigation?..."
```

---

## 📊 API Integration

### Endpoint
```
GET https://demo.socialnetworking.solutions/sesapi/navigation
```

### Response Structure
The API returns a JSON object containing:
- `result.menus[]` - Array of menu items
- `result.notification_count` - Notification count
- `result.friend_req_count` - Friend request count
- `result.message_count` - Message count
- `session_id` - Session identifier

### Menu Item Types
- **Type 0**: Section header (e.g., "APPS", "HELP & MORE")
- **Type 1**: Regular menu item

### Retry Mechanism
- Maximum 3 retry attempts
- 2-second delay between retries
- Automatic retry on network or decoding errors

---

## 🎨 UI Components

### Main Views

- **MenuScreen** - Main menu interface with grid layout
- **ContentView** - Root container with loading overlay
- **UserProfile** - User profile display component

### Reusable Components

- **ContentBoxView** - Menu item card with image and title
- **BackgroundView** - Custom background color
- **LoadingView** - Loading overlay with progress indicator

### View Extensions

- **MenuScreen+Header** - Header bar with menu title and controls
- **MenuScreen+Buttons** - "See More" and "Sign Out" buttons

---

## 🔄 Data Flow

1. **App Launch** → `AssignmentApp` initializes `ContentView`
2. **View Appear** → `MenuScreen.onAppear` triggers `fetchData()`
3. **API Call** → `DataViewModel.fetchData()` makes async request
4. **Data Processing** → JSON decoded into `DataModel`
5. **Transformation** → `groupedSections` converts flat array to sections
6. **UI Update** → SwiftUI automatically updates views via `@Published`

---

## 📝 Key Features Implementation

### Collapsible Sections
The "APPS" section shows 4 items initially. When "See More" is tapped:
- `isAppsExpanded` state changes to `true`
- All items in the section are displayed
- Smooth state transition

### Loading States
- Global loading state managed by `LoadingAnimationHelper.shared`
- Loading overlay appears during API calls
- Automatically dismissed on success or failure

### Error Handling
- Network errors trigger retry mechanism
- Maximum 3 retry attempts
- Debug logging for troubleshooting

---

## 🧪 Development

### Debug Logging
The project includes a debug logging system:
```swift
debugLog(message: "Your message", type: .info)
```

Log types: `.success`, `.failed`, `.debug`, `.warning`, `.action`, `.info`

### State Management
- `@StateObject` for view model initialization
- `@Published` for observable properties
- `@State` for local view state
- Singleton pattern for global state (`LoadingAnimationHelper`)

---

## 📚 Documentation

For detailed codebase navigation and technical documentation, see **[Agent.md](Agent.md)**.

The Agent.md file includes:
- Detailed architecture diagrams
- Component descriptions
- Navigation guide for developers and AI agents
- Conventions and patterns
- Common tasks and solutions

---

## 🎯 Assignment Requirements

This project was developed as a **technical assignment** for **Ahead WebSoft Technologies Pvt Ltd**, demonstrating:

✅ SwiftUI proficiency  
✅ MVVM architecture implementation  
✅ REST API integration  
✅ Async/await concurrency  
✅ Error handling and retry mechanisms  
✅ Code organization and best practices  
✅ UI/UX design with custom components  

---

## 👤 Author

**Akshat Srivastava**  
Created: January 2026

---

## 📄 License

This project is part of a technical assignment and is intended for evaluation purposes.

---

## 🙏 Acknowledgments

- **Ahead WebSoft Technologies Pvt Ltd** for providing the technical assignment opportunity
- SwiftUI and Apple's development tools
- The demo API endpoint provided for testing

---

## 📞 Support

For questions or issues related to this assignment, please refer to the detailed documentation in [Agent.md](Agent.md) or contact the development team.

---

**Note:** This project is a demonstration of technical skills and follows industry best practices for SwiftUI development.
