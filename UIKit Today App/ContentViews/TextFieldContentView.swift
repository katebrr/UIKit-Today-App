//
//  TextFieldContentView.swift
//  UIKit Today App
//
//  Created by Kateryna BRYLINSKA on 22/12/2023.
//

import UIKit

/*
    Adopting this protocol signals that this view renders the content and styling that you define within a configuration. The content view’s configuration provides values for all supported properties and behaviors to customize the view.
 */
class TextFieldContentView: UIView, UIContentView {
    
    // how exactly this will work?
    struct Config: UIContentConfiguration {
        var text: String? = ""
        
        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }
        
    }
    
    var configuration: UIContentConfiguration
    
    let textField = UITextField()
    
    // intrinsic - defined by the content
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        /* The text field is pinned to the top of the superview and has a horizontal padding of 16. Top and bottom insets of 0 force the text field to span the entire height of the superview. */
        
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        /* This property directs the text field to display a Clear Text button on its trailing side when it has contents, providing a way for the user to remove text quickly.
         */
        textField.clearButtonMode = .whileEditing
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
