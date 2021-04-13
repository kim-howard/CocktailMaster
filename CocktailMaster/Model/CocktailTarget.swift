//
//  CocktailTarget.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/13.
//

import Moya

enum CocktailTarget: TargetType {
    case list(withFirstLetter: String)
    
    
    var baseURL: URL {
        URL(string: "https://www.thecocktaildb.com")!
    }
    
    var path: String {
        let basePath: String = "/api/json/v1/1/search.php"
        switch self {
        case .list:
            return basePath
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
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
