//
//  DetailViewModel.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/13.
//

import Foundation
import RxSwift

protocol CocktailDetailViewModeling: BaseViewModeling {
    
}

class DetailViewModel: CocktailDetailViewModeling {
    let bag = DisposeBag()
}
