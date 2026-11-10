


import SwiftUI

struct ContentView: View {

    @State private var store = PlantStore()

    var body: some View {
        Group {
            if store.plants.isEmpty {
                OnboardingView()
            } else {
                RemindersView()
            }
        }
        .environment(store)
    }
}

#Preview {
    ContentView()
}
