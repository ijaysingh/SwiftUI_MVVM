import Foundation

struct Activity: Identifiable, Codable {
    let id: String
    let title: String
    let description: String?
    let type: ActivityType
    let priority: Priority?
    let color: String?
    let startTime: String
    let endTime: String?
    let status: String
    let createdAt: String
    let updatedAt: String
    
    var date: String {
        formatDate(startTime)
    }
    
    var time: String {
        formatTime(startTime)
    }
    
    var isCompleted: Bool {
        status == "COMPLETED"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title = "name"
        case description
        case type
        case priority
        case color
        case startTime
        case endTime
        case status
        case createdAt
        case updatedAt
    }
    
    enum ActivityType: String, Codable, CaseIterable {
        case task = "TASK"
        case meeting = "MEETING"
        case event = "EVENT"
        
        var displayName: String {
            switch self {
            case .task: return "Task"
            case .meeting: return "Meeting"
            case .event: return "Event"
            }
        }
        
        var icon: String {
            switch self {
            case .task: return "doc.text"
            case .meeting: return "person.2"
            case .event: return "calendar"
            }
        }
    }
    
    enum Priority: String, Codable, CaseIterable {
        case low = "LOW"
        case medium = "MEDIUM"
        case high = "HIGH"
        
        var displayName: String {
            return self.rawValue
        }
    }
    
    // Helper functions to format dates
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MMM d, yyyy"
            return displayFormatter.string(from: date)
        }
        return "Unknown Date"
    }
    
    private func formatTime(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "HH:mm"
            return displayFormatter.string(from: date)
        }
        return "Unknown Time"
    }
}

struct ActivityResponse: Codable {
    let success: Bool
    let message: String
    let data: ActivityData
    let code: Int
}

struct ActivityData: Codable {
    let activities: [Activity]
}

struct ActivityMeta: Codable {
    let page: Int
    let limit: Int
    let totalPages: Int
} 
