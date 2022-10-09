//
//  UITextField+.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit

extension UITextField {
    func containerView(leftImageName: String, rightButton: UIButton? = nil) -> UIView {
        let imageView = UIImageView(image: UIImage(named: leftImageName))
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        var arrangedSubviews =  [imageView, self]
        if let rightButton = rightButton {
            rightButton.snp.makeConstraints { make in
                make.width.height.equalTo(30)
            }
            arrangedSubviews.append(rightButton)
        }
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillProportionally
        let container = UIView()
        container.addSubview(stack)
        container.backgroundColor = .white
        container.setBorder(width: 1.5, color: .borderColor)
        stack.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
        return container
    }
}

