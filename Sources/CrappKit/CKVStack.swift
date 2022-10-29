//
//  CKVStack.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit

/// Vertical Stack (`NSStackView`)
@discardableResult
public func CKVStack(
    _ distribution: NSStackView.Distribution = .fill,
    @CKViewBuilder _ builder: () -> [some NSView]
) -> NSStackView {
    NSStackView(.vertical, distribution, builder)
}

/// Vertical Stack (`NSStackView`)
@discardableResult @_disfavoredOverload
public func CKVStack(
    _ distribution: NSStackView.Distribution = .fill,
    @CKViewBuilder _ builder: (_ stackView: NSStackView) -> [some NSView]
) -> NSStackView {
    NSStackView(.vertical, distribution, builder)
}
