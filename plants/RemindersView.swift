//
//  RemindersView.swift
//  plants
//
//  Created by RIOO on 30/05/1448 AH.
//

import SwiftUI

// 📋 الشاشة الرئيسية
struct RemindersView: View {

    @Environment(PlantStore.self) var store

    @State private var showSheet = false

    var wateredCount: Int {
        store.plants.filter { $0.isWatered }.count
    }

    var allDone: Bool {
        !store.plants.isEmpty && wateredCount == store.plants.count
    }

    var body: some View {
        VStack(alignment: .leading) {

            Text("My Plants 🌱")
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)

            Divider()

            // 🆕 الحالة ١: الدفتر فاضي
            if store.plants.isEmpty {
                Spacer()
                Text("No reminders set yet..")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                Spacer()

            // الحالة ٢: كلها انسقت
            } else if allDone {
                AllDoneView()

            // الحالة ٣: القائمة
            } else {
                VStack(spacing: 10) {
                    Text(wateredCount == 0
                         ? "Your plants are waiting for a sip 💦"
                         : "\(wateredCount) of your plants feel loved today ✨")
                        .font(.subheadline)

                    ProgressView(value: Double(wateredCount),
                                 total: Double(store.plants.count))
                        .tint(Color("PlantsGreen"))
                }
                .frame(maxWidth: .infinity)
                .padding()

                List {
                    ForEach(store.plants) { plant in
                        PlantRow(plant: plant) {
                            store.toggleWatered(plant)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    store.delete(plant)
                                }
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                showSheet = true
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color("PlantsGreen"))
                    .clipShape(Circle())
            }
            .padding()
        }
        .sheet(isPresented: $showSheet) {
            SetReminderView()
        }
    }
}

// 🪴 صف نبتة وحدة
struct PlantRow: View {

    let plant: Plant
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {

            Button {
                withAnimation {
                    onToggle()
                }
            } label: {
                Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundStyle(plant.isWatered ? Color("PlantsGreen") : .secondary)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 6) {

                Label("in \(plant.room.rawValue)", systemImage: "location")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(plant.name)
                    .font(.title3)

                HStack {
                    Label(plant.light.rawValue, systemImage: "sun.max")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(Capsule())

                    Label(plant.water.rawValue, systemImage: "drop")
                        .font(.caption)
                        .foregroundStyle(.cyan)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(Capsule())
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let store = PlantStore()

    store.plants.append(
        Plant(name: "Monstera",
              room: .kitchen,
              light: .fullSun,
              wateringDays: .everyDay,
              water: .ml20to50)
    )

    store.plants.append(
        Plant(name: "Pothos",
              room: .bedroom,
              light: .partialSun,
              wateringDays: .every2Days,
              water: .ml50to100)
    )

    return RemindersView()
        .environment(store)
}
