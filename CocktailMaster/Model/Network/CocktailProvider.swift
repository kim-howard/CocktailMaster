//
//  CocktailProvider.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/13.
//

import Moya
import RxSwift

final class CocktailProvider: MoyaProvider<CocktailTarget> {
    func cocktailList(_ firstLetter: String) -> Single<CocktailInfoList> {
        rx.request(.list(withFirstLetter: firstLetter))
            .map(CocktailInfoList.self)
    }
    
    func cocktailDetail(_ id: String) -> Single<CocktailDetailResponse> {
        rx.request(.detail(id: id))
            .map(CocktailDetailResponse.self)
    }
}
