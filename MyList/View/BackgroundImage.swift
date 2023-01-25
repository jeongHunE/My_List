//
//  BackgroundImage.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/25.
//

import SwiftUI

struct BackgroundImage: View {
    var body: some View {
        Image("background")
            .resizable()
    }
}

struct BackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImage()
    }
}
