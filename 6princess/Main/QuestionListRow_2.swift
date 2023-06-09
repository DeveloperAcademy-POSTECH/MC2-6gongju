//
//  QuestionListRow_2.swift
//  princess
//
//  Created by 신상용 on 2023/05/07.
//

import SwiftUI

struct QuestionListRow_2: View {
    
    @State var model: MyModel = MyModel(id: 1, question: "", complete: 0)
    @StateObject var questiondata: QuestionData
    let dbHelper = DBHelper.shared
    var dataArray: [MyModel] = []
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .foregroundColor(Color(hex: 0x139460))
                    .onTapGesture {
                        dbHelper.updateData(id: model.id, complete: 0)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                            questiondata.viewresetcount += 1
                            questiondata.completeQuestionCount -= 1
                            UserDefaults.standard.set(questiondata.completeQuestionCount, forKey: "completeQuestionCount")
                        }
                        
                    }
                    .frame(width: 22, height: 22)
                Text(model.question)
                Spacer()
            }
            
            Divider()
                .frame(width: 297)
        }
        .padding(.top, 5)
        .padding(.bottom, 1)
        .padding(.leading, 30)
        .padding(.trailing, 14)
        .animation(.easeInOut(duration: 0.7), value: questiondata.viewresetcount)
    }
    
}

struct QuestionListRow_2_Previews: PreviewProvider {
    static var previews: some View {
        QuestionListRow_2(model: MyModel(id: 1, question: "1번째", complete: 0), questiondata: QuestionData())
    }
}
