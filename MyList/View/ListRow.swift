//
//  ListRow.swift
//  MyList
//
//  Created by 이정훈 on 2023/02/03.
//

import SwiftUI

struct ListRow: View {
    @Binding var todo: Todo
    let impactHeavy = UIImpactFeedbackGenerator(style: .medium)    //haptic feedback
    
    var body: some View {
        HStack {
            //complete button
            CompletedButton(isCompleted: $todo.completed)
                .onTapGesture {    //touch event
                    todo.completed.toggle()
                    impactHeavy.impactOccurred()    //haptic feedback
                }
            HStack {
                VStack(alignment: .leading) {
                    Text(todo.title)
                        .font(.title2)
                        .padding(.bottom, 1)
                        .foregroundColor(.black)
                        .strikethrough(todo.completed)
                    
                    if todo.showDate {
                        HStack {
                            Image(systemName: "calendar")
                            Text(endTime(todo.date))
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
            ImportantButton(isSet: $todo.isImportant)
                .onTapGesture {
                    todo.isImportant.toggle()
                    impactHeavy.impactOccurred()    //haptic feedback
                }
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
        ListRow(todo: .constant(ModelData().todoList[0]))
    }
}
