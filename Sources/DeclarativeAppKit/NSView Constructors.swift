//
//  NSView Constructors.swift
//

import Cocoa

// MARK: - NSStackView (internal)

extension NSStackView {
    @discardableResult
    internal convenience init(
        _ orientation: NSUserInterfaceLayoutOrientation,
        _ distribution: Distribution = .fill,
        @NSViewBuilder _ builder: () -> [some NSView]
    ) {
        self.init(orientation, distribution, views: builder())
    }
    
    @discardableResult @_disfavoredOverload
    internal convenience init(
        _ orientation: NSUserInterfaceLayoutOrientation,
        _ distribution: Distribution = .fill,
        @NSViewBuilder _ builder: (_ stackView: NSStackView) -> [some NSView]
    ) {
        self.init(views: []) // must call self/super
        self.init(orientation, distribution, views: builder(self))
    }
    
    @discardableResult @_disfavoredOverload
    internal convenience init(
        _ orientation: NSUserInterfaceLayoutOrientation,
        _ distribution: Distribution = .fillEqually,
        views: [some NSView]
    ) {
        self.init(views: []) // must call self/super
        self.orientation = orientation
        self.distribution = distribution
        self.detachesHiddenViews = false
        self.translatesAutoresizingMaskIntoConstraints = false
        views.forEach { self.addArrangedSubview($0) }
        self.layout()
    }
}

// MARK: - NSVStack

@discardableResult
public func NSVStack(
    _ distribution: NSStackView.Distribution = .fill,
    @NSViewBuilder _ builder: () -> [some NSView]
) -> NSStackView {
    NSStackView(.vertical, distribution, builder)
}

@discardableResult @_disfavoredOverload
public func NSVStack(
    _ distribution: NSStackView.Distribution = .fill,
    @NSViewBuilder _ builder: (_ stackView: NSStackView) -> [some NSView]
) -> NSStackView {
    NSStackView(.vertical, distribution, builder)
}

// MARK: - NSHStack

@discardableResult
public func NSHStack(
    _ distribution: NSStackView.Distribution = .fill,
    @NSViewBuilder _ builder: () -> [some NSView]
) -> NSStackView {
    NSStackView(.horizontal, distribution, builder)
}

@discardableResult @_disfavoredOverload
public func NSHStack(
    _ distribution: NSStackView.Distribution = .fill,
    @NSViewBuilder _ builder: (_ stackView: NSStackView) -> [some NSView]
) -> NSStackView {
    NSStackView(.horizontal, distribution, builder)
}

// MARK: - Text

@discardableResult
public func NSAttributedLabel(_ attributedStringValue: NSAttributedString) -> NSTextField {
    NSTextField(labelWithAttributedString: attributedStringValue)
        .withView { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
}

@discardableResult
public func NSLabel(_ stringValue: String) -> NSTextField {
    NSTextField(labelWithString: stringValue)
        .withView { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
}

@discardableResult
public func NSWrappingLabel(_ stringValue: String) -> NSTextField {
    NSTextField(wrappingLabelWithString: stringValue)
        .withView { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
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
