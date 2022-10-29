//
//  NSViewBuilder.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import Cocoa

// ResultBuilder tutorial: https://developer.apple.com/wwdc21/10253
@resultBuilder
public enum NSViewBuilder {
    public static func buildBlock(_ components: NSView...) -> [some NSView] {
        components
    }
}
