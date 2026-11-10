//
//  SetReminderView.swift
//  plants
//
//  Created by RIOO on 29/05/1448 AH.
//

import SwiftUI

struct SetReminderView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(PlantStore.self) var store      // 🆕 ١

    @State private var plantName = ""
    @State private var room = Room.bedroom
    @State private var light = Light.fullSun
    @State private var wateringDays = WateringDays.everyDay
    @State private var water = WaterAmount.ml20to50

    var body: some View {
        NavigationStack {

            Form {
                // ١. اسم النبتة
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $plantName)
                    }
                }

                // ٢. الغرفة والإضاءة
                Section {
                    Picker("Room", selection: $room) {
                        ForEach(Room.allCases, id: \.self) { room in
                            Text(room.rawValue)
                        }
                    }

                    Picker("Light", selection: $light) {
                        ForEach(Light.allCases, id: \.self) { light in
                            Text(light.rawValue)
                        }
                    }
                }

                // ٣. السقي والماء
                Section {
                    Picker("Watering Days", selection: $wateringDays) {
                        ForEach(WateringDays.allCases, id: \.self) { days in
                            Text(days.rawValue)
                        }
                    }

                    Picker("Water", selection: $water) {
                        ForEach(WaterAmount.allCases, id: \.self) { amount in
                            Text(amount.rawValue)
                        }
                    }
                }
            }
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                // زر الإلغاء ✕
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }

                // زر الحفظ ✓
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        // 🆕 ٢: نسوي ورقة النبتة الجديدة
                        let newPlant = Plant(
                            name: plantName,
                            room: room,
                            light: light,
                            wateringDays: wateringDays,
                            water: water
                        )
                        // 🆕 ٣: نحطها في الدفتر
                        store.add(newPlant)
                        // ونسكر الشاشة
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .tint(Color("PlantsGreen"))
                    .disabled(plantName.isEmpty)     // 🆕 ٤
                }
            }
        }
    }
}

#Preview {
    SetReminderView()
        .environment(PlantStore())                // 🆕 ٥
}
