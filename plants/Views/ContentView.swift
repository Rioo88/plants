


import SwiftUI

struct ContentView: View {

    @State private var store = PlantViewModel()
    @State private var showSplash = true

    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        Group {
            if showSplash {
                SplashView()
            } else if store.hasStarted {
                RemindersView()
            } else {
                OnboardingView()
            }
        }
        .environment(store)
        .task {
            try? await Task.sleep(for: .seconds(2))
            withAnimation {
                showSplash = false
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                store.resetIfNewDay()
            }
        }
    }
}

#Preview {
    ContentView()
}
