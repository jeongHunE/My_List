//
//  CompletedButton.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/22.
//

import SwiftUI

struct CompletedButton: View {
    @Binding var isCompleted: Bool
    
    var body: some View {
        Image(systemName: isCompleted
              ? "checkmark.square"
              : "square")
    }
}

struct CompletedButton_Previews: PreviewProvider {
    static var previews: some View {
        CompletedButton(isCompleted: .constant(true))
    }
}
