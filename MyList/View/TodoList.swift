//
//  TodoList.swift
//  Snail_ToDo
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI

struct TodoList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showNew: Bool = false
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach($modelData.todoList) { $todo in
                        HStack {
                            CompletedButton(isCompleted: $todo.completed)
                                .onTapGesture {    //touch event
                                    todo.completed.toggle()
                                }
                            NavigationLink(destination: TodoDetail(todo: todo, date: endTime(todo.date)), label: {
                                VStack(alignment: .leading) {
                                    Text(todo.title)
                                        .font(.title2)
                                        .padding(.bottom, 2)
                                    Text(endTime(todo.date))
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                }
                            })
                        }
                        .listRowSeparator(.visible)    //행 분리 선
                    }
                    .onDelete(perform: removeRows)
                }
                .navigationTitle("Todo List")
                .background(
                    NavigationLink(destination: NewTodo(), isActive: $showNew) {}
                )
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Add", action: {
                            showNew.toggle()
                        })
                        .font(.title3)
                        //.offset(x: -13, y: 45)
                    }
                }
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        modelData.todoList.remove(atOffsets: offsets)
    }
    
    func endTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시mm분"
        
        return formatter.string(from: date as Date)
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
            .environmentObject(ModelData())
    }
}
