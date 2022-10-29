//
//  CKPathControl.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit

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
