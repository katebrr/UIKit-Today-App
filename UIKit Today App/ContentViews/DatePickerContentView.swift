//
//  DatePickerContentView.swift
//  UIKit Today App
//
//  Created by Kateryna BRYLINSKA on 22/12/2023.
//

import UIKit


class DatePickerContentView: UIView, UIContentView {
    
    struct Config: UIContentConfiguration {
        var date = Date.now
        
        func makeContentView() -> UIView & UIContentView {
            return DatePickerContentView(self)
        }
        
    }
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    let datePicker = UIDatePicker()
    
    // intrinsic - defined by the content
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        addPinnedSubview(datePicker)
        datePicker.preferredDatePickerStyle = .inline //displays an editable calendar that isn’t hidden behind a button or menu
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let config = configuration as? DatePickerContentView.Config else { return }
        datePicker.date = config.date
    }
}

extension UICollectionViewListCell {
    func datePickerConfiguration ()  -> DatePickerContentView.Config {
        DatePickerContentView.Config()
    }
}

