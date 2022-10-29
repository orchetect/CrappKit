//
//  NSView Modifiers.swift
//

import Cocoa

extension NSView {
    // MARK: View Associations
    
    /// Add view to a superview.
    @discardableResult
    public func addTo(superview: NSView) -> Self {
        superview.addSubview(self)
        return self
    }
    
    // MARK: Layout Behavior
    
    /// Sets autoresizing mask behavior for the view.
    @discardableResult
    public func autoresizingMask(_ mask: AutoresizingMask) -> Self {
        self.autoresizingMask = mask
        return self
    }
    
    /// Disables autoresizing mask behavior for the view.
    @discardableResult
    public func disableAutoresizingMask() -> Self {
        self.autoresizingMask = .none
        return self
    }
    
    // MARK: Frame
    
    /// Sets the view's `frame`.
    @discardableResult
    public func frame(rect newFrame: CGRect) -> Self {
        frame = newFrame
        return self
    }
    
    @discardableResult
    public func frame(size: CGSize) -> Self {
        self.frame.size = size
        return self
    }
    
    // MARK: Style and Appearance
    
    /// Sets layer's background color.
    /// If the layer does not exist, it is created first.
    @discardableResult
    public func backgroundColor(_ color: CGColor?) -> Self {
        if layer == nil { layer = CALayer() }
        layer?.backgroundColor = color
        return self
    }
    
    /// Sets the type of focus ring drawn around the view.
    @discardableResult
    public func focusRingType(_ type: NSFocusRingType) -> Self {
        focusRingType = type
        return self
    }
}

// MARK: - NSView Subclass Generics

protocol NSViewProtocol: AnyObject { }

extension NSViewProtocol {
    /// Provides a mutation block to access the view.
    @discardableResult
    public func withView(_ mutateBlock: (_ view: Self) -> Void) -> Self {
        mutateBlock(self)
        return self
    }
    
    /// Stores reference to `self` in the passed variable.
    @discardableResult
    public func store(in ref: inout Self) -> Self {
        ref = self
        return self
    }
    
    /// Stores reference to `self` in the passed variable.
    @discardableResult
    public func store(in ref: inout Self!) -> Self {
        ref = self
        return self
    }
}

extension NSView: NSViewProtocol { }
