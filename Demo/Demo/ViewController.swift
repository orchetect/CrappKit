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
    weak var datePicker: NSDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = body
    }
    
    var body: some NSView {
        CKVStack(.equalSpacing) { stackView in
            CKText(
                "Single-Line Single-Line Single-Line Single-Line Single-Line Single-Line Single-Line Single-Line"
            )
            .constraints(maxWidth: 380)
            
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
            
            MyView()
            
            CKHStack {
                CKTextField(placeholder: "Enter some text here")
                    .store(in: &textField)
                CKButton(title: "Print to Console") { [weak self] in
                    let str = self?.textField?.stringValue ?? ""
                    print(str)
                }
            }
            
            NSDatePicker()
                .store(in: &datePicker)
            
            // TODO: this crashes - not sure why
//            switch Bool.random() {
//            case true:
//                CKText("true")
//            case false:
//                CKText("false")
//            }
            
            // TODO: this crashes - not sure why
//            if Bool.random() {
//                CKText("true")
//            } else {
//                CKText("false")
//            }
        }
        .constraints(minHeight: 350, minWidth: 300)
        .constraints(padding: .standardToSuperview())
    }
}

func MyView() -> some NSView {
    CKHStack {
        CKText("Hello")
        CKText("World")
    }
}
