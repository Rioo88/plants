


import SwiftUI

struct ContentView: View {

    @State private var store = PlantStore()
    @State private var showSplash = true          // 🆕 ١

    var body: some View {
        Group {
            if showSplash {                       // 🆕 ٢
                SplashView()
            } else if store.hasStarted {
                RemindersView()
            } else {
                OnboardingView()
            }
        }
        .environment(store)
        .task {                                   // 🆕 ٣
            try? await Task.sleep(for: .seconds(2))
            withAnimation {
                showSplash = false
            }
        }
    }
}

#Preview {
    ContentView()
}
