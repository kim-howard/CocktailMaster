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
    @IBOutlet weak var instructionTextView: UITextView!
    @IBOutlet weak var ingredientTableView: UITableView!
    
    var viewModel: CocktailDetailViewModeling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        binding()
        viewModel.getDetail()
    }
    
    private func attribute() {
        ingredientTableView.tableFooterView = UIView()
    }
    
    private func binding() {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: viewModel.bag)
        
        viewModel.cocktailDetailRelay
            .subscribe(onNext: { [weak self] _ in
                self?.setUI()
            })
        .disposed(by: viewModel.bag)
        
        viewModel.ingredientListRelay
            .subscribe(onNext: { [weak self] _ in
                self?.ingredientTableView.reloadData()
            })
            .disposed(by: viewModel.bag)
    }
    
    private func setUI() {
        guard let cocktailDetailEntity = viewModel.cocktailDetailRelay.value else { return }
        if let thumbnailURL = cocktailDetailEntity.detailInfo.strDrinkThumb {
            mainImageView.kf.setImage(with: URL(string: thumbnailURL))
        }
        nameLabel.text = cocktailDetailEntity.detailInfo.strDrink
        categoryLabel.text = cocktailDetailEntity.detailInfo.strCategory
        alcoholicLabel.text = cocktailDetailEntity.detailInfo.strAlcoholic
        if let glass = cocktailDetailEntity.detailInfo.strGlass {
            glassLabel.text = "Serve with \(glass)"
        }
        instructionTextView.text = cocktailDetailEntity.detailInfo.strInstructions
    }
}

extension CocktailDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ingredientListRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientTableViewCell", for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        
        if let ingredient = viewModel.targetIngredient(at: indexPath) {
            cell.setUI(with: ingredient)
        }
        
        return cell
    }
}

final class IngredientTableViewCell: UITableViewCell {
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var measureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setUI(with ingredientEntity: IngredientEntity) {
        ingredientLabel.text = ingredientEntity.ingredient
        measureLabel.text = ingredientEntity.measure
    }
}
