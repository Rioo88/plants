//
//  NotificationManager.swift
//  plants
//
//  Created by RIOO on 01/06/1448 AH.
//
import Foundation
import UserNotifications

// 🔔 مسؤول الإشعارات
enum NotificationManager {

    // نطلب الإذن من المستخدم
    static func requestPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    // نسوي منبه لنبتة
    static func schedule(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body = "Hey! let's water your \(plant.name) 🪴"
        content.sound = .default

        let seconds = Double(plant.wateringDays.days) * 24 * 60 * 60

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: seconds,
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    // نلغي منبه نبتة
    static func cancel(for plant: Plant) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
    }
}
