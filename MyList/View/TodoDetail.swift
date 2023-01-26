//
//  TodoDetail.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI

struct TodoDetail: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var showDetail: Bool
    var todo: Todo
    let date: String
    let impactHeavy = UIImpactFeedbackGenerator(style: .medium)
    
    var todoIndex: Int {
        modelData.todoList.firstIndex(where: { $0.id == todo.id})!
    }
    
    var body: some View {
        VStack {
            HStack {
                CompletedButton(isCompleted: $modelData.todoList[todoIndex].completed)
                    .onTapGesture {    //touch event
                        modelData.todoList[todoIndex].completed.toggle()
                        impactHeavy.impactOccurred()    //haptic feedback
                    }
                TextField(todo.title,
                          text: $modelData.todoList[todoIndex].title,
                          axis: .vertical)    //aixs: multiline
                .font(.largeTitle)
            }
            Divider()
            
            HStack {
                Text("시간")
                    .font(.title)
                Spacer()
                Text(date)
            }
            Divider()
            
            VStack {
                HStack {
                    Text("메모")
                        .font(.title)
                    Spacer()
                }
                HStack {
                    TextField(todo.description, text:$modelData.todoList[todoIndex].description,
                              axis: .vertical)
                    Spacer()
                }
            }
            Spacer()
            
            Button(action: {
                //removeTodo(todoIndex)
                showDetail.toggle()
            }) {
                HStack {
                    Image(systemName: "trash")
                    Text("삭제")
                        .fontWeight(.semibold)
                }
                .font(.title2)
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func removeTodo(_ index: Int) {
        modelData.todoList.remove(at: index)
    }
}

struct TodoDetail_Previews: PreviewProvider {
    static func endTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시mm분"
        
        return formatter.string(from: date as Date)
    }
    
    
    static var previews: some View {
        TodoDetail(showDetail: .constant(true), todo: ModelData().todoList[0], date: endTime(ModelData().todoList[0].date))
            .environmentObject(ModelData())
    }
}
