//
//  MainModel.swift
//  MyList
//
//  Created by 이정훈 on 2023/02/11.
//

import SwiftUI

struct MainModel {
    let icon: Image
    let title: String
}

let todo: MainModel = MainModel(icon: Image(systemName: "list.bullet"), title: "Todo List")
let memo: MainModel = MainModel(icon: Image(systemName: "square.and.pencil"), title: "memo")
let etc: MainModel = MainModel(icon: Image(systemName: "ellipsis"), title: "더보기")

let mainModel: [MainModel] = [todo, memo, etc]
