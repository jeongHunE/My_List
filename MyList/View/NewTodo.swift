//
//  NewTodo.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/24.
//

import SwiftUI

enum Field {
    case title, description
}

struct NewTodo: View {
    @EnvironmentObject var modelData: ModelData
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var date: Date = Date()
    @State private var showAlert: Bool = false
    @State private var showDate: Bool = false
    @Binding var showNew: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Text("새로운 Todo 추가")
                TextField("제목",
                          text: $title,
                          axis: .vertical)    //axis: multiline
                .font(.title2)
                .padding()
                Divider()
                VStack {
                    Toggle(isOn: $showDate) {
                        Text("시간 선택")
                            .font(.title2)
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
                
                TextField("메모",
                          text: $description,
                          axis: .vertical)
                .font(.title3)
                .padding()
                Spacer()
                .frame(height: 100)
                HStack {
                    Button("추가", action: {
                        if title == "" {
                            noTitle()
                        } else {
                            addNewTodo()
                            showNew.toggle()
                        }
                    })
                    .font(.title2)
                    .foregroundColor(.accentColor)
                    .buttonStyle(.bordered)
                    .alert("제목을 입력하세요", isPresented: $showAlert) {
                        Button("확인", action: {})
                    }
                    Button("취소", action: {
                        showNew.toggle()
                    })
                    .font(.title2)
                    .foregroundColor(.accentColor)
                    .buttonStyle(.bordered)
                }
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func addNewTodo() {
        let todo: Todo = Todo(title: title, description: description, completed: false, showDate: showDate, date: date, id: UUID(), isImportant: false)
        
        modelData.todoList.append(todo)
    }
    
    func noTitle() {
        showAlert.toggle()
    }
}

struct NewTodo_Previews: PreviewProvider {
    static var previews: some View {
        NewTodo(showNew: .constant(true))
            .environmentObject(ModelData())
    }
}
