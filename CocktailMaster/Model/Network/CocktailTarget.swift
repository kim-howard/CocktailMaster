//
//  CocktailTarget.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/13.
//

import Moya

enum CocktailTarget: TargetType {
    case list(withFirstLetter: String)
    case detail(id: String)
    
    var baseURL: URL {
        URL(string: "https://www.thecocktaildb.com")!
    }
    
    var path: String {
        let basePath: String = "/api/json/v1/1"
        switch self {
        case .list:
            return basePath + "/search.php"
        case .detail:
            return basePath + "/lookup.php"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .list(let withFirstLetter):
            return .requestParameters(parameters: ["f": withFirstLetter], encoding: URLEncoding.default)
        case .detail(let id):
            return .requestParameters(parameters: ["i": id], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
