//
//  SetReminderView.swift
//  plants
//
//  Created by RIOO on 29/05/1448 AH.
//

import SwiftUI

struct SetReminderView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(PlantViewModel.self) var store

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
                    Picker(selection: $room) {
                        ForEach(Room.allCases, id: \.self) { room in
                            Text(room.rawValue)
                        }
                    } label: {
                        Label("Room", systemImage: "location")
                    }

                    Picker(selection: $light) {
                        ForEach(Light.allCases, id: \.self) { light in
                            Label(light.rawValue, systemImage: light.icon)
                        }
                    } label: {
                        Label("Light", systemImage: "sun.max")
                    }
                }

                Section {
                    Picker(selection: $wateringDays) {
                        ForEach(WateringDays.allCases, id: \.self) { days in
                            Text(days.rawValue)
                        }
                    } label: {
                        Label("Watering Days", systemImage: "drop")
                    }

                    Picker(selection: $water) {
                        ForEach(WaterAmount.allCases, id: \.self) { amount in
                            Text(amount.rawValue)
                        }
                    } label: {
                        Label("Water", systemImage: "drop")
                    }
                }

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
            .tint(Color("PlantsGreen"))
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
                    .buttonStyle(.borderedProminent)
                    .tint(Color("PlantsGreen"))
                    .disabled(plantName.isEmpty)
                }
            }
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

    func save() {
        if var plant = plantToEdit {
            plant.name = plantName
            plant.room = room
            plant.light = light
            plant.wateringDays = wateringDays
            plant.water = water
            store.update(plant)
        } else {
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
        .environment(PlantViewModel())
}
