//
//  Utils.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import Foundation

extension FileManager {
    var desktopFolder: URL {
        FileManager.default
            .homeDirectoryForCurrentUser
            .appendingPathComponent("Desktop")
    }
}
