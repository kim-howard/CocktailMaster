//
//  CocktailInfoEntity.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/15.
//

import Foundation

struct CocktailInfoList: Decodable {
    let drinks: [CocktailInfoEntity]
}

struct CocktailInfoEntity: Decodable {
    let strDrink: String
    let strDrinkThumb : String
    let idDrink: String
}
