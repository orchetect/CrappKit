//
//  CKText.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit

public enum CKTextStyle {
    case singleLine(NSLineBreakMode)
    case wrapping
}

@discardableResult
public func CKText(
    _ stringValue: String,
    style: CKTextStyle = .singleLine(.byTruncatingTail)
) -> NSTextField {
    let base: NSTextField = {
        switch style {
        case let .singleLine(linebreakMode):
            return NSTextField(labelWithString: stringValue)
                .withView { view in
                    view.usesSingleLineMode = true
                    view.lineBreakMode = linebreakMode
                    view.allowsDefaultTighteningForTruncation = true
                    view.cell?.wraps = false
                    view.cell?.truncatesLastVisibleLine = true
                }
        case .wrapping:
            return NSTextField(wrappingLabelWithString: stringValue)
                .withView { view in
                    view.usesSingleLineMode = false
                }
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
