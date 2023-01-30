//
//  TodoList.swift
//  Snail_ToDo
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct TodoList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showNew: Bool = false
    let impactHeavy = UIImpactFeedbackGenerator(style: .medium)    //haptic feedback
    
    var body: some View {
        NavigationView {
            List {
                ForEach($modelData.todoList) { $todo in
                    HStack {
                        CompletedButton(isCompleted: $todo.completed)
                            .onTapGesture {    //touch event
                                todo.completed.toggle()
                                impactHeavy.impactOccurred()    //haptic feedback
                            }
                        NavigationLink(destination: LazyView(TodoDetail(todo: todo, date: endTime(todo.date))), label: {
                            VStack(alignment: .leading) {
                                Text(todo.title)
                                    .font(.subheadline)
                                    .padding(.bottom, 1)
                                    .foregroundColor(.black)
                                Text(endTime(todo.date))
                                    .foregroundColor(.black)
                                    .font(.caption)
                            }
                        })
                    }
                    .listRowBackground(    //row design
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(
                                top: 2,
                                leading: 5,
                                bottom: 5,
                                trailing: 5
                            )
                        )
                    )
                    .listRowSeparator(.hidden)    //행 분리 선
                }
                .onDelete(perform: removeRows)    //remove row when slide
            }
            .navigationTitle("Todo List")
            .background(
                NavigationLink(destination: NewTodo(showNew: $showNew), isActive: $showNew) {}
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        showNew.toggle()
                    }
                }
            }
            .scrollContentBackground(.hidden)    //list default background remove
            .background(Image("background"))
        }
    }
    
    func removeRows(at offsets: IndexSet) -> Void {
        modelData.todoList.remove(atOffsets: offsets)
    }
    
    func endTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시mm분"
        
        return formatter.string(from: date)
    }
    
    func today(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 EE"
        
        return formatter.string(from: date)
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
            .environmentObject(ModelData())
    }
}
