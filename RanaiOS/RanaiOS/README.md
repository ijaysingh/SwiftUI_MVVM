# Rana iOS App

A SwiftUI-based iOS application with MVVM architecture for managing activities and tasks.

## Project Structure

```
RanaiOS/
├── Models/
│   └── Activity.swift              # Data models for activities
├── ViewModels/
│   └── HomeViewModel.swift         # Business logic for home screen
├── Views/
│   ├── HomeView.swift             # Main home screen UI
│   ├── TaskDetailView.swift       # Activity detail view
│   └── ActivityRowView.swift      # Individual activity row component
├── Services/
│   ├── ActivityService.swift      # Real API service
│   └── MockActivityService.swift  # Mock service for testing (not used)
├── ContentView.swift              # Main app entry point
└── RanaiOSApp.swift              # App configuration
```

## Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture pattern:

- **Models**: Data structures and business entities
- **Views**: UI components and user interface
- **ViewModels**: Business logic, state management, and data binding
- **Services**: API communication and data fetching

## Features

- **Dark Theme**: Modern dark UI design matching the provided image
- **Activity Management**: View, filter, and manage activities
- **Filter Tabs**: Filter activities by type (All, Task, Meeting, Event)
- **Activity Summary**: Shows total, completed, and remaining activities
- **Detail View**: Tap any activity to see detailed information
- **Interactive Elements**: 
  - Floating action button with sparkle icons
  - Bottom navigation bar
  - Activity completion toggles
  - Header with notification and add buttons

## API Integration

The app is configured to work with the provided API endpoint:
```
https://api-intelligent.netscapelabs.com/aggregation/customer/common/activity
```

### Query Parameters
- `text`: Filter type (ALL, TASK, MEETING, EVENT)
- `page`: Page number for pagination
- `limit`: Number of items per page

### Authentication
Uses Bearer token authentication as provided in the API request.

## Data Source

The app uses **only real API data** from your server. No dummy or mock data is used in the UI.

### API Response Format
The app expects your API to return data in this format:
```json
{
    "success": true,
    "message": "Activities fetched successfully",
    "data": {
        "activities": [
            {
                "_id": "string",
                "name": "string",
                "description": "string",
                "type": "TASK|MEETING|EVENT",
                "priority": "LOW|MEDIUM|HIGH",
                "color": "string",
                "startTime": "ISO date string",
                "endTime": "ISO date string",
                "status": "ACTIVE|COMPLETED",
                "createdAt": "ISO date string",
                "updatedAt": "ISO date string"
            }
        ],
        "meta": {
            "page": number,
            "limit": number,
            "totalPages": number
        }
    },
    "code": 200
}
```

## UI Components

### HomeView
- Header with title and action buttons
- Activity summary card with statistics
- Horizontal filter tabs
- Scrollable activity list
- Floating action button
- Bottom navigation bar

### TaskDetailView
- Back navigation button
- Activity title in header
- Detail card with Date, Time, and Priority
- More options button

### ActivityRowView
- Completion toggle circle
- Activity type icon
- Title and date
- Time display
- Visual completion state
- Tap to view details

## Color Scheme

- **Background**: Black (#000000)
- **Primary Text**: White (#FFFFFF)
- **Secondary Text**: Gray (#808080)
- **Accent Colors**: 
  - Orange (#FF8C00)
  - Blue (#007AFF)
  - Purple (#8A2BE2)
  - Yellow (#FFD700)

## Getting Started

1. Open the project in Xcode
2. Build and run the project
3. The app will load real data from your API
4. Test the filter functionality by tapping different filter tabs (ALL, TASK, MEETING, EVENT)
5. Test the activity completion by tapping the circles
6. Tap any activity to view its details

## Features

- **Real-time data**: All activities are fetched from your live API
- **Filter functionality**: ALL, TASK, MEETING, EVENT tabs work with real data
- **Activity details**: Shows real activity information in detail view
- **Status tracking**: Shows completion status based on API data
- **Error handling**: Displays API error messages if connection fails
- **Loading states**: Shows loading indicator while fetching data

## Future Enhancements

- Add new activity creation
- Implement activity editing
- Add search functionality
- Implement push notifications
- Add offline support
- Implement real-time updates

## Dependencies

- SwiftUI (iOS 14.0+)
- Foundation
- No external dependencies required 