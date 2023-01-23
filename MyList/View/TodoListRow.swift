//
//  TodoListRow.swift
//  Snail_ToDo
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI

struct TodoListRow: View {
    var todo: Todo
    
    var body: some View {
        HStack {
            /*Button(action: {}, label: {
                Image(systemName: "circle")
            })*/
            Text(todo.title)
            Spacer()
        }
        .padding()
        //.contentShape(Rectangle())    //HStack 전체에서 이벤트 감지
        //.onTapGesture(perform: didTapRow)
    }
    
    private func didTapRow() {
        print("touch")
    }
}

struct TodoListRow_Previews: PreviewProvider {
    static var previews: some View {
        TodoListRow(todo: firstTodo)
    }
}
