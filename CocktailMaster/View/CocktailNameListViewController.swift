//
//  CocktailNameListViewController.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/15.
//

import UIKit
import RxCocoa

class CocktailNameListViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: CocktailNameListViewModeling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        binding()
    }
    
    private func setUI() {
        titleLabel.text = "Cocktail List StartedWith: \(viewModel.startedAlphabet.uppercased())"
    }
    
    private func binding() {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: viewModel.bag)
    }
}
