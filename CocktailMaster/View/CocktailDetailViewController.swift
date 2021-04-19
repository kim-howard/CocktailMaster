//
//  CocktailDetailViewController.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/13.
//

import UIKit

final class CocktailDetailViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var alcoholicLabel: UILabel!
    @IBOutlet weak var glassLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ingredientTableView: UITableView!
    
    var viewModel: CocktailDetailViewModeling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
    }
    
    private func binding() {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: viewModel.bag)
    }
}

final class IngredientTableViewCell: UITableViewCell {
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    
}
