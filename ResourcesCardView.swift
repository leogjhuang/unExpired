import SwiftUI

struct ResourcesCardView: View {
    private var name: String
    private var imageCount: Int
    
    init(name: String, imageCount: Int) {
        self.name = name
        self.imageCount = imageCount
    }
    
    var body: some View {
        NavigationLink(destination: ImageView(name: name, imageCount: imageCount)) {
            Image("\(name)/1")
                .resizable()
        }
        .cornerRadius(25)
        .aspectRatio(contentMode: .fit)
    }
}

struct ResourcesCardView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcesCardView(name: "", imageCount: 0)
    }
}
