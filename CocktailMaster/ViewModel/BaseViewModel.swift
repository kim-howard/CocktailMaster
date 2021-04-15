//
//  BaseViewModel.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/15.
//

import RxSwift

protocol BaseViewModeling {
    var bag: DisposeBag { get }
}

class BaseViewModel: BaseViewModeling {
    let bag = DisposeBag()
}
