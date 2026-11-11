//
//  PlantViewModel.swift
//  Planto
//
//  Created by RIOO on 01/06/1448 AH.
//

import Foundation
import Observation

// 👨‍🍳 ViewModel: المخ اللي يدير كل النباتات
@Observable
class PlantViewModel {
    var plants: [Plant] = []
    var hasStarted = false

    // 🆕 كم نبتة انسقت؟
    var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }

    // 🆕 هل خلصنا الكل؟
    var allDone: Bool {
        !plants.isEmpty && wateredCount == plants.count
    }

    // 🆕 النص اللي فوق الشريط
    var progressText: String {
        wateredCount == 0
        ? "Your plants are waiting for a sip 💦"
        : "\(wateredCount) of your plants feel loved today ✨"
    }

    init() {
        load()
        resetIfNewDay()
    }

    func add(_ plant: Plant) {
        plants.append(plant)
        hasStarted = true
        save()
        NotificationManager.requestPermission()
        NotificationManager.schedule(for: plant)
    }

    func update(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index] = plant
            save()
            NotificationManager.schedule(for: plant)
        }
    }

    func toggleWatered(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWatered.toggle()
            save()
        }
    }

    func delete(_ plant: Plant) {
        NotificationManager.cancel(for: plant)
        plants.removeAll { $0.id == plant.id }
        save()
    }

    func resetIfNewDay() {
        let lastReset = UserDefaults.standard.object(forKey: "lastReset") as? Date ?? Date()

        if !Calendar.current.isDateInToday(lastReset) {
            for index in plants.indices {
                plants[index].isWatered = false
            }
            save()
        }

        UserDefaults.standard.set(Date(), forKey: "lastReset")
    }

    private func save() {
        if let data = try? JSONEncoder().encode(plants) {
            UserDefaults.standard.set(data, forKey: "plants")
        }
        UserDefaults.standard.set(hasStarted, forKey: "hasStarted")
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: "plants"),
           let saved = try? JSONDecoder().decode([Plant].self, from: data) {
            plants = saved
        }
        hasStarted = UserDefaults.standard.bool(forKey: "hasStarted")
    }
}
