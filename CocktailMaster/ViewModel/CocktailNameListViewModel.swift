//
//  CocktailNameListViewModel.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/15.
//

import Foundation
import RxRelay

protocol CocktailNameListViewModeling: BaseViewModeling {
    var startedAlphabet: String { get }
    var cocktailListRelay: BehaviorRelay<[CocktailInfoEntity]> { get }
    
    func getCocktailList()
}

final class CocktailNameListViewModel: BaseViewModel, CocktailNameListViewModeling {
    let startedAlphabet: String
    
    let cocktailListRelay = BehaviorRelay<[CocktailInfoEntity]>(value: [])
    
    let cocktailProvider = CocktailProvider()
    
    init(_ startedAlphabet: String) {
        self.startedAlphabet = startedAlphabet
        super.init()
        getCocktailList()
    }
    
    func getCocktailList() {
        cocktailProvider.cocktailList(startedAlphabet)
            .subscribe { [weak self] result in
                self?.cocktailListRelay.accept(result.drinks)
            } onError: { err in
                print(err)
            }
            .disposed(by: bag)
    }
}
