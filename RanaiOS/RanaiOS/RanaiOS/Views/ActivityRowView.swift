import SwiftUI

struct ActivityRowView: View {
    let activity: Activity
    let onToggle: () -> Void
    let onTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            // Completion Circle
            Button(action: onToggle) {
                ZStack {
                    Circle()
                        .stroke(activity.isCompleted ? Color.blue : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if activity.isCompleted {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 24, height: 24)
                        
                        Image(systemName: "checkmark")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
            }
            
            // Activity Icon
            Image(systemName: activity.type.icon)
                .font(.caption)
                .foregroundColor(.purple)
                .frame(width: 20, height: 20)
            
            // Activity Details
            VStack(alignment: .leading, spacing: 2) {
                Text(activity.title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .strikethrough(activity.isCompleted)
                
                Text(activity.date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Time
            Text(activity.time)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    Text("ActivityRowView - Use with real API data")
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
} 