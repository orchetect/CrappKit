//
//  CKButton.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit

public class CKButton: NSButton {
    private var actionHandler: () -> Void
    
    @discardableResult
    public init(title: String, actionHandler: @escaping () -> Void) {
        self.actionHandler = actionHandler
        super.init(frame: .zero)
        
        // style
        self.title = title
        bezelStyle = .rounded
        
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
