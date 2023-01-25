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
        NavigationView {
            List {
                ForEach($modelData.todoList) { $todo in
                    HStack {
                        CompletedButton(isCompleted: $todo.completed)
                            .onTapGesture {    //touch event
                                todo.completed.toggle()
                                let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
                                impactHeavy.impactOccurred()    //haptic feedback
                            }
                        NavigationLink(destination: TodoDetail(todo: todo, date: endTime(todo.date)), label: {
                            VStack(alignment: .leading) {
                                Text(todo.title)
                                    .font(.title3)
                                    .padding(.bottom, 1)
                                    .foregroundColor(.black)
                                Text(endTime(todo.date))
                                    .foregroundColor(.black)
                                    .font(.subheadline)
                            }
                        })
                    }
                }
                .onDelete(perform: removeRows)    //remove row when slide
                .listRowBackground(Color.white)    //row background color
                .listRowSeparator(.visible)    //행 분리 선
            }
            .navigationTitle("Todo List")
            .background(
                NavigationLink(destination: NewTodo(showNew: $showNew), isActive: $showNew) {}
            )
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        showNew.toggle()
                    }
                }
                /*ToolbarItem(placement: .navigation) {
                    Text(today(Date()))
                        .font(.title3)
                }*/
            }
            .scrollContentBackground(.hidden)    //list default background remove
            .background(Image("background"))
            .padding(.top, 0)    //title과 list 사이 간격
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
