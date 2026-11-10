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

    // تبدل حالة السقي: ○ ↔ ✅
    func toggleWatered(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWatered.toggle()
        }
    }
}
