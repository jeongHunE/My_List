//
//  TodoList.swift
//  Snail_ToDo
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI

struct TodoList: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach($modelData.todo) { $todo in
                        HStack {
                            CompletedButton(isCompleted: $todo.completed)
                                .onTapGesture {    //touch event
                                    todo.completed.toggle()
                                }
                            NavigationLink(destination: TodoDetail(todo: todo), label: {
                                Text(todo.title)
                                    .font(.title3)
                            })
                        }
                        .padding()
                    }
                    .onDelete(perform: removeRows)
                }
                .navigationTitle("My Todo List")
                .toolbar {
                    Button("add") {}
                        .offset(x: -15 ,y:45)
                        .font(.title3)
                }
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        modelData.todo.remove(atOffsets: offsets)
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
            .environmentObject(ModelData())
    }
}
