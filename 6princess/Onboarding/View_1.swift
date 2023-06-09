import SwiftUI

struct View_1: View {
    @State var name : String = ""
    @State var userInformation: UserInformation
    @State var viewController: ViewController
    var body: some View {
        
        ZStack{
            Color.clear
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 158)
                HStack {
                    Text("이름을 입력해주세요")
                        .font(.system(size: 30, weight: .semibold))
//                        .border(Color.black, width: 1)
                        .frame(alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.bottom, 36)
                    Spacer()
                }
                TextField("이름", text: $name)
//                    .border(Color.black, width: 1)
                    .padding(.leading, 34)
                    .font(.system(size: 18, weight: .medium))
                Divider()
                    .frame(minHeight: 1.5)
                    .overlay(Color(hex: 0xD8D8D8))
                    .padding([.leading, .trailing], 30)
                    .padding(.top, 5)
                    
                    
                Spacer()
                NextButtonView()
                    .onTapGesture {
                        userInformation.name = name
                        viewController.currentPage += 1
                       //UserDefaults 삽입
                    }
                BottomCircleView(viewCount: 1)
                Spacer()
                    .frame(height: 52)
            }
        }
        .ignoresSafeArea()
        
    }

}

struct View_1_Previews: PreviewProvider {
    static var previews: some View {
        View_1(userInformation: UserInformation(), viewController: ViewController())
    }
}

