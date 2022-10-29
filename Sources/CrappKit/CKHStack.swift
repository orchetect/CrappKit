//
//  CKHStack.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit

/// Horizontal Stack (`NSStackView`)
@discardableResult
public func CKHStack(
    alignment: NSLayoutConstraint.Attribute = .centerY,
    distribution: NSStackView.Distribution = .fill,
    @CKViewBuilder _ builder: () -> [some NSView]
) -> NSStackView {
    NSStackView(.horizontal, alignment, distribution, builder)
}

/// Horizontal Stack (`NSStackView`)
@discardableResult @_disfavoredOverload
public func CKHStack(
    alignment: NSLayoutConstraint.Attribute = .centerY,
    distribution: NSStackView.Distribution = .fill,
    @CKViewBuilder _ builder: (_ stackView: NSStackView) -> [some NSView]
) -> NSStackView {
    NSStackView(.horizontal, alignment, distribution, builder)
}
