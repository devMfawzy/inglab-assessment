//
//  PeopleListView.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit

class PeopleListView: UIView {
    let searchBar = UISearchBar()
    let tableView = UITableView()
    private lazy var activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [activityIndicatorView, errorView, tableView])
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    private lazy var errorView = ErrorView()
    
    private var searchTextChangeHandler: ((String) -> Void)?
    private var retryHandler: (() -> Void)?

    func onSearchTextChange(handler: @escaping (String) -> Void) {
        searchTextChangeHandler = handler
    }
    
    func onRetry(handler: @escaping () -> Void) {
        retryHandler = handler
    }
    
    func showError(message: String) {
        activityIndicatorView.stopAnimating()
        errorView.show(message: message)
        errorView.isHidden = false
    }
    
    func showLoadingIndicator() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.activityIndicatorView.startAnimating()
        }
    }
    
    func hideLoadingIndicator() {
        errorView.isHidden = true
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.activityIndicatorView.stopAnimating()
        }
    }
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setUpConstraints()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(searchBar)
        addSubview(vStack)
    }
    
    private func setUpConstraints() {
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(40)
        }
        
        vStack.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.leading.trailing.equalTo(searchBar)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(safeAreaInsets.bottom).offset(-24)
        }
    }
    
    private func setUpViews() {
        // search bar
        searchBar.setBackgroundColor(.white)
        searchBar.setBorder(width: 1, color: .borderColor)
        searchBar.delegate = self
        // table view
        tableView.setBorder(width: 1, color: .borderColor)
        // activity indicator
        activityIndicatorView.color = .gray
        // error view
        errorView.isHidden = true
        errorView.onRetry { [weak self] in
            self?.errorView.isHidden = true
            self?.retryHandler?()
        }
    }
}

//MARK: Search Bar Delegate

extension PeopleListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextChangeHandler?(searchBar.text ?? "")
    }
}
