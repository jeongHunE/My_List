//
//  ModelDAta.swift
//  MyList
//
//  Created by 이정훈 on 2023/01/22.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var todoList: [Todo] = loadData() ?? [firstTodo]
}

struct Todo: Hashable, Identifiable, Codable {
    //ForEach를 위해 Hashable protocol 준수
    //JSON encoding, decoding을 위한 Codable protocol 준수
    var title: String          //할일 제목
    var description: String    //메모
    var completed: Bool        //완료 여부
    var showDate: Bool         //날짜 선택 여부
    var date: Date             //날짜
    var id: UUID               //swift에서 제공하는 identifiable한 id
    var isImportant: Bool      //별 표시 여부
}

func getDocumentPath() -> URL {    //데이터 저장을 위한 디렉토리 경로를 반환하는 함수
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}

func JSONEncoder<T: Codable>(data: T) -> String? {
    let encoder = JSONEncoder()
    
    do {
        let jsonData = try encoder.encode(data)
        return String(data: jsonData, encoding: .utf8)    //URL 타입의 데이터를 utf8 형식의 String 타입으로 인코딩
    } catch {
        print("JSON encode error")
    }
    
    return nil
}

func JSONDecoder(data: String) -> [Todo]? {
    let decoder = JSONDecoder()
    guard let jsonData = data.data(using: .utf8) else {
        return nil
    }
    
    do {
        let decoded: [Todo] = try decoder.decode([Todo].self, from: jsonData)
        return decoded
    } catch {
        print("JSON decode error")
    }
    
    return nil
}

func save<T: Codable>(data: T) {
    let path = getDocumentPath().appendingPathComponent("usr_data.json")    //저장 경로로 부터 파일 지정
    guard let jsonString = JSONEncoder(data: data) else {
        return
    }
    
    do {
        try jsonString.write(to: path, atomically: true, encoding: .utf8)
        //path 경로에 데이터를 저장하는데 atomically의 값이 true이면 보조 파일을 생성하고 에러가 발생하지 않으면 기존 파일 이름으로 대체
    } catch {
        print("save error")
    }
}

func loadData() -> [Todo]? {
    let path = getDocumentPath().appendingPathComponent("usr_data.json")
    
    do {
        let jsonString = try String(contentsOf: path)    //URL 타입을 전달받아 String 타입 반환
        guard let jsonData = JSONDecoder(data: jsonString) else {
            print("(loaded Data)JSON decode error")
            return nil
        }
        return jsonData
    } catch {
        print("Data load error")
    }
    
    return nil
}
