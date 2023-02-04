//
//  KeyboardExtension.swift
//  MyList
//
//  Created by 이정훈 on 2023/02/04.
//

import SwiftUI

extension View {
    func hideKeyboard() {    //keyboard 내리기
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
}
