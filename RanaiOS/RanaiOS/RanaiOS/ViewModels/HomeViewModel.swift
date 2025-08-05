import Foundation
import SwiftUI

 
class HomeViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    @Published var selectedFilter: ActivityFilter = .all
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var totalCount = 0
    @Published var completedCount = 0
    @Published var remainingCount = 0
    
    private let activityService = ActivityService()
    
    enum ActivityFilter: String, CaseIterable {
        case all = "ALL"
        case task = "TASK"
        case meeting = "MEETING"
        case event = "EVENT"
        
        var displayName: String {
            switch self {
            case .all: return "All"
            case .task: return "Task"
            case .meeting: return "Meeting"
            case .event: return "Event"
            }
        }
        
        var icon: String {
            switch self {
            case .all: return ""
            case .task: return "doc.text"
            case .meeting: return "person.2"
            case .event: return "calendar"
            }
        }
    }
    
    init() {
        Task {
            await fetchActivities()
        }
    }
    
    func fetchActivities() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await activityService.fetchActivities(text: selectedFilter.rawValue)
            
            if response.success {
                activities = response.data.activities
                updateCounts()
            } else {
                errorMessage = response.message
            }
        } catch {
            errorMessage = "Failed to load activities: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    private func updateCounts() {
        totalCount = activities.count
        completedCount = activities.filter { $0.isCompleted }.count
        remainingCount = activities.filter { !$0.isCompleted }.count
    }
    
    func selectFilter(_ filter: ActivityFilter) {
        selectedFilter = filter
        Task {
            await fetchActivities()
        }
    }
    
    func toggleActivityCompletion(_ activity: Activity) {
        print("Activity completion tapped...")
    }
} 
