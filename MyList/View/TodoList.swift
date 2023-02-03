//
//  TodoList.swift
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI

struct TodoList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showNew: Bool = false
    @FocusState var isFocused: Bool
    
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
                .navigationTitle("Todo List")
                .background(
                    Image("background")
                )
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: UIScreen.main.bounds.size.height * 0.4, height: UIScreen.main.bounds.size.height * 0.06)    //기기별 사이즈 인식
                            HStack {
                                Image(systemName: "plus")
                                Text("새로운 Todo 추가")
                            }
                            .foregroundColor(.black)
                        }
                        .foregroundColor(.white)
                        .onTapGesture {
                            showNew.toggle()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "person.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .scrollContentBackground(.hidden)    //list default background remove
            }
            if showNew {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.white)
                    NewTodo(showNew: $showNew)
                        //.focused($isFocused)    //textfield focus
                        /*.onAppear {
                            self.isFocused = true
                        }*/
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut)
                .frame(height: 600)
                .offset(y: UIScreen.main.bounds.size.height * 0.3)
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
