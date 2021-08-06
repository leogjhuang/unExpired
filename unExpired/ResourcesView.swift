import SwiftUI

struct ResourcesView: View {
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Spacer()
                    ResourcesCardView(name: "Anxiety", imageCount: 9)
                    Spacer()
                    ResourcesCardView(name: "Best Before Date", imageCount: 5)
                    Spacer()
                }
                HStack {
                    Spacer()
                    ResourcesCardView(name: "Body Positivity", imageCount: 7)
                    Spacer()
                    ResourcesCardView(name: "Diet Fads", imageCount: 6)
                    Spacer()
                }
                HStack {
                    Spacer()
                    ResourcesCardView(name: "Earth Day", imageCount: 8)
                    Spacer()
                    ResourcesCardView(name: "Eating Disorders I", imageCount: 9)
                    Spacer()
                }
                HStack {
                    Spacer()
                    ResourcesCardView(name: "Eating Disorders II", imageCount: 9)
                    Spacer()
                    ResourcesCardView(name: "Eating Disorders III", imageCount: 9)
                    Spacer()
                }
                HStack {
                    Spacer()
                    ResourcesCardView(name: "Food Insecurity I", imageCount: 7)
                    Spacer()
                    ResourcesCardView(name: "Food Insecurity II", imageCount: 6)
                    Spacer()
                }
            }
            .navigationTitle("Resources")
            FooterView()
        }
    }
}

struct ResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ResourcesView()
    }
}
