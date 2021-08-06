import Foundation

class ItemData: ObservableObject {
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("items.data")
    }
    @Published var items: [Item] = []
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.items = Item.data
                }
                #endif
                return
            }
            guard let itemData = try? JSONDecoder().decode([Item].self, from: data) else {
                fatalError("Can't decode saved item data.")
            }
            DispatchQueue.main.async {
                self?.items = itemData
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let items = self?.items else {
                fatalError("Self out of scope.")
            }
            guard let data = try? JSONEncoder().encode(items) else {
                fatalError("Error encoding data.")
            }
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write to file.")
            }
        }
    }
}
