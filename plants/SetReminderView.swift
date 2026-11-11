//
//  SetReminderView.swift
//  plants
//
//  Created by RIOO on 29/05/1448 AH.
//

import SwiftUI

struct SetReminderView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(PlantStore.self) var store

    // 🆕 ١: النبتة اللي نعدلها (إذا فاضي = إضافة جديدة)
    var plantToEdit: Plant? = nil

    @State private var plantName = ""
    @State private var room = Room.bedroom
    @State private var light = Light.fullSun
    @State private var wateringDays = WateringDays.everyDay
    @State private var water = WaterAmount.ml20to50

    var body: some View {
        NavigationStack {

            Form {
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $plantName)
                    }
                }

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

                // 🆕 ٢: زر الحذف يطلع بس وقت التعديل
                if let plant = plantToEdit {
                    Section {
                        Button(role: .destructive) {
                            store.delete(plant)
                            dismiss()
                        } label: {
                            Text("Delete Reminder")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        save()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .tint(Color("PlantsGreen"))
                    .disabled(plantName.isEmpty)
                }
            }
            // 🆕 ٣: لما تنفتح الشاشة، عبّي المعلومات
            .onAppear {
                if let plant = plantToEdit {
                    plantName = plant.name
                    room = plant.room
                    light = plant.light
                    wateringDays = plant.wateringDays
                    water = plant.water
                }
            }
        }
    }

    // 🆕 ٤: الحفظ (تعديل أو إضافة)
    func save() {
        if var plant = plantToEdit {
            // تعديل: نغير معلومات النبتة الموجودة
            plant.name = plantName
            plant.room = room
            plant.light = light
            plant.wateringDays = wateringDays
            plant.water = water
            store.update(plant)
        } else {
            // إضافة: نسوي نبتة جديدة
            let newPlant = Plant(
                name: plantName,
                room: room,
                light: light,
                wateringDays: wateringDays,
                water: water
            )
            store.add(newPlant)
        }
        dismiss()
    }
}

#Preview {
    SetReminderView()
        .environment(PlantStore())
}
