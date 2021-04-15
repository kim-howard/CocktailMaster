//
//  MainViewModel.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/13.
//

import Foundation

protocol MainViewModeling {
    var testProperty: String { get }
}

class MainViewModel: MainViewModeling {
    var testProperty: String = "Test"
    
    init(_ text: String) {
        self.testProperty = text
    }
}
