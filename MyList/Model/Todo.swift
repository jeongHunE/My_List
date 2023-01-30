//
//  Model.swift
//  Snail_ToDo
//
//  Created by 이정훈 on 2023/01/16.
//

import Foundation

struct Todo: Hashable, Identifiable {    //ForEach를 위해 Hashable protocol 준수
    var title: String          //할일 제목
    var description: String    //메모
    var completed: Bool        //완료 여부
    var showDate: Bool         //날짜 선택 여부
    var date: Date             //날짜
    var id: UUID               //swift에서 제공하는 identifiable한 id
}
