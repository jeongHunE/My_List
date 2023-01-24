//
//  NewTodo.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/24.
//

import SwiftUI

struct NewTodo: View {
    @EnvironmentObject var modelData: ModelData
    @State var title: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            TextField("제목", text: $title)
                .font(.largeTitle)
                .padding()
            Divider()
                
            DatePicker("날짜 선택", selection: $date)
                .font(.title2)
                .padding()
            Divider()
                
            TextField("메모", text: $description)
                .font(.title)
                .padding()
                
            Spacer()
            Button("Add", action: {
                if title == "" {
                    noTitle()
                } else {
                    addNewTodo()
                }
            })
            .font(.title2)
            .alert("제목을 입력하세요", isPresented: $showAlert) {
                Button("확인", action: {})
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addNewTodo() {
        let todo: Todo = Todo(title: title, description: description, completed: false, date: date, id: UUID())
        
        modelData.todoList.append(todo)
    }
    
    func noTitle() {
        showAlert.toggle()
    }
}

struct NewTodo_Previews: PreviewProvider {
    static var previews: some View {
        NewTodo()
            .environmentObject(ModelData())
    }
}
