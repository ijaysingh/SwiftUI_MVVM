import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedActivity: Activity?
    @State private var showingDetail = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    headerView
                    
                    if viewModel.isLoading {
                        loadingView
                    } else if let errorMessage = viewModel.errorMessage {
                        errorView(message: errorMessage)
                    } else {
                        ScrollView {
                            VStack(spacing: 20) {
                                // Activity Summary Card
                                activitySummaryCard
                                
                                // Filter Tabs
                                filterTabsView
                                
                                // Activities List...
                                activitiesListView
                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 100)
                        }
                    }
                }
                
                // Floating Action Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        floatingActionButton
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 100)
                }
            }
            .navigationBarHidden(true)
        }
        .overlay(
            // Bottom Navigation
            VStack {
                Spacer()
                bottomNavigationView
            }
        )
        .sheet(isPresented: $showingDetail) {
//            if let activity = self.selectedActivity {
                TaskDetailView(activity: $selectedActivity)
//            }
        }
    }
    
    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(1.5)
            Text("Loading activities...")
                .foregroundColor(.white)
                .padding(.top, 20)
            Spacer()
        }
    }
    
    private func errorView(message: String) -> some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                
                Text("Error")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(message)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Button("Retry") {
                    Task {
                        await viewModel.fetchActivities()
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .cornerRadius(8)
            }
            .padding()
            Spacer()
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Home")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            HStack(spacing: 15) {
                Button(action: {
                    // Notification action
                }) {
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(Circle())
                }
                
                Button(action: {
                    // Add new activity action
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.orange)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, 10)
    }
    
    private var activitySummaryCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                Text("You have \(viewModel.totalCount) Activities today")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                HStack(spacing: 10) {
                    Text("\(viewModel.completedCount) Completed")
                        .font(.caption)
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.yellow.opacity(0.8))
                        .cornerRadius(12)
                    
                    Text("\(viewModel.remainingCount) Remaining")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.orange.opacity(0.8))
                        .cornerRadius(12)
                }
            }
            
            Spacer()
            
            // Illustration placeholder
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.yellow.opacity(0.8))
                    .frame(width: 80, height: 80)
                
                VStack(spacing: 2) {
                    Image(systemName: "leaf.fill")
                        .foregroundColor(.teal)
                        .font(.title2)
                    Image(systemName: "bird.fill")
                        .foregroundColor(.black)
                        .font(.title3)
                }
            }
        }
        .padding(20)
        .background(Color.orange.opacity(0.9))
        .cornerRadius(20)
    }
    
    private var filterTabsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(HomeViewModel.ActivityFilter.allCases, id: \.self) { filter in
                    Button(action: {
                        viewModel.selectFilter(filter)
                    }) {
                        HStack(spacing: 6) {
                            if !filter.icon.isEmpty {
                                Image(systemName: filter.icon)
                                    .font(.caption)
                            }
                            Text(filter.displayName)
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(viewModel.selectedFilter == filter ? .white : .white.opacity(0.7))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(viewModel.selectedFilter == filter ? Color.blue : Color.clear)
                        .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }
    
    private var activitiesListView: some View {
        LazyVStack(spacing: 12) {
            ForEach(viewModel.activities) { activity in
                ActivityRowView(
                    activity: activity,
                    onToggle: {
                        viewModel.toggleActivityCompletion(activity)
                    },
                    onTap: {
                        selectedActivity = activity
                        showingDetail = true
                    }
                )
            }
        }
    }
    
    private var floatingActionButton: some View {
        Button(action: {
            // Magic/AI action
        }) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 56, height: 56)
                    .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
                
                HStack(spacing: 2) {
                    Image(systemName: "sparkles")
                        .foregroundColor(.blue)
                        .font(.caption)
                    Image(systemName: "sparkles")
                        .foregroundColor(.blue)
                        .font(.caption)
                }
            }
        }
    }
    
    private var bottomNavigationView: some View {
        HStack(spacing: 0) {
            ForEach(BottomTabItem.allCases, id: \.self) { item in
                Button(action: {
                    // Navigation action
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: item.icon)
                            .font(.title2)
                            .foregroundColor(item == .home ? .white : .white.opacity(0.6))
                        
                        Text(item.title)
                            .font(.caption2)
                            .foregroundColor(item == .home ? .white : .white.opacity(0.6))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.black)
    }
}

enum BottomTabItem: CaseIterable {
    case home, calendar, projects, settings
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .calendar: return "calendar"
        case .projects: return "doc.text"
        case .settings: return "gearshape"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .calendar: return "Calendar"
        case .projects: return "Projects"
        case .settings: return "Settings"
        }
    }
}

#Preview {
    HomeView()
}
