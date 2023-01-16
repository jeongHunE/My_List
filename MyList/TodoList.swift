//
//  TodoList.swift
//  Snail_ToDo
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI

func removeRows(at offsets: IndexSet) {
    todoList.remove(atOffsets: offsets)
}

struct TodoList: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todoList) { todo in
                        NavigationLink {
                            TodoDetail(todo: todo)
                        } label: {
                            TodoListRow(todo: todo)
                        }
                    }
                    .onDelete(perform: removeRows)
                }
                .navigationTitle("My Todo List")
            }
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
    }
}
