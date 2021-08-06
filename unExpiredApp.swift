import SwiftUI

@main
struct unExpiredApp: App {
    @ObservedObject private var data = ItemData()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(items: $data.items) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
