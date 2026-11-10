//
//  PlantOptions.swift
//  plants
//
//  Created by RIOO on 30/05/1448 AH.
//

import Foundation

enum Room: String, CaseIterable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
}

enum Light: String, CaseIterable {
    case fullSun = "Full Sun"
    case partialSun = "Partial Sun"
    case lowLight = "Low Light"
}

enum WateringDays: String, CaseIterable {
    case everyDay = "Every day"
    case every2Days = "Every 2 days"
    case every3Days = "Every 3 days"
    case onceAWeek = "Once a week"
    case every10Days = "Every 10 days"
    case every2Weeks = "Every 2 weeks"
}

enum WaterAmount: String, CaseIterable {
    case ml20to50 = "20-50 ml"
    case ml50to100 = "50-100 ml"
    case ml100to200 = "100-200 ml"
    case ml200to300 = "200-300 ml"
}
