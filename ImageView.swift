import SwiftUI

struct ImageView: View {
    private var name: String
    private var imageCount: Int
    private var images: [String]
    
    init(name: String, imageCount: Int) {
        self.name = name
        self.imageCount = imageCount
        self.images = []
        for index in 1...imageCount {
            images.append("\(name)/\(index)")
        }
    }
    
    var body: some View {
        List {
            ForEach(images, id: \.self) { image in
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .navigationTitle(name)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(name: "", imageCount: 0)
    }
}
