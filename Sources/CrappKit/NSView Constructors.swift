//
//  NSView Constructors.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
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
        detachesHiddenViews = false
        translatesAutoresizingMaskIntoConstraints = false
        views.forEach { self.addArrangedSubview($0) }
    }
}

// MARK: - CKVStack

@discardableResult
public func CKVStack(
    _ distribution: NSStackView.Distribution = .fill,
    @NSViewBuilder _ builder: () -> [some NSView]
) -> NSStackView {
    NSStackView(.vertical, distribution, builder)
}

@discardableResult @_disfavoredOverload
public func CKVStack(
    _ distribution: NSStackView.Distribution = .fill,
    @NSViewBuilder _ builder: (_ stackView: NSStackView) -> [some NSView]
) -> NSStackView {
    NSStackView(.vertical, distribution, builder)
}

// MARK: - CKHStack

@discardableResult
public func CKHStack(
    _ distribution: NSStackView.Distribution = .fill,
    @NSViewBuilder _ builder: () -> [some NSView]
) -> NSStackView {
    NSStackView(.horizontal, distribution, builder)
}

@discardableResult @_disfavoredOverload
public func CKHStack(
    _ distribution: NSStackView.Distribution = .fill,
    @NSViewBuilder _ builder: (_ stackView: NSStackView) -> [some NSView]
) -> NSStackView {
    NSStackView(.horizontal, distribution, builder)
}

// MARK: - Text

public enum CKTextStyle {
    case `default`
    case wrapping
}

@discardableResult
public func CKText(
    _ stringValue: String,
    style: CKTextStyle = .default
) -> NSTextField {
    let base: NSTextField = {
        switch style {
        case .default:
            return NSTextField(labelWithString: stringValue)
        case .wrapping:
            return NSTextField(wrappingLabelWithString: stringValue)
        }
    }()
    
    return base
        .withView { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
}

@discardableResult
public func CKText(_ attributedStringValue: NSAttributedString) -> NSTextField {
    NSTextField(labelWithAttributedString: attributedStringValue)
        .withView { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
}

// MARK: - Button

public class CKButton: NSButton {
    private var actionHandler: () -> Void
    
    @discardableResult
    public init(title: String, actionHandler: @escaping () -> Void) {
        self.actionHandler = actionHandler
        super.init(frame: .zero)
        
        // style
        self.title = title
        self.bezelStyle = .rounded
        
        // action
        action = #selector(handleAction)
        target = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction
    private func handleAction(_ sender: Any) {
        actionHandler()
    }
}

// MARK: - Path

// TODO: add handler for .popUp style when user selects a new folder
public class CKPathControl: NSPathControl {
    private var actionHandler: (_ clickedURL: URL) -> Void
    
    @discardableResult
    public init(
        style: NSPathControl.Style = .standard,
        url: URL? = nil,
        actionHandler: @escaping (_ clickedURL: URL) -> Void = { _ in }
    ) {
        self.actionHandler = actionHandler
        super.init(frame: .zero)
        
        // style
        pathStyle = style
        self.url = url
        
        // action
        action = #selector(handleAction)
        target = self
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    @IBAction
    private func handleAction(_ sender: Any) {
        guard let url = clickedPathItem?.url else { return }
        actionHandler(url)
    }
}
