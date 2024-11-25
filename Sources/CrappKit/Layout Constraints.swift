//
//  Layout Constraints.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit
import Cocoa

// Constraints docs:
// https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ProgrammaticallyCreatingConstraints.html

// Apple docs:
// By default, Interface Builder’s standard spacing is
// - 20.0 points between a view and the edge of its superview
// - 8.0 points between sibling views.
extension CGFloat {
    // TODO: hardcoded value
    public static let standardToSuperview: CGFloat = 20
    
    // TODO: hardcoded value
    public static let standardToSibling: CGFloat = 8
}

public struct ConstraintInsets {
    public var top: CGFloat?
    public var leading: CGFloat?
    public var bottom: CGFloat?
    public var trailing: CGFloat?
}

extension ConstraintInsets {
    public static func zero(
        top: Bool = true,
        leading: Bool = true,
        bottom: Bool = true,
        trailing: Bool = true
    ) -> Self {
        .init(
            top: top ? 0 : nil,
            leading: leading ? 0 : nil,
            bottom: bottom ? 0 : nil,
            trailing: trailing ? 0 : nil
        )
    }
    
    public static func standardToSuperview(
        top: Bool = true,
        leading: Bool = true,
        bottom: Bool = true,
        trailing: Bool = true
    ) -> Self {
        .init(
            top: top ? .standardToSuperview : nil,
            leading: leading ? .standardToSuperview : nil,
            bottom: bottom ? .standardToSuperview : nil,
            trailing: trailing ? .standardToSuperview : nil
        )
    }
    
    public static func standardToSibling(
        top: Bool = true,
        leading: Bool = true,
        bottom: Bool = true,
        trailing: Bool = true
    ) -> Self {
        .init(
            top: top ? .standardToSibling : nil,
            leading: leading ? .standardToSibling : nil,
            bottom: bottom ? .standardToSibling : nil,
            trailing: trailing ? .standardToSibling : nil
        )
    }
}

// MARK: - NSView Modifier Methods

extension NSView {
    private func addConstraints(
        other: NSView,
        insets: ConstraintInsets,
        isActive: Bool = true
    ) {
        if let topOffset = insets.top {
            topAnchor.constraint(equalTo: other.topAnchor, constant: topOffset)
                .isActive = isActive
        }
        if let bottomOffset = insets.bottom {
            bottomAnchor.constraint(equalTo: other.bottomAnchor, constant: -bottomOffset)
                .isActive = isActive
        }
        if let leadingOffset = insets.leading {
            leadingAnchor.constraint(equalTo: other.leadingAnchor, constant: leadingOffset)
                .isActive = isActive
        }
        if let trailingOffset = insets.trailing {
            trailingAnchor.constraint(equalTo: other.trailingAnchor, constant: -trailingOffset)
                .isActive = isActive
        }
    }
}

extension NSView {
    /// Add constraints to view.
    /// Must call only after adding view to superview.
    @available(*, deprecated, message: "This method is experimental and may change. Currently, it won't work intuitively because it relies on the superview already being set to its parent.")
    @discardableResult
    public func constraints(insets: ConstraintInsets,
                            to parent: NSView? = nil,
                            isActive: Bool = true) -> Self {
        guard let sv = parent ?? superview else {
            print("Unable to add constraints to \(self): Superview is nil.")
            return self
        }
        addConstraints(other: sv, insets: insets, isActive: isActive)
        return self
    }
    
    /// Adds center anchor X and/or Y constraints to the view.
    @available(*, deprecated, message: "This method is experimental and may change. Currently, it won't work intuitively because it relies on the superview already being set to its parent.")
    @discardableResult
    public func constraints(centerX: Bool = false, centerY: Bool = false) -> Self {
        guard let superview else {
            print("Unable to add constraints to \(self): Superview is nil.")
            return self
        }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = centerX
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = centerY
        return self
    }
}

extension NSView {
    /// Add static width and/or height constraints to the view.
    @discardableResult
    public func constraints(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        if let width = width {
            frame = .init(
                origin: frame.origin,
                size: .init(width: width, height: frame.size.height)
            )
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            frame = .init(
                origin: frame.origin,
                size: .init(width: frame.size.width, height: height)
            )
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        return self
    }
    
    /// Add minimum width and/or height constraints to the view.
    @discardableResult
    public func constraints(minWidth: CGFloat? = nil, minHeight: CGFloat? = nil) -> Self {
        if let minWidth = minWidth {
            if frame.width < minWidth {
                frame = .init(
                    origin: frame.origin,
                    size: .init(width: minWidth, height: frame.size.height)
                )
            }
            widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth).isActive = true
        }
        if let minHeight = minHeight {
            if frame.height < minHeight {
                frame = .init(
                    origin: frame.origin,
                    size: .init(width: frame.size.width, height: minHeight)
                )
            }
            heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight).isActive = true
        }
        return self
    }
    
    /// Add maximum width and/or height constraints to the view.
    @discardableResult
    public func constraints(maxWidth: CGFloat? = nil, maxHeight: CGFloat? = nil) -> Self {
        if let maxWidth = maxWidth {
            if frame.width > maxWidth {
                frame = .init(
                    origin: frame.origin,
                    size: .init(width: maxWidth, height: frame.size.height)
                )
            }
            widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
        }
        if let maxHeight = maxHeight {
            if frame.height > maxHeight {
                frame = .init(
                    origin: frame.origin,
                    size: .init(width: frame.size.width, height: maxHeight)
                )
            }
            heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight).isActive = true
        }
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
    
    /// Sets the priority for all constraints of the view.
    @discardableResult
    public func constraintsPriority(_ priority: NSLayoutConstraint.Priority) -> Self {
        constraints.forEach {
            print("setting priority")
            $0.priority = priority
        }
        return self
    }
}
