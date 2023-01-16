//
//  TodoDetail.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI

struct TodoDetail: View {
    var todo: Todo
    
    var body: some View {
        VStack {
            HStack {
                Text(todo.title)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            Divider()
            
            VStack {
                HStack {
                    Text("시간")
                        .font(.title2)
                    Spacer()
                }
                HStack {
                    Text("시간대")
                    Spacer()
                }
            }
            Divider()
            
            VStack {
                HStack {
                    Text("메모")
                        .font(.title2)
                    Spacer()
                }
                HStack {
                    Text(todo.description)
                    Spacer()
                }
            }
            Spacer()
            
        }
        .padding()
    }
}

struct TodoDetail_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetail(todo: todoList[0])
    }
}
