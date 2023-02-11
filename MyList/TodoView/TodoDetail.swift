//
//  TodoDetail.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI


struct TodoDetail: View {
    @EnvironmentObject var modelData: ModelData
    @State var showAlert: Bool = false
    var todo: Todo
    let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
    
    var todoIndex: Int? {
        return modelData.todoList.firstIndex(where: { $0.id == todo.id})
    }

    var body: some View {
        if let todoIndex = todoIndex {
            VStack {
                HStack {
                    CompletedButton(isCompleted:  $modelData.todoList[todoIndex].completed)
                        .onTapGesture {    //touch event
                            modelData.todoList[todoIndex].completed.toggle()
                            impactHeavy.impactOccurred()    //haptic feedback
                        }
                    TextField(todo.title,
                              text: $modelData.todoList[todoIndex].title,
                              axis: .vertical)    //aixs: multiline
                        .font(.title2)
                        .strikethrough(modelData.todoList[todoIndex].completed)    //취소선
                    Spacer()
                    ImportantButton(isSet: $modelData.todoList[todoIndex].isImportant)
                        .onTapGesture {
                            modelData.todoList[todoIndex].isImportant.toggle()
                            impactHeavy.impactOccurred()
                        }
                }
                .padding(.bottom)
                Divider()
                
                HStack {
                    VStack {
                        HStack {
                            Image(systemName: "calendar")
                            Toggle("시간", isOn: $modelData.todoList[todoIndex].showDate)
                                .font(.title2)
                        }
                        .font(.title2)
                        .padding([.top, .bottom])
                        
                        if todo.showDate {
                            DatePicker("",
                                       selection: $modelData.todoList[todoIndex].date,
                                       displayedComponents: [.date, .hourAndMinute]
                            )
                        }
                    }
                }
                Divider()
                
                VStack {
                    HStack {
                        Image(systemName: "note")
                        Text("메모")
                        Spacer()
                    }
                    .font(.title2)
                    HStack {
                        TextField(todo.description, text:$modelData.todoList[todoIndex].description,
                                  axis: .vertical)
                        Spacer()
                    }
                }
                .padding(.top)
                Spacer()
                
                Button("삭제") {
                    showAlert.toggle()
                }
                .buttonStyle(DeleteButtonStyle())
                .alert("정말로 삭제할까요?", isPresented: $showAlert) {
                    HStack {
                        Button("확인") {
                            modelData.todoList.remove(at: todoIndex)
                        }
                        Button("취소") {}
                    }
                }
            }
            .padding()
            .navigationTitle("자세히 보기")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                Color(red: 247 / 255, green: 247 / 255, blue: 245 / 255)
            )
        } else {
            EmptyView()
        }
    }
    
    func endTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시mm분"
        
        return formatter.string(from: date as Date)
    }
}

struct TodoDetail_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetail(todo: ModelData().todoList[0])
            .environmentObject(ModelData())
    }
}
