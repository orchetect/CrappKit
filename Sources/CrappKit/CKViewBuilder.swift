//
//  CKViewBuilder.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit
import Cocoa

// ResultBuilder tutorial: https://developer.apple.com/wwdc21/10253
@resultBuilder
public enum CKViewBuilder {
    public static func buildBlock(_ components: NSView...) -> [some NSView] {
        components
    }
    
    public static func buildEither(first component: [some NSView]) -> [some NSView] {
        component
    }

    public static func buildEither(second component: [some NSView]) -> [some NSView] {
        component
    }
    
    public static func buildOptional(_ component: [some NSView]?) -> [some NSView] {
        component ?? []
    }
    
    public static func buildBlock(_ components: [NSView]...) -> [some NSView] {
        // TODO: this crashes - not sure why
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: some NSView) -> [some NSView] {
        [expression]
    }

    public static func buildExpression(_ expression: Void) -> [some NSView] {
        [NSView]()
    }
}
