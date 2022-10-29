//
//  ViewController.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit
import CrappKit

class ViewController: NSViewController {
    weak var pathControl: CKPathControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = body
    }
    
    var body: some NSView {
        CKVStack(.equalCentering) { stackView in
            CKText("Single-Line Single-Line Single-Line")
            CKText(
                "Wrapping Text Wrapping Text Wrapping Text Wrapping Text Wrapping Text Wrapping Text",
                style: .wrapping
            )
            
            CKHStack(.equalSpacing) {
                CKButton(title: "One") {
                    print("One")
                }
                CKButton(title: "Two") {
                    print("Two")
                }
            }
            
            CKPathControl(
                style: .standard,
                url: FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Desktop")
            ) { clickedURL in
                print("Selected", clickedURL)
            }
            .store(in: &pathControl)
            
            CustomView()
            
            CKText("More Text Here")
        }
        .constraints(minHeight: 350, minWidth: 400)
        .constraints(padding: .standardToSuperview())
    }
}

func CustomView() -> some NSView {
    CKHStack {
        CKText("Hello")
        CKText("World")
    }
}
