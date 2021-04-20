//
//  MainViewModel.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/13.
//

import RxRelay
import RxSwift
import Swinject

protocol MainViewModeling: BaseViewModeling {
    var alphabetListRelay: BehaviorRelay<[String]> { get }
    var cocktailNameListViewControllerRelay: PublishRelay<CocktailNameListViewController> { get }
    func targetAlphabet(at indexPath: IndexPath) -> String
    func didTapAlphabetCell(at indexPath: IndexPath)
}

final class MainViewModel: BaseViewModel, MainViewModeling {
    let alphabetListRelay = BehaviorRelay<[String]>(value: [])
    let cocktailNameListViewControllerRelay = PublishRelay<CocktailNameListViewController>()
    let assembler: Assembler = Assembler([MainAssembly()])
    
    override init() {
        super.init()
        setAlphabetList()
    }
    
    private func setAlphabetList() {
        var list: [String] = []
        for num in 65...90 {
            guard let unicodeScalar = UnicodeScalar(num) else { return }
            list.append(String(unicodeScalar))
        }
        alphabetListRelay.accept(list)
    }
    
    func targetAlphabet(at indexPath: IndexPath) -> String {
        return alphabetListRelay.value[indexPath.row]
    }
    
    func didTapAlphabetCell(at indexPath: IndexPath) {
        let viewModel = assembler.resolver.resolve(CocktailNameListViewModeling.self, argument: targetAlphabet(at: indexPath))
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CocktailNameListViewController") as? CocktailNameListViewController else { return }
        viewController.viewModel = viewModel
        
        cocktailNameListViewControllerRelay.accept(viewController)
    }
}

class MainAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CocktailNameListViewModeling.self) { (_, alphabet: String) in
            return CocktailNameListViewModel(alphabet)
        }
    }
}
