//
//  TodoList.swift
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI

enum KeyBoard {
    case on, off
}

struct TodoList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showNew: Bool = false
    @FocusState var keyboard: KeyBoard?   //text field에 focuse를 주기 위한 속성
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach($modelData.todoList) { $todo in
                        ZStack {
                            //navigation link
                            //to remove arrow, overlay the HStack over the navigationlink label
                            NavigationLink(destination: TodoDetail(todo: todo), label: {})
                                .opacity(0.0)    //투명도
                            ListRow(todo: $todo)
                        }
                    }
                    .onDelete(perform: removeRows)    //remove row when slide a row
                    .listRowSeparator(.hidden)    //헹 분리 선 숨김
                    .listRowBackground(    //row design
                        RoundedRectangle(cornerRadius: 10)
                            .shadow(color: .black, radius: 0.6, x: 4, y: 3)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(
                                top: 2,
                                leading: 5,
                                bottom: 5,
                                trailing: 5
                            )
                        )
                    )
                }
                .navigationTitle (
                    Text("Todo List")
                )
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button("새로운 Todo 추가") {
                            showNew.toggle()
                        }
                        .sheet(isPresented: $showNew, content: {
                            NewTodo(showNew: $showNew)
                                .onAppear {
                                    self.keyboard = .on//view가 생성될때 isFocused 값 변경
                                }
                                .focused($keyboard, equals: .on)    //isFocused의 값이 .title과 같아지면 textfield focus
                        })
                        .buttonStyle(AddButtonStyle())
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Image(systemName: "ellipsis.circle.fill")
                            Image(systemName: "person.circle.fill")
                        }
                        .font(.title2)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                    }
                }
                .background(
                    Color(red: 247 / 255, green: 247 / 255, blue: 245 / 255)
                )
                .scrollContentBackground(.hidden)    //list default background remove
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) -> Void {
        modelData.todoList.remove(atOffsets: offsets)
    }
    
    func today(_ date: Date) -> String {    //나중에 title 옆에 현재 날짜를 표실하기 위한 format
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
