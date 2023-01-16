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
            Button(action: {}, label: {
                Image(systemName: "circle")
            })
            Text(todo.title)
                .font(.title3)
            Spacer()
        }
        .padding()
    }
}

struct TodoListRow_Previews: PreviewProvider {
    static var previews: some View {
        TodoListRow(todo: firstTodo)
    }
}
