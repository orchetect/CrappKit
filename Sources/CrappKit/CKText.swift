//
//  CKText.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit

public enum CKTextStyle {
    case `default`
    case wrapping
}

@discardableResult
public func CKText(
    _ stringValue: String,
    style: CKTextStyle = .default
) -> NSTextField {
    let base: NSTextField = {
        switch style {
        case .default:
            return NSTextField(labelWithString: stringValue)
        case .wrapping:
            return NSTextField(wrappingLabelWithString: stringValue)
        }
    }()
    
    return base
        .withView { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
}

@discardableResult
public func CKText(_ attributedStringValue: NSAttributedString) -> NSTextField {
    NSTextField(labelWithAttributedString: attributedStringValue)
        .withView { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
}

@discardableResult
public func CKTextField(
    _ initial: String = "",
    placeholder: String? = nil,
    formatter: Formatter? = nil
) -> NSTextField {
    NSTextField(string: initial)
        .withView { view in
            view.placeholderString = placeholder
            view.formatter = formatter
        }
}
