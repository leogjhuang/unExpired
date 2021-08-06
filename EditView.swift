import SwiftUI

struct EditView: View {
    @Binding private var itemData: Item.Data
    private var alertOptions = ["Day of expiry at 9:00 AM", "Day before expiry at 5:00 PM", "Day before expiry at 9:00 AM", "2 days before expiry at 9:00 AM", "1 week before expiry at 9:00 AM", "Custom"]
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimum = 0
        formatter.maximum = 999
        return formatter
    }()
    
    private func getAlertDayDifference() -> Int {
        switch itemData.alertOption {
        case "Day of expiry at 9:00 AM":
            return 0
        case "Day before expiry at 5:00 PM":
            return 1
        case "Day before expiry at 9:00 AM":
            return 1
        case "2 days before expiry at 9:00 AM":
            return 2
        case "1 week before expiry at 9:00 AM":
            return 7
        default:
            return itemData.alertDayDifference
        }
    }
    
    private func getAlertTime() -> Date {
        var alertTimeComponents = Calendar.current.dateComponents([.hour, .minute], from: itemData.alertTime)
        switch itemData.alertOption {
        case "Day of expiry at 9:00 AM":
            alertTimeComponents.hour = 9
            alertTimeComponents.minute = 0
        case "Day before expiry at 5:00 PM":
            alertTimeComponents.hour = 17
            alertTimeComponents.minute = 0
        case "Day before expiry at 9:00 AM":
            alertTimeComponents.hour = 9
            alertTimeComponents.minute = 0
        case "2 days before expiry at 9:00 AM":
            alertTimeComponents.hour = 9
            alertTimeComponents.minute = 0
        case "1 week before expiry at 9:00 AM":
            alertTimeComponents.hour = 9
            alertTimeComponents.minute = 0
        default:
            ()
        }
        return Calendar.current.date(from: alertTimeComponents) ?? itemData.alertTime
    }
    
    init(itemData: Binding<Item.Data>) {
        self._itemData = itemData
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Item Info")) {
                    TextField("Name", text: $itemData.name)
                        .accessibilityLabel(Text("Item name"))
                    DatePicker("Expiry date", selection: $itemData.expiryDate, displayedComponents: .date)
                        .accessibilityLabel(Text("Expiry date picker"))
                    ColorPicker("Color", selection: $itemData.color)
                        .accessibilityLabel(Text("Color picker"))
                    TextField("Notes", text: $itemData.notes)
                        .accessibilityLabel(Text("Notes"))
                }
                Section(header: Text("Item Reminders")) {
                    Picker("Alert date", selection: $itemData.alertOption) {
                        ForEach(alertOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .onChange(of: itemData.alertOption, perform: { value in
                        itemData.alertDayDifference = getAlertDayDifference()
                        itemData.alertTime = getAlertTime()
                    })
                    .accessibilityLabel(Text("Alert date picker"))
                    if itemData.alertOption == "Custom" {
                        HStack {
                            Text("Remind me")
                            TextField("Days before", value: $itemData.alertDayDifference, formatter: formatter)
                                .accessibilityLabel(Text("Number of days before"))
                            if itemData.alertDayDifference == 1 {
                                Text("day before at")
                            } else {
                                Text("days before at")
                            }
                        }
                        DatePicker("Alert time", selection: $itemData.alertTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .accessibilityLabel(Text("Expiry date picker"))
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            FooterView()
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(itemData: .constant(Item.data[0].data))
    }
}
