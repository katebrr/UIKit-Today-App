//
//  ReminderViewController+Row.swift
//  UIKit Today App
//
//  Created by Katya Brylinska on 21.12.2023.
//

import UIKit


extension ReminderViewController {
    enum Row: Hashable {
        case date
        case notes
        case time
        case title
        
        var imageName: String? {
            switch self {
            case .date: return "calendar.circle"
            case .notes: return "square.and.pencil"
            case .time: return "clock"
            default: return nil
            }
        }
        
        var image: UIImage? {
            guard let imageName = imageName else { return nil}
            let config = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: config)
        }
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .title: return .headline
            default : return .subheadline
            }
        }
    }
}
