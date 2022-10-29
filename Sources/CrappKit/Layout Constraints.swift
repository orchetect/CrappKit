//
//  Layout Constraints.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import Cocoa

// Constraints docs:
// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ProgrammaticallyCreatingConstraints.html

// Apple docs:
// By default, Interface Builder’s standard spacing is
// - 20.0 points between a view and the edge of its superview
// - 8.0 points between sibling views.
extension CGFloat {
    // TODO: hardcoded value
    public static var standardToSuperview: CGFloat = 20
    
    // TODO: hardcoded value
    public static var standardToSibling: CGFloat = 8
}

public struct ConstraintInsets {
    public var top: CGFloat?
    public var bottom: CGFloat?
    public var leading: CGFloat?
    public var trailing: CGFloat?
}

extension ConstraintInsets {
    public static func zero(
        top: Bool = true,
        bottom: Bool = true,
        leading: Bool = true,
        trailing: Bool = true
    ) -> Self {
        .init(
            top: top ? 0 : nil,
            bottom: bottom ? 0 : nil,
            leading: leading ? 0 : nil,
            trailing: trailing ? 0 : nil
        )
    }
    
    public static func standardToSuperview(
        top: Bool = true,
        bottom: Bool = true,
        leading: Bool = true,
        trailing: Bool = true
    ) -> Self {
        .init(
            top: top ? .standardToSuperview : nil,
            bottom: bottom ? .standardToSuperview : nil,
            leading: leading ? .standardToSuperview : nil,
            trailing: trailing ? .standardToSuperview : nil
        )
    }
    
    public static func standardToSibling(
        top: Bool = true,
        bottom: Bool = true,
        leading: Bool = true,
        trailing: Bool = true
    ) -> Self {
        .init(
            top: top ? .standardToSibling : nil,
            bottom: bottom ? .standardToSibling : nil,
            leading: leading ? .standardToSibling : nil,
            trailing: trailing ? .standardToSibling : nil
        )
    }
}

// MARK: - Methods

extension NSView {
    private func addConstraints(
        other: NSView,
        insets: ConstraintInsets
    ) {
        if let topOffset = insets.top {
            topAnchor.constraint(equalTo: other.topAnchor, constant: topOffset)
                .isActive = true
        }
        if let bottomOffset = insets.bottom {
            bottomAnchor.constraint(equalTo: other.bottomAnchor, constant: -bottomOffset)
                .isActive = true
        }
        if let leadingOffset = insets.leading {
            leadingAnchor.constraint(equalTo: other.leadingAnchor, constant: leadingOffset)
                .isActive = true
        }
        if let trailingOffset = insets.trailing {
            trailingAnchor.constraint(equalTo: other.trailingAnchor, constant: -trailingOffset)
                .isActive = true
        }
    }
}

extension NSView {
    /// Add constraints to view.
    /// Must call only after adding view to superview.
    @discardableResult
    public func constraints(insets: ConstraintInsets) -> Self {
        guard let superview = superview else { return self }
        addConstraints(other: superview, insets: insets)
        return self
    }
    
    /// Add static height and/or width constraints to the view.
    @discardableResult
    public func constraints(height: CGFloat? = nil, width: CGFloat? = nil) -> Self {
        if let height = height {
            frame = .init(
                origin: frame.origin,
                size: .init(width: frame.size.width, height: height)
            )
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let width = width {
            frame = .init(
                origin: frame.origin,
                size: .init(width: width, height: frame.size.height)
            )
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        return self
    }
    
    /// Add minimum height and/or width constraints to the view.
    @discardableResult
    public func constraints(minHeight: CGFloat? = nil, minWidth: CGFloat? = nil) -> Self {
        if let minHeight = minHeight {
            if frame.height < minHeight {
                frame = .init(
                    origin: frame.origin,
                    size: .init(width: frame.size.width, height: minHeight)
                )
            }
            heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight).isActive = true
        }
        if let minWidth = minWidth {
            if frame.width < minWidth {
                frame = .init(
                    origin: frame.origin,
                    size: .init(width: minWidth, height: frame.size.height)
                )
            }
            widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth).isActive = true
        }
        return self
    }
    
    /// Adds center anchor constraints to the view.
    @discardableResult
    public func constraints(centerX: Bool = false, centerY: Bool = false) -> Self {
        guard let superview else { return self }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = centerX
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = centerY
        return self
    }
    
    /// Embeds the view in a view with padding.
    @discardableResult
    public func constraints(padding insets: ConstraintInsets) -> NSView {
        let enclosingView = NSView()
        enclosingView.addSubview(self)
        addConstraints(other: enclosingView, insets: insets)
        return enclosingView
    }
}
