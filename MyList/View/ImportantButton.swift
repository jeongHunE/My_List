//
//  ImportantButton.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/30.
//

import SwiftUI

struct ImportantButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        Image(systemName: isSet ? "star.fill" : "star")
            .foregroundColor(isSet ? .yellow : .gray)
            .font(.system(size: 20))
    }
}

struct ImportantButton_Previews: PreviewProvider {
    static var previews: some View {
        ImportantButton(isSet: .constant(true))
    }
}
