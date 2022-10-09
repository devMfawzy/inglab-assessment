//
//  PersonDetailsView.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit
import SnapKit

class PersonDetailsView: UIView {
    let imageView = UIImageView()
    let phoneLabel = UILabel()
    let emailLabel = UILabel()
    let descriptionTextView = UITextView()
    private lazy var phoneBox = createInforBox(label: phoneLabel, iconName: "iconCall")
    private lazy var emailBox = createInforBox(label: emailLabel, iconName: "iconEmail")
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setUpConstraints()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(imageView)
        addSubview(phoneBox)
        addSubview(emailBox)
        addSubview(descriptionTextView)
    }
    
    func setUpConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(170)
        }
        
        phoneBox.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        emailBox.snp.makeConstraints { make in
            make.top.equalTo(phoneBox.snp.bottom).offset(12)
            make.leading.trailing.equalTo(phoneBox)
            make.bottom.lessThanOrEqualTo(safeAreaInsets.bottom).offset(-24)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(emailBox.snp.bottom).offset(12)
            make.leading.trailing.equalTo(phoneBox)
            make.bottom.equalTo(safeAreaInsets.bottom).offset(-30)
        }
    }
    
    func setUpViews() {
        imageView.setBorder(width: 1, color: .lightGray)
        [phoneLabel, emailLabel].forEach {
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
        }
        descriptionTextView.isEditable = false
        descriptionTextView.setBorder(width: 1, color: .lightGray)
    }
    
    private func createInforBox(label: UILabel, iconName: String) -> UIView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        let imageView = UIImageView(image: UIImage(named: iconName))
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(label)
        let container = UIView()
        container.addSubview(stack)
        container.backgroundColor = .white
        container.setBorder(width: 1.5, color: .blueButtonColoe)
        stack.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
        return container
    }
}
