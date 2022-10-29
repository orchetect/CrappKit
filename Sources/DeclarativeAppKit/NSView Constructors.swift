//
//  NSView Constructors.swift
//

import Cocoa

// MARK: - Stacks

extension NSStackView {
    @discardableResult
    public convenience init(
        _ orientation: NSUserInterfaceLayoutOrientation,
        _ distribution: Distribution = .fillEqually,
        _ views: (_ superview: Self) -> [NSView]
    ) {
        self.init(views: []) // must call self/super
        self.orientation = orientation
        self.distribution = distribution
        views(self).forEach { self.addArrangedSubview($0) }
    }
}

@discardableResult
public func NSVStack(
    _ distribution: NSStackView.Distribution = .fillEqually,
    views: (_ superview: NSStackView) -> [NSView]
) -> NSStackView {
    NSStackView(.vertical, distribution, views)
}

@discardableResult
public func NSHStack(
    _ distribution: NSStackView.Distribution = .fillEqually,
    views: (_ superview: NSStackView) -> [NSView]
) -> NSStackView {
    NSStackView(.horizontal, distribution, views)
}

// MARK: - Text

@discardableResult
public func NSAttributedLabel(_ attributedStringValue: NSAttributedString) -> NSTextField {
    NSTextField(labelWithAttributedString: attributedStringValue)
}

@discardableResult
public func NSLabel(_ stringValue: String) -> NSTextField {
    NSTextField(labelWithString: stringValue)
}

@discardableResult
public func NSWrappingLabel(_ stringValue: String) -> NSTextField {
    NSTextField(wrappingLabelWithString: stringValue)
}

// MARK: - Path

public class NSCustomPathControl: NSPathControl {
    private var actionHandler: (_ clickedURL: URL) -> Void
    
    @discardableResult
    public init(
        style: NSPathControl.Style = .standard,
        url: URL? = nil,
        actionHandler: @escaping (_ clickedURL: URL) -> Void = { _ in }
    ) {
        self.actionHandler = actionHandler
        super.init(frame: .zero)
        pathStyle = style
        self.url = url
        action = #selector(self.handleAction)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    @IBAction private func handleAction(_ sender: Any) {
        guard let url = clickedPathItem?.url else { return }
        actionHandler(url)
    }
}
