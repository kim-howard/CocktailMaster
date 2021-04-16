//
//  MainViewController.swift
//  CocktailMaster
//
//  Created by Hyeontae on 2021/04/13.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!
    
    var viewModel: MainViewModeling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelBinding()
    }
    
    private func viewModelBinding() {
        viewModel.alphabetListRelay
            .subscribe(onNext: { [weak self] _ in
                self?.mainTableView.reloadData()
            })
            .disposed(by: viewModel.bag)
        
        viewModel.cocktailNameListViewControllerRelay
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.pushViewController($0, animated: true)
            })
            .disposed(by: viewModel.bag)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.alphabetListRelay.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.setAlphabet(viewModel.targetAlphabet(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapAlphabetCell(at: indexPath)
    }
}

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var alphabetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setAlphabet(_ text: String) {
        alphabetLabel.text = text
    }
}
