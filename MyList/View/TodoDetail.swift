//
//  TodoDetail.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI

struct TodoDetail: View {
    @State var todo: Todo
    let date: String
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(todo.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    CompletedButton(isCompleted: $todo.completed)
                    Spacer()
                }
                Divider()
                
                VStack {
                    HStack {
                        Text("시간")
                            .font(.title)
                        Spacer()
                    }
                    HStack {
                        Text(date)
                        Spacer()
                    }
                }
                Divider()
                
                VStack {
                    HStack {
                        Text("메모")
                            .font(.title)
                        Spacer()
                    }
                    HStack {
                        Text(todo.description)
                        Spacer()
                    }
                }
                Spacer()
                
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TodoDetail_Previews: PreviewProvider {
    static func endTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시mm분"
        
        return formatter.string(from: date as Date)
    }
    
    
    static var previews: some View {
        TodoDetail(todo: ModelData().todoList[0], date: endTime(ModelData().todoList[0].date))
            .environmentObject(ModelData())
    }
}
