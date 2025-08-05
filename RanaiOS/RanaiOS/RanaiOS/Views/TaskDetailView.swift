import SwiftUI

struct TaskDetailView: View {
    @Binding var activity: Activity?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header/Navigation Bar
                headerView
                
                // Main Content
                ScrollView {
                    VStack(spacing: 20) {
                        // Task Details Card
                        taskDetailsCard
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Spacer()
            
            Text(activity?.title ?? "")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: {
                // More options action
            }) {
                Image(systemName: "ellipsis")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    private var taskDetailsCard: some View {
        VStack(spacing: 0) {
            // Date Section
            detailRow(
                icon: "calendar",
                label: "Date",
                value: activity?.date ?? ""
            )
            
            Divider()
                .background(Color.gray.opacity(0.3))
            
            // Time Section
            detailRow(
                icon: "clock",
                label: "Time",
                value: activity?.time ?? ""
            )
            
            Divider()
                .background(Color.gray.opacity(0.3))
            
            // Priority Section
            detailRow(
                icon: nil,
                label: "Priority",
                value: activity?.priority?.displayName ?? "N/A"
            )
            
            // Empty space for additional details
            Spacer()
                .frame(height: 100)
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(16)
    }
    
    private func detailRow(icon: String?, label: String, value: String) -> some View {
        HStack(spacing: 12) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.body)
                    .foregroundColor(.gray)
                    .frame(width: 20, height: 20)
            } else {
                // Empty space for alignment when no icon
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 20, height: 20)
            }
            
            Text(label)
                .font(.body)
                .foregroundColor(.white)
            
            Spacer()
            
            Text(value)
                .font(.body)
                .foregroundColor(.white)
                .fontWeight(.medium)
        }
        .padding(.vertical, 16)
    }
}
