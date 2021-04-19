//
//  MainViewModel.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/13.
//

import RxRelay
import RxSwift
import Swinject
import SwinjectStoryboard

protocol MainViewModeling: BaseViewModeling {
    var alphabetListRelay: BehaviorRelay<[String]> { get }
    var cocktailNameListViewControllerRelay: PublishRelay<CocktailNameListViewController> { get }
    func targetAlphabet(at indexPath: IndexPath) -> String
    func didTapAlphabetCell(at indexPath: IndexPath)
}

final class MainViewModel: BaseViewModel, MainViewModeling {
    let alphabetListRelay = BehaviorRelay<[String]>(value: [])
    let cocktailNameListViewControllerRelay = PublishRelay<CocktailNameListViewController>()
    
    let container = Container()
    
    override init() {
        super.init()
        setAlphabetList()
        setContainer()
    }
    
    private func setAlphabetList() {
        var list: [String] = []
        for num in 65...90 {
            guard let unicodeScalar = UnicodeScalar(num) else { return }
            list.append(String(unicodeScalar))
        }
        alphabetListRelay.accept(list)
    }
    
    private func setContainer() {
        container.register(CocktailNameListViewModeling.self) { (_, alphabet: String) in
            return CocktailNameListViewModel(alphabet)
        }
        
        container.storyboardInitCompleted(CocktailNameListViewController.self) { (r, c) in
            // do somthing if u want ...
        }
    }
    
    func targetAlphabet(at indexPath: IndexPath) -> String {
        return alphabetListRelay.value[indexPath.row]
    }
    
    func didTapAlphabetCell(at indexPath: IndexPath) {
        let viewModel = container.resolve(CocktailNameListViewModeling.self, argument: targetAlphabet(at: indexPath))
        guard let viewController = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container).instantiateViewController(withIdentifier: "CocktailNameListViewController") as? CocktailNameListViewController else { return }
        viewController.viewModel = viewModel
        
        cocktailNameListViewControllerRelay.accept(viewController)
    }
}
