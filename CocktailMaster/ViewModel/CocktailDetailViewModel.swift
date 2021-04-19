//
//  DetailViewModel.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/13.
//

import RxSwift
import RxRelay

protocol CocktailDetailViewModeling: BaseViewModeling {
    var id: String { get }
    var cocktailDetailRelay: BehaviorRelay<CocktailDetailEntity?> { get }
    var ingredientListRelay: BehaviorRelay<[IngredientEntity]> { get }
    
    func getDetail()
    func targetIngredient(at indexPath: IndexPath) -> IngredientEntity?
}

class CocktailDetailViewModel: CocktailDetailViewModeling {
    let bag = DisposeBag()
    let cocktailProvider = CocktailProvider()
    let id: String
    let cocktailDetailRelay = BehaviorRelay<CocktailDetailEntity?>(value: nil)
    let ingredientListRelay = BehaviorRelay<[IngredientEntity]>(value: [])
    
    init(_ id: String) {
        self.id = id
    }
    
    func getDetail() {
        cocktailProvider.cocktailDetail(id)
            .subscribe { [weak self] response in
                guard let detailEntity = response.drinks.first else { return }
                self?.cocktailDetailRelay.accept(detailEntity)
                self?.ingredientListRelay.accept(detailEntity.ingredientList.list)
            } onError: { err in
                print(err)
            }
            .disposed(by: bag)
    }
    
    func targetIngredient(at indexPath: IndexPath) -> IngredientEntity? {
        guard indexPath.row < ingredientListRelay.value.count else { return nil }
        return ingredientListRelay.value[indexPath.row]
    }
}
