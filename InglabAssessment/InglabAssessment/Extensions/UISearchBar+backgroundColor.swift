//
//  UISearchBar.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import UIKit

extension UISearchBar {
    func setBackgroundColor(_ colot: UIColor) {
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = colot
        }
    }
}
