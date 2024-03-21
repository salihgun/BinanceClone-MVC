//
//  CustomTextField.swift
//  BinanceClone
//
//  Created by Salih Gün on 9.03.2024.
//

import UIKit

protocol CustomTextFieldDelegate: AnyObject {
    func didSearchTextChanged(text: String)
}

class CustomTextField: UITextField {
    
    weak var customDelegate: CustomTextFieldDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String?){
        self.init()
        self.placeholder = placeholder
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .label
        tintColor = .label
        textAlignment = .left
        
        font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        delegate = self
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text,
           let range = Range(range, in: currentText) {
            let newText = currentText.replacingCharacters(in: range, with: string)
            customDelegate.didSearchTextChanged(text: newText)
        }
        return true
    }
}
