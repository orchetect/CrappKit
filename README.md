# Cr*appKit*

Ever wish programmatic AppKit UI was more like SwiftUI?

Enter CrappKit: The (not too) crappy pseudo-declarative AppKit UI.

```swift
class ViewController: NSViewController {
    weak var textField: NSTextField?
    weak var datePicker: NSDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = body
    }
    
    var body: some NSView {
        CKVStack(.equalSpacing) {
            CKText("Hello world")
            
            CKTextField(placeholder: "Enter some text here")
                .constraints(width: 200)
                .store(in: &textField)
            
            CKHStack(.equalSpacing) {
                CKButton(title: "One") { print("One") }
                CKButton(title: "Two") { print("Two") }
            }
            
            MyView()
            
            NSDatePicker()
                .store(in: &datePicker)
        }
        .constraints(padding: .standardToSuperview())
    }
}

func MyView() -> some NSView {
    CKHStack {
        CKText("Hello")
        CKText("World")
    }
}
```

## Usage

Add to your project using Swift Package Manager and `import CrappKit`.

See the Demo project for usage examples.

## DSL Types

Any `NSView` subclass may be used directly in the view builder, but a number of intuitive convenience classes and constructors are provided.

- `CKVStack` - vertical `NSStackView`
- `CKHStack` - horizontal `NSStackView` 
- `CKText` - `NSTextField` single & multi-line labels, and attributed string
- `CKTextField` - editable `NSTextField`
- `CKButton` - `NSButton` with action closure
- `CKPathControl` - `NSPathControl` with properties and action closure

## NSView Modifiers

Various NSView modifiers are provided.

`NSView`
- `autoresizingMask(_:)` - set autoresizing mask for the view
- `disableAutoresizingMask()` - disable autoresizing mask for the view
- `frame(rect:)` - set view rect
- `frame(size:)` - set view size
- `focusRingType(_:)` - set focus ring type for view
- `withView { view in }` - modify the view within a closure
- `store(in:)` - overwrites the passed variable with a reference to the view, usually a `weak var` akin to Interface Builder's IBOutlet

`NSTextField`
- `multilineTextAlignment(:_)` - set alignment for wrapping text

## NSView NSLayoutConstraint Modifiers

Various NSView modifiers to apply NSLayoutConstraints are provided.

- `constraints(insets:)` - adds constraints to the view's four sides
- `constraints(height:width:)` - adds static height and/or width constraints
- `constraints(minHeight:minWidth:)` - adds minimum height and/or width constraints
- `constraints(maxHeight:maxWidth:)` - adds maximum height and/or width constraints
- `constraints(centerX:centerY:)` - adds center X and/or Y constraints
- `constraints(padding:)` - wraps the view in an enclosing NSView with the given padding insets
- `constraintsPriority(_:)` - sets the priority for all constraints applied to the view
