//
//  MyListApp.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/16.
//

import SwiftUI

@main
struct MyListApp: App {
    @StateObject private var modelData: ModelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .onReceive(modelData.$todoList, perform: {todo in    //detect Publisher event
                    save(data: modelData.todoList)    //usr data save
                })
        }
    }
}
