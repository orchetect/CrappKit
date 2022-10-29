//
//  NSViewBuilder.swift
//

import Cocoa

// ResultBuilder tutorial: https://developer.apple.com/wwdc21/10253
@resultBuilder
public enum NSViewBuilder {
    public static func buildBlock(_ components: NSView...) -> [some NSView] {
        components
    }
}
