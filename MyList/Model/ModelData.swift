//
//  ModelDAta.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/22.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var todo: [Todo] = [firstTodo, secondTodo]
}
