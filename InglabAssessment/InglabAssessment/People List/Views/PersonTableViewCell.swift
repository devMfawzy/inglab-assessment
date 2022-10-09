//
//  PersonTableViewCell.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit
import Kingfisher

class PersonTableViewCell: UITableViewCell {
    private let imageContainer = UIImageView()
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private lazy var labelsStack = UIStackView(arrangedSubviews: [nameLabel, phoneLabel])

    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(person: Person) {
        nameLabel.text = person.name
        phoneLabel.text = person.phone
        let url = URL(string: person.avatar)
        imageContainer.kf.setImage(with: url)
    }
        
    private func addSubviews() {
        contentView.addSubview(imageContainer)
        labelsStack.axis = .vertical
        labelsStack.spacing = 6
        contentView.addSubview(labelsStack)
        imageContainer.image = UIImage(named: "AppLogo")
    }
    
    private func setUpConstraints() {
        imageContainer.snp.makeConstraints { make in
            make.width.height.equalTo(65)
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }
        
        labelsStack.snp.makeConstraints { make in
            make.leading.equalTo(imageContainer.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalTo(imageContainer.snp.top).offset(8)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }
    }
    
    private func setUpViews() {
        imageContainer.contentMode = .scaleAspectFit
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textColor = .gray
        phoneLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        phoneLabel.textColor = .lightGray
    }
}
