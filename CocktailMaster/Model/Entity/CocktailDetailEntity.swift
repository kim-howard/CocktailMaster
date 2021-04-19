//
//  CocktailDetailEntity.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/19.
//

import Foundation

struct CocktailDetailResponse: Decodable {
    let drinks: [CocktailDetailEntity]
}

struct CocktailDetailEntity: Decodable {
    let detailInfo: CocktailDetailInfo
    let ingredientList: IngredientList
    
    init(from decoder: Decoder) throws {
        self.detailInfo = try CocktailDetailInfo(from: decoder)
        self.ingredientList = try IngredientList(from: decoder)
    }
}

struct CocktailDetailInfo: Decodable {
    let idDrink: String
    let strDrink: String
    let strCategory: String?
    let strAlcoholic: String?
    let strGlass: String?
    let strInstructions: String?
    let strDrinkThumb: String?
}

struct IngredientList: Decodable {
    let list: [IngredientEntity]
    
    enum CodingKeys: String, CodingKey {
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var result: [IngredientEntity] = []
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient1), let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure1) {
            result.append(IngredientEntity(ingredient: ingredient, measure: measure))
        }
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient2), let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure2) {
            result.append(IngredientEntity(ingredient: ingredient, measure: measure))
        }
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient3), let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure3) {
            result.append(IngredientEntity(ingredient: ingredient, measure: measure))
        }
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient4), let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure4) {
            result.append(IngredientEntity(ingredient: ingredient, measure: measure))
        }
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient5), let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure5) {
            result.append(IngredientEntity(ingredient: ingredient, measure: measure))
        }
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient6), let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure6) {
            result.append(IngredientEntity(ingredient: ingredient, measure: measure))
        }
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient7), let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure7) {
            result.append(IngredientEntity(ingredient: ingredient, measure: measure))
        }
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient8), let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure8) {
            result.append(IngredientEntity(ingredient: ingredient, measure: measure))
        }
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient9), let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure9) {
            result.append(IngredientEntity(ingredient: ingredient, measure: measure))
        }
        if let ingredient = try container.decodeIfPresent(String.self, forKey: .strIngredient10), let measure = try container.decodeIfPresent(String.self, forKey: .strMeasure10) {
            result.append(IngredientEntity(ingredient: ingredient, measure: measure))
        }
        
        self.list = result
    }
}

struct IngredientEntity: Decodable {
    let ingredient: String
    let measure: String
}
