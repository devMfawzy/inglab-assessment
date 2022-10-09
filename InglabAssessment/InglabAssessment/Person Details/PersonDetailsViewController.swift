//
//  PersonDetailsViewController.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit
import Kingfisher
import SnapKit

class PersonDetailsViewController: UIViewController {
    private let mainView = PersonDetailsView()
    private let person: Person
    
    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
        setUp()
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        view.backgroundColor = .backgroundColor
        title = person.name
        let url = URL(string: person.avatar)
        mainView.imageView.kf.setImage(with: url)
        mainView.phoneLabel.text = person.phone
        mainView.emailLabel.text = person.email
    }
}
