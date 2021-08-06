import SwiftUI

struct Item: Identifiable, Codable {
    let id: UUID
    var name: String
    var expiryDate: Date
    var color: Color
    var notes: String
    var alertOption: String
    var alertDayDifference: Int
    var alertTime: Date
    
    init(id: UUID = UUID(), name: String, expiryDate: Date, color: Color, notes: String, alertOption: String, alertDayDifference: Int, alertTime: Date) {
        self.id = id
        self.name = name
        self.expiryDate = expiryDate
        self.color = color
        self.notes = notes
        self.alertOption = alertOption
        self.alertDayDifference = alertDayDifference
        self.alertTime = alertTime
    }
}

extension Item {
    static var data: [Item] {
        [
            Item(name: "Bananas", expiryDate: Date(timeIntervalSinceNow: 60*60*24*0), color: Color.yellow, notes: "", alertOption: "Custom", alertDayDifference: 1, alertTime: Date()),
            Item(name: "Avocadoes", expiryDate: Date(timeIntervalSinceNow: 60*60*24*1), color: Color.green, notes: "", alertOption: "Custom", alertDayDifference: 1, alertTime: Date()),
            Item(name: "Strawberries", expiryDate: Date(timeIntervalSinceNow: 60*60*24*3), color: Color.red, notes: "", alertOption: "Custom", alertDayDifference: 1, alertTime: Date()),
            Item(name: "Blueberries", expiryDate: Date(timeIntervalSinceNow: 60*60*24*5), color: Color.blue, notes: "", alertOption: "Custom", alertDayDifference: 1, alertTime: Date()),
            Item(name: "Oranges", expiryDate: Date(timeIntervalSinceNow: 60*60*24*7), color: Color.orange, notes: "", alertOption: "Custom", alertDayDifference: 1, alertTime: Date()),
            Item(name: "Lipstick", expiryDate: Date(timeIntervalSinceNow: 60*60*24*30), color: Color.pink, notes: "", alertOption: "Custom", alertDayDifference: 1, alertTime: Date()),
            Item(name: "Prescription", expiryDate: Date(timeIntervalSinceNow: 60*60*24*60), color: Color.purple, notes: "", alertOption: "Custom", alertDayDifference: 1, alertTime: Date()),
            Item(name: "Mascara", expiryDate: Date(timeIntervalSinceNow: 60*60*24*90), color: Color.black, notes: "", alertOption: "Custom", alertDayDifference: 1, alertTime: Date())
        ]
    }
}

extension Item {
    struct Data {
        var name: String = ""
        var expiryDate: Date = Date(timeIntervalSinceNow: 604800)
        var color: Color = .random
        var notes: String = ""
        var alertOption: String = "Custom"
        var alertDayDifference: Int = 1
        var alertTime: Date = Date()
    }
    
    var data: Data {
        return Data(name: name, expiryDate: expiryDate, color: color, notes: notes, alertOption: alertOption, alertDayDifference: alertDayDifference, alertTime: alertTime)
    }
    
    mutating func update(from data: Data) {
        name = data.name
        expiryDate = data.expiryDate
        color = data.color
        notes = data.notes
        alertOption = data.alertOption
        alertDayDifference = data.alertDayDifference
        alertTime = data.alertTime
        cancelNotification()
        scheduleNotification()
    }
}

extension Item {
    func getAlertDateComponents() -> DateComponents {
        let alertDate = Calendar.current.date(byAdding: DateComponents(day: -alertDayDifference), to: expiryDate)!
        var alertDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: alertDate)
        alertDateComponents.hour = Calendar.current.component(.hour, from: alertTime)
        alertDateComponents.minute = Calendar.current.component(.minute, from: alertTime)
        return alertDateComponents
    }
    
    func formatDate(format: String, date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if date == "expiryDate" {
            return formatter.string(from: expiryDate)
        }
        return formatter.string(from: Calendar.current.date(from: getAlertDateComponents())!)
    }
}

extension Item {
    func scheduleNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if error != nil {
                fatalError("Authorization was unable to be granted. Please enable notifications in settings.")
            }
        }
        let content = UNMutableNotificationContent()
        content.title = "About to expire: \(name)"
        content.body = "Your item expires on \(formatDate(format: "E, MMM d, y", date: "expiryDate"))"
        content.sound = UNNotificationSound.default
        let trigger = UNCalendarNotificationTrigger(dateMatching: getAlertDateComponents(), repeats: false)
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    func cancelNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }
}
