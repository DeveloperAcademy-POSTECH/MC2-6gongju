import SwiftUI

struct View_4: View {
    let dbHelper = DBHelper.shared
    @State private var  currentLine :[CGPoint] = []
    @State private var lines : [[CGPoint]] = []
    @State var userInformation: UserInformation
    @State var viewController: ViewController
    @State var questionData: QuestionData
    
    var body: some View {
        ZStack {
            Color.clear
            
            BackBottonView(viewController: viewController)
                .offset(y:-361)
            
            VStack(spacing:0){
                Spacer()
                    .frame(height: 90)
                
                //Title
                HStack {
                    Text("나에게 은퇴 선물을 줄\n가족에게 동의를 받아보세요")
                        .font(.system(size: 30, weight: .semibold))
                        .lineSpacing(4)
                        .padding(.leading, 30)
                    Spacer()
                }
                .padding(.bottom, 12)
                //Description
                HStack {
                    Text("20개의 할 일을 완료하고, 은퇴 선물을 받아보세요")
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex: 0x636366))
                        .padding(.leading, 30)
                    Spacer()
                }
                .padding(.bottom, 88)
                
                //Sign
                ZStack{
                    
                    VStack{
                        Canvas{ context, size in
                            for line in lines {
                                var path = Path()
                                path.addLines(line)
                                context.stroke(path, with: .color(Color.black), lineWidth: 1)
                            }
                            
                            
                        }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged{value in
                                let newPoint = value.location
                                currentLine.append(newPoint)
                                self.lines.append(currentLine)
                            }
                            .onEnded ({value in
                                self.lines.append(currentLine)
                                self.currentLine = []
                            })
                        )
                        
                    }
                    .frame(width: 330, height: 219)
                    .background(Color(hex:0xf5f5f5))
                    .cornerRadius(24)
                    .shadow(color: Color(hex: 0xD1D1D6), radius: 2, x: 0, y: 2)
                    .overlay(
                        ZStack{
                            VStack{
                                HStack {
                                    Text("서 명")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color(uiColor: .systemGray4))
                                        .padding(EdgeInsets(top: 22, leading: 22, bottom: 0, trailing: 0))
                                    Spacer()
                                }
                                Spacer()
                            }
                            
                            VStack{
                                Spacer()
                                HStack{
                                    Spacer()
                                    Button("지우기"){
                                        lines = []
                                    }.font(.system(size: 18))
                                        .foregroundColor(Color(hex:0x139460)).padding(EdgeInsets(top: 0, leading: 0, bottom: 22, trailing: 22))
                                }
                            }
                        }
                    )
                }
                Spacer()
                    .frame(height: 16)
                
                //Sign_Description
                
                HStack {
                    Text("위 화면에 서명을 입력하세요")
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex:0x636366))
                        .padding(.leading, 30)
                    Spacer()
                }
                
                //Button
                NextButtonView()
                    .onTapGesture {
                        userInformation.sign = lines
                        viewController.currentPage += 1
                        DataUserDefaultsSave(userInformation: userInformation, viewController: viewController, questiondata: questionData).lo_us_save()
                        
                        dbHelper.deleteTable(tableName: "myTable")
                        dbHelper.createTable()
                        for i in 0..<20 {
                            dbHelper.insertData(question: "\(questionData.questions[i])")
                        }
                    }
                    .padding(.top, 112)
                BottomCircleView(viewCount: 4)
                
            }
            .ignoresSafeArea()
        }
    }
}

struct View_4_Previews: PreviewProvider {
    static var previews: some View {
        View_4(userInformation: UserInformation(), viewController: ViewController(), questionData: QuestionData())
    }
}
