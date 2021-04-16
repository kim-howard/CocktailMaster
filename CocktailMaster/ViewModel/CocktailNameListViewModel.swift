//
//  CocktailNameListViewModel.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/15.
//

import Foundation
import Swinject
import RxRelay

protocol CocktailNameListViewModeling: BaseViewModeling {
    var startedAlphabet: String { get }
    var cocktailListRelay: BehaviorRelay<[CocktailInfoEntity]> { get }
    var cocktailDetailViewControllerRelay: PublishRelay<DetailViewController> { get }
    
    func targetCocktail(at indexPath: IndexPath) -> CocktailInfoEntity?
    func didTapCocktailCell(at indexPath: IndexPath)
    func getCocktailList()
}

final class CocktailNameListViewModel: BaseViewModel, CocktailNameListViewModeling {
    let startedAlphabet: String
    let cocktailListRelay = BehaviorRelay<[CocktailInfoEntity]>(value: [])
    let cocktailDetailViewControllerRelay = PublishRelay<DetailViewController>()
    
    let cocktailProvider = CocktailProvider()
    let container = Container()
    
    init(_ startedAlphabet: String) {
        self.startedAlphabet = startedAlphabet
        super.init()
        setContainer()
        getCocktailList()
    }
    
    private func setContainer() {
        
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
    
    func targetCocktail(at indexPath: IndexPath) -> CocktailInfoEntity? {
        let cocktailList = cocktailListRelay.value
        guard indexPath.row < cocktailList.count else { return nil }
        return cocktailList[indexPath.row]
    }
    
    func didTapCocktailCell(at indexPath: IndexPath) {
        print("tap \(indexPath.row)")
    }
}
