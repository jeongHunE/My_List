//
//  ListRow.swift
//  MyList
//
//  Created by 이정훈 on 2023/02/03.
//

import SwiftUI

struct ListRow: View {
    @EnvironmentObject var modelData: ModelData
    var todo: Todo
    let impactHeavy = UIImpactFeedbackGenerator(style: .medium)    //haptic feedback
    
    var todoIndex: Int? {
        return modelData.todoList.firstIndex(where: { $0.id == todo.id})
    }
    
    var body: some View {
        if let todoIndex = todoIndex {
            HStack {
                //complete button
                CompletedButton(isCompleted: $modelData.todoList[todoIndex].completed)
                    .onTapGesture {    //touch event
                        modelData.todoList[todoIndex].completed.toggle()
                        impactHeavy.impactOccurred()    //haptic feedback
                    }
                HStack {
                    VStack(alignment: .leading) {
                        Text(todo.title)
                            .font(.title3)
                            .padding(.bottom, 1)
                            .foregroundColor(.black)
                            .strikethrough(todo.completed)
                        
                        if todo.showDate {
                            HStack {
                                Image(systemName: "calendar")
                                Text(endTime(todo.endDate))
                            }
                            .font(.footnote)
                            .foregroundColor(.black)
                        } else {
                            HStack {
                                Image(systemName: "calendar")
                                Text("-")
                                    .foregroundColor(.black)
                            }
                            .font(.footnote)
                            .foregroundColor(.black)
                        }
                    }
                    Spacer()
                }
                .padding(.leading, 8)
                
                //important button
                ImportantButton(isSet: $modelData.todoList[todoIndex].isImportant)
                    .onTapGesture {
                        modelData.todoList[todoIndex].isImportant.toggle()
                        impactHeavy.impactOccurred()    //haptic feedback
                    }
            }
        }
        else {
            EmptyView()
        }
    }
}

func endTime(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 MM월 dd일 HH시mm분"
    
    return formatter.string(from: date)
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(todo: ModelData().todoList[0])
            .environmentObject(ModelData())
    }
}
