//
//  CocktailNameListViewController.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/15.
//

import UIKit
import RxCocoa
import Kingfisher

class CocktailNameListViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    
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
        
        viewModel.cocktailListRelay
            .subscribe(onNext: { [weak self] _ in
                self?.mainTableView.reloadData()
            })
            .disposed(by: viewModel.bag)
    }
}

extension CocktailNameListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cocktailListRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailNameTableViewCell", for: indexPath) as? CocktailNameTableViewCell else {
            return UITableViewCell()
        }
        
        if let cocktailEntity = viewModel.targetCocktail(at: indexPath) {
            cell.setCocktail(cocktailEntity)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapCocktailCell(at: indexPath)
    }
}

final class CocktailNameTableViewCell: UITableViewCell {
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
    var imageDownloadTask: DownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        leftImageView.layer.cornerRadius = 6
        leftImageView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leftImageView.image = nil
        imageDownloadTask?.cancel()
    }
    
    func setCocktail(_ cocktail: CocktailInfoEntity) {
        imageDownloadTask = leftImageView.kf.setImage(with: URL(string: cocktail.strDrinkThumb))
        cocktailNameLabel.text = cocktail.strDrink
    }
}
