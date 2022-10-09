//
//  ErrorView.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit
import SnapKit

class ErrorView: UIView {
    private var retryHandler: (() -> Void)?
    private let label = UILabel()
    private let retryButton = UIButton(type: .system)
    private lazy var hStack = {
       let stack = UIStackView(arrangedSubviews: [label, retryButton])
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setUpConstraints()
        setUpViews()
    }
    
    func onRetry(handler: @escaping () -> Void) {
        retryHandler = handler
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(hStack)
    }
    
    private func setUpConstraints() {
        retryButton.snp.makeConstraints { make in
            make.height.equalTo(32).priority(.high)
            make.width.equalTo(60).priority(.high)
        }
        
        hStack.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
    
    func show(message: String) {
        label.text = message
    }
    
    private func setUpViews() {
        // label
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .systemPink

        // button
        retryButton.setTitle("Retry", for: .normal)
        retryButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
        setBorder(width: 0.5, color: .lightGray)
    }
    
    @objc private func retry() {
        retryHandler?()
    }
}
