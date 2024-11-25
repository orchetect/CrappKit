//
//  CKVStack.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit

/// Vertical Stack (`NSStackView`)
@discardableResult
@MainActor public func CKVStack(
    alignment: NSLayoutConstraint.Attribute = .centerX,
    distribution: NSStackView.Distribution = .fill,
    @CKViewBuilder _ builder: () -> [some NSView]
) -> NSStackView {
    NSStackView(.vertical, alignment, distribution, builder)
}

/// Vertical Stack (`NSStackView`)
@discardableResult @_disfavoredOverload
@MainActor public func CKVStack(
    alignment: NSLayoutConstraint.Attribute = .centerX,
    distribution: NSStackView.Distribution = .fill,
    @CKViewBuilder _ builder: (_ stackView: NSStackView) -> [some NSView]
) -> NSStackView {
    NSStackView(.vertical, alignment, distribution, builder)
}
