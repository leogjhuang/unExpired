import SwiftUI

struct FooterView: View {
    var body: some View {
        ZStack {
            Color("CustomBlack").ignoresSafeArea()
            HStack {
                Image("Logo")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.height / 15, height: UIScreen.main.bounds.height / 15)
                    .padding()
                Text("unExpired, a JA Company")
                    .foregroundColor(Color("CustomWhite"))
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10)
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
