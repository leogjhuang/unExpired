import SwiftUI

struct HomeView: View {
    @Binding var items: [Item]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresented = false
    @State private var newItemData = Item.Data()
    let saveAction: () -> Void
    
    private func binding(for item: Item) -> Binding<Item> {
        guard let itemIndex = items.firstIndex(where: { $0.id == item.id }) else {
            fatalError("Can't find item in array")
        }
        return $items[itemIndex]
    }
    
    private func onDelete(offsets: IndexSet) {
        offsets.sorted(by: >).forEach { index in
            items[index].cancelNotification()
        }
        items.remove(atOffsets: offsets)
    }
        
    private func onMove(source: IndexSet, destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    init(items: Binding<[Item]>, saveAction: @escaping () -> Void) {
        self._items = items
        self.saveAction = saveAction
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: DetailView(item: binding(for: item))) {
                        CardView(item: item)
                    }
                    .listRowBackground(item.color)
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Your Items")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink(destination: ResourcesView()) {
                        Image(systemName: "lightbulb")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresented = true
                    }) {
                        Image(systemName: "plus")
                    }
                    EditButton()
                }
            }
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    EditView(itemData: $newItemData)
                        .navigationBarItems(leading: Button("Dismiss") {
                            isPresented = false
                        }, trailing: Button("Add") {
                            let newItem = Item(name: newItemData.name, expiryDate: newItemData.expiryDate, color: newItemData.color, notes: newItemData.notes, alertOption: newItemData.alertOption, alertDayDifference: newItemData.alertDayDifference, alertTime: newItemData.alertTime)
                            items.append(newItem)
                            isPresented = false
                        })
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
            FooterView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(items: .constant(Item.data), saveAction: {})
    }
}
