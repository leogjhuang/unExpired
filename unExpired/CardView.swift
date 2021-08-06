import SwiftUI

struct CardView: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.headline)
            Spacer()
            HStack {
                Label(item.formatDate(format: "MMM d, yyyy", date: "expiryDate"), systemImage: "clock")
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Expiry date"))
                    .accessibilityValue(Text(item.formatDate(format: "MMM d, yyyy", date: "expiryDate")))
            }
            if Calendar.current.isDateInTomorrow(item.expiryDate) {
                Spacer()
                Label("Expires tomorrow!", systemImage: "star")
                    .font(.subheadline)
                    .accessibilityElement(children: .ignore)
            } else if Calendar.current.isDateInToday(item.expiryDate) {
                Spacer()
                Label("Expires today!", systemImage: "star")
                    .font(.subheadline)
                    .accessibilityElement(children: .ignore)
            } else if item.expiryDate < Date() {
                Spacer()
                Label("Expired!", systemImage: "star")
                    .font(.subheadline)
                    .accessibilityElement(children: .ignore)
            }
        }
        .padding()
        .foregroundColor(item.color.accessibleFontColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var item = Item.data[0]
    static var previews: some View {
        CardView(item: item)
            .background(item.color)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
