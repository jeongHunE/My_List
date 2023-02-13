//
//  NewTodo.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/24.
//

import SwiftUI

struct NewTodo: View {
    @EnvironmentObject var modelData: ModelData
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    @State private var showDate: Bool = false
    @Binding var showNew: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button("취소") {
                    hideKeyboard()
                    showNew.toggle()
                }
                Spacer()
                Text("새로운 Todo 추가")
                Spacer()
                Button("추가", action: {
                    addNewTodo()
                    hideKeyboard()
                    showNew.toggle()
                })
                .disabled(title == "")
            }
            TextField("제목",
                      text: $title,
                      axis: .vertical)    //axis: multiline
            .font(.title2)
            .padding()
            Divider()
            VStack {
                Toggle(isOn: $showDate) {
                    Text("시간 선택")
                        .font(.title3)
                }
                if showDate {
                    DatePicker("",
                               selection: $date,
                               displayedComponents: [.date, .hourAndMinute]
                    )
                }
            }
            .padding()
            
            Divider()
            
            TextField("메모 추가하기",
                      text: $description,
                      axis: .vertical)
            .font(.title3)
            .padding()
            Spacer()
        }
        .padding()
    }
    
    func addNewTodo() {
        let todo: Todo = Todo(title: title, description: description, completed: false, showDate: showDate, endDate: date, id: UUID(), addDate: Date(), isImportant: false)
        
        modelData.todoList.append(todo)
    }
}

struct NewTodo_Previews: PreviewProvider {
    static var previews: some View {
        NewTodo(showNew: .constant(true))
            .environmentObject(ModelData())
    }
}
