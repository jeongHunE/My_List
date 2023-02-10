//
//  AddButtonStyle.swift
//  MyList
//
//  Created by 이정훈 on 2023/02/10.
//

import SwiftUI

struct AddButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: UIScreen.main.bounds.size.height * 0.4, height: UIScreen.main.bounds.size.height * 0.06)    //기기별 사이즈 인식
            HStack {
                Image(systemName: "plus")
                Text("새로운 Todo 추가")
            }
            .foregroundColor(.black)
        }
        .foregroundColor(.white)
        .scaleEffect(configuration.isPressed ? 0.88 : 1.0)    //버튼 눌림 효과
        .background {
            RoundedRectangle(cornerRadius: 10)
                .shadow(color: .gray, radius: 5, x: 1, y: 5)
                .foregroundColor(.white)
                .padding(EdgeInsets(
                    top: 2,
                    leading: 5,
                    bottom: 5,
                    trailing: 5
                )
            )
        }
    }
}
