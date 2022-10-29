//
//  ViewController.swift
//  CrappKit • https://github.com/orchetect/CrappKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import AppKit
import CrappKit

class ViewController: NSViewController {
    weak var pathControl: CKPathControl?
    weak var textField: NSTextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = body
    }
    
    var body: some NSView {
        CKVStack(.equalCentering) { stackView in
            CKText("Single-Line Single-Line Single-Line")
            
            CKText(
                "Wrapping Text Left-Aligned. Wrapping Text Left-Aligned. Wrapping Text Left-Aligned. Wrapping Text Left-Aligned.",
                style: .wrapping
            )
            .multilineTextAlignment(.left)
            
            CKText(
                "Wrapping Text Center-Aligned. Wrapping Text Center-Aligned. Wrapping Text Center-Aligned. Wrapping Text Center-Aligned.",
                style: .wrapping
            )
            .multilineTextAlignment(.center)
            
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
                url: FileManager.default.desktopFolder
            ) { clickedURL in
                print("Clicked path:", clickedURL)
            }
            .store(in: &pathControl)
            
            SubView()
            
            CKHStack {
                CKTextField(placeholder: "More Text Here")
                    .store(in: &textField)
                CKButton(title: "Print to Console") { [weak self] in
                    let str = self?.textField?.stringValue ?? ""
                    print(str)
                }
            }
        }
        .constraints(minHeight: 350, minWidth: 460)
        .constraints(padding: .standardToSuperview())
    }
}

func SubView() -> some NSView {
    CKHStack {
        CKText("Hello")
        CKText("World")
    }
}
