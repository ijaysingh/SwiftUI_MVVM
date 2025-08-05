import Foundation

class ActivityService {
    private let baseURL = "https://api-intelligent.netscapelabs.com/aggregation/customer/common/activity"
    private let authToken = "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2ODYzOGExNjdlMTFiM2JiODFmNGI3YmYiLCJfcm9sZSI6IjY4MWIzMDA4MDgxYjM1Nzg2NjkzYTVmYyIsInR5cGUiOiJDVVNUT01FUiIsIl9zZXNzaW9uIjoiNjg2NTBhZDVlMjRlMGM1MjA4MGYzOGY2IiwiaWF0IjoxNzU0MDUzNjQxLCJleHAiOjE3NTY2NDU2NDEsImp0aSI6IjYzZDFjZjIwLTc3ZWMtNDY4Ny1hOWE4LTk0NTk0YTgzNjY0NiJ9.hfFu_CQ_y3VG_MLFAxYTMhLWpnGcL6N0-OTX5Yj87MWbfWU1diccIYPmxe0zabqcEkOuTFmurtJ2CHeJVLg-aAMH719sutbkiRDuoBbmP5eXknhClkN71T3YI6nUDTPT57efdwgx1vrG4GKZ64KJtigLDGEkGypFPYKCqGTwHI8IIWvUBNJqIKJ4ZUL-1pFK9bGUoixKjSpZc8eZqz6mioOLMeQ5tYUun08uw5nofC3X1XtK30ZytcjGopjYsa_00MQ_D7oV2nUQ9ZAfrtsmcJL2wyLJGmnrEigtvkpzbgzbJAFLVrMyqhOEwr-9YGyfRcwh9SJlLFqqfwwaC4lEsA"
    
    func fetchActivities(text: String = "ALL", page: Int = 1, limit: Int = 10) async throws -> ActivityResponse {
        guard let url = URL(string: "\(baseURL)?text=\(text)&page=\(page)&limit=\(limit)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue(authToken, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let activityResponse = try JSONDecoder().decode(ActivityResponse.self, from: data)
            return activityResponse
        } catch {
            throw NetworkError.decodingError
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
} 
