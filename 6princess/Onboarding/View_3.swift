//
//  View_3.swift
//  princess
//
//  Created by 신상용 on 2023/05/05.
//

import SwiftUI
import UIKit

struct View_3: View {
    @State var userInformation: UserInformation
    @State var viewController: ViewController
    @State var selectedImage: UIImage?
    @State var productName: String = ""
    var body: some View {
        ZStack {
            
            BackBottonView(viewController: viewController)
                .offset(y:-354.2)
            
            VStack(spacing: 0){
                Spacer()
                    .frame(height: 158) //가장위에 레이아웃
                HStack{
                    
                    Text("받고싶은 은퇴 선물의 \n이미지와 설명을 작성하세요")
                        .font(.system(size: 30, weight: .semibold)) //폰트 사이즈
                        .lineSpacing(6)    //줄간격
                        .padding(.leading, 30)
                    Spacer()
                }
                
                Spacer()
                    .frame(height:12)
                
                HStack {
                    Text("상세하고 명확한 이미지를 권장해요")
                        .padding(.leading, 30)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(hex: 0x636366))
                    Spacer()
                }
                
                //imagePiker
                Spacer()
                    .frame(height: 70)
                ImagePickerView(userInformation: userInformation, viewController: viewController, selectedImage: $selectedImage, productName: $productName)
                Spacer()
                NextButtonView()
                    .onTapGesture {
                        userInformation.image = selectedImage
                        userInformation.productName = productName
                        viewController.currentPage += 1
                       //UserDefaults 삽입
                    }
                BottomCircleView(viewCount: 3)
                Spacer()
                    .frame(height: 52)
                    
            }
        }
        .ignoresSafeArea()
    }
}

struct View_3_Previews: PreviewProvider {
    static var previews: some View {
        View_3(userInformation: UserInformation(), viewController: ViewController())
    }
}
