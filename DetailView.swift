import SwiftUI

struct DetailView: View {
    @Binding var item: Item
    @State private var data: Item.Data = Item.Data()
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Item Info")) {
                    HStack {
                        Label("Expiry date", systemImage: "clock")
                            .accessibilityLabel(Text("Expiry date"))
                        Spacer()
                        Text(item.formatDate(format: "MMM d, yyyy", date: "expiryDate"))
                    }
                    HStack {
                        Label("Color", systemImage: "paintpalette")
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(item.color)
                    }
                    .accessibilityElement(children: .ignore)
                    HStack {
                        Label("Notes", systemImage: "person")
                        Spacer()
                        Text(item.notes)
                    }
                }
                Section(header: Text("Item Reminders")) {
                    HStack {
                        Label("Alert date", systemImage: "calendar")
                        Spacer()
                        Text(item.formatDate(format: "MMM d, yyyy", date: "alertDate"))
                    }
                    HStack {
                        Label("Alert time", systemImage: "hourglass")
                        Spacer()
                        Text(item.formatDate(format: "h:mm a", date: "alertDate"))
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarItems(trailing: Button("Edit") {
                isPresented = true
                data = item.data
            })
            .navigationTitle(item.name)
            .fullScreenCover(isPresented: $isPresented) {
                NavigationView {
                    EditView(itemData: $data)
                        .navigationTitle(item.name)
                        .navigationBarItems(leading: Button("Cancel") {
                            isPresented = false
                        }, trailing: Button("Done") {
                            isPresented = false
                            item.update(from: data)
                        })
                }
            }
            FooterView()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: .constant(Item.data[0]))
    }
}
