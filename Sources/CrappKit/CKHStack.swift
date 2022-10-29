//
//  CKHStack.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit

/// Horizontal Stack (`NSStackView`)
@discardableResult
public func CKHStack(
    _ distribution: NSStackView.Distribution = .fill,
    @NSViewBuilder _ builder: () -> [some NSView]
) -> NSStackView {
    NSStackView(.horizontal, distribution, builder)
}

/// Horizontal Stack (`NSStackView`)
@discardableResult @_disfavoredOverload
public func CKHStack(
    _ distribution: NSStackView.Distribution = .fill,
    @NSViewBuilder _ builder: (_ stackView: NSStackView) -> [some NSView]
) -> NSStackView {
    NSStackView(.horizontal, distribution, builder)
}
