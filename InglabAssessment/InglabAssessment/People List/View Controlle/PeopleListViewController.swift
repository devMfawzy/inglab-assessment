//
//  PeopleListViewController.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit
import SnapKit

class PeopleListViewController: UIViewController {
    let mainView = PeopleListView()
    let viewModel: PeopleViewModelProtocol
    
    init(viewModel: PeopleViewModelProtocol = PeopleViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setUp()
        bind()
    }
    
    override func loadView() {
        view = mainView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchActivePeople()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let searchBar = mainView.searchBar
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top)
        }
    }
    
    private func setUp() {
        view.backgroundColor = .backgroundColor
        title = "Inglab Assessment"
        //table view
        let tableView = mainView.tableView
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorColor = .lightGray
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        // search bar
        mainView.onSearchTextChange { [weak self] text in
            self?.viewModel.filterBy(text: text)
        }
        
        mainView.onRetry { [weak self] in
            self?.viewModel.fetchActivePeople()
        }
    }
    
    private func bind() {
        viewModel.onDataUpdate { [weak self] in
            self?.mainView.tableView.reloadData()
            self?.mainView.hideLoadingIndicator()
        }
        
        viewModel.onLoading { [weak self] in
            self?.mainView.showLoadingIndicator()
        }
        
        viewModel.onError { [weak self] error in
            self?.mainView.showError(message: error)
        }
    }
}

//MARK: Data Source

extension PeopleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.activePeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? PersonTableViewCell {
            let person = viewModel.activePeople[indexPath.row]
            cell.configure(person: person)
        }
        return cell
    }
}

//MARK: Delegate

extension PeopleListViewController: UITableViewDelegate {
    
}
