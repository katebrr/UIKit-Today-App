//
//  TextViewContentView.swift
//  UIKit Today App
//
//  Created by Kateryna BRYLINSKA on 22/12/2023.
//

import Foundation
import UIKit

class TextViewContentView: UIView, UIContentView {
    
    struct Config: UIContentConfiguration {
        var text: String? = ""
        
        func makeContentView() -> UIView & UIContentView {
            return TextViewContentView(self)
        }
        
    }
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    let textView = UITextView()
    
    // intrinsic - defined by the content
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        /* Text views are scroll views. Even though you assign a fixed height to the text view, the scroll view accommodates users with automatic scrolling and scroll indicators if they enter more text than can fit. */
        
        addPinnedSubview(textView, height: 200)
        
        textView.backgroundColor = nil
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let config = configuration as? TextFieldContentView.Config else { return }
        textView.text = config.text
    }
}

extension UICollectionViewListCell {
    func textViewConfiguration ()  -> TextViewContentView.Config {
        TextViewContentView.Config()
    }
}


