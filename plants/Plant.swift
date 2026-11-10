//
//  Plant.swift
//  plants
//
//  Created by RIOO on 30/05/1448 AH.
//
import Foundation
import Observation

// 🪴 الورقة: معلومات نبتة وحدة
struct Plant: Identifiable {
    let id = UUID()
    var name: String
    var room: Room
    var light: Light
    var wateringDays: WateringDays
    var water: WaterAmount
    var isWatered = false
}

// 📒 الدفتر: فيه كل النباتات
@Observable
class PlantStore {
    var plants: [Plant] = []

    // 🆕 هل المستخدم بدأ يستخدم التطبيق؟
    var hasStarted = false

    // 🆕 تضيف نبتة وتتذكر إن المستخدم بدأ
    func add(_ plant: Plant) {
        plants.append(plant)
        hasStarted = true
    }

    // تبدل حالة السقي: ○ ↔ ✅
    func toggleWatered(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWatered.toggle()
        }
    }

    // تحذف نبتة 🗑️
    func delete(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
    }
}
