//
//  NSStackView.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import Cocoa

// MARK: - NSStackView (internal)

extension NSStackView {
    @discardableResult
    internal convenience init(
        _ orientation: NSUserInterfaceLayoutOrientation,
        _ alignment: NSLayoutConstraint.Attribute,
        _ distribution: Distribution = .fill,
        @CKViewBuilder _ builder: () -> [some NSView]
    ) {
        self.init(
            orientation,
            alignment,
            distribution,
            views: builder()
        )
    }
    
    @discardableResult @_disfavoredOverload
    internal convenience init(
        _ orientation: NSUserInterfaceLayoutOrientation,
        _ alignment: NSLayoutConstraint.Attribute,
        _ distribution: Distribution = .fill,
        @CKViewBuilder _ builder: (_ stackView: NSStackView) -> [some NSView]
    ) {
        self.init(views: []) // must call self/super
        self.init(
            orientation,
            alignment,
            distribution,
            views: builder(self)
        )
    }
    
    @discardableResult @_disfavoredOverload
    internal convenience init(
        _ orientation: NSUserInterfaceLayoutOrientation,
        _ alignment: NSLayoutConstraint.Attribute,
        _ distribution: Distribution,
        views: [some NSView]
    ) {
        self.init(views: []) // must call self/super
        self.orientation = orientation
        self.distribution = distribution
        self.alignment = alignment
        detachesHiddenViews = false
        translatesAutoresizingMaskIntoConstraints = false
        views.forEach { self.addArrangedSubview($0) }
    }
}
