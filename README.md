# PreviewInUIKit

A Swift package that provides SwiftUI wrappers for previewing UIKit views and view controllers in Xcode previews.

## Overview

PreviewInUIKit makes it easy to preview your UIKit components using SwiftUI's preview functionality. This is especially useful when you're working with UIKit but want to take advantage of SwiftUI's fast preview capabilities for rapid development and testing.

## Features

- **UIViewPreview**: Wrap any `UIView` for SwiftUI previews
- **ViewControllerPreview**: Wrap any `UIViewController` for SwiftUI previews
- Compatible with iOS 13.0+, tvOS 13.0+, and watchOS 6.0+
- Works seamlessly with macOS Xcode for development and previews
- Lightweight and easy to integrate
- Type-safe generic interfaces

## Requirements

- iOS 13.0+ / tvOS 13.0+ / watchOS 6.0+
- Xcode 12.0+
- Swift 5.7+

> **Note**: This package uses UIKit APIs and is designed for previewing UIKit components. It will only be available on platforms that support UIKit (iOS, tvOS, and watchOS). macOS support is included for Xcode development and previews.

## Installation

### Swift Package Manager

Add PreviewInUIKit to your project using Swift Package Manager:

1. In Xcode, go to **File > Add Package Dependencies**
2. Enter the repository URL: `https://github.com/dwhao84/Preview-in-UIKit.git`
3. Choose "Up to Next Major Version" and click **Add Package**

Alternatively, add it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/dwhao84/Preview-in-UIKit.git", branch: "main")
]
```

For projects that prefer semantic versioning, you can use:

```swift
dependencies: [
    .package(url: "https://github.com/dwhao84/Preview-in-UIKit.git", from: "0.1.0")
]
```

> **Tip**: Using `branch: "main"` ensures you always get the latest updates, while version-based dependencies provide more stability for production projects.

## Usage

### Previewing UIView

```swift
import SwiftUI
import PreviewInUIKit

// Your custom UIView
class MyCustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .systemBlue
        // Add your view setup code here
    }
}

// SwiftUI Preview
struct MyCustomView_Previews: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            MyCustomView()
        }
        .frame(width: 300, height: 200)
        .previewLayout(.sizeThatFits)
    }
}
```

### Previewing UIViewController

```swift
import SwiftUI
import PreviewInUIKit

// Your custom view controller
class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "My View Controller"
        
        // Add your view controller setup code here
    }
}

// SwiftUI Preview
struct MyViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            let viewController = MyViewController()
            return UINavigationController(rootViewController: viewController)
        }
        .ignoresSafeArea()
    }
}
```

### Advanced Usage

You can combine multiple previews and use different preview configurations:

```swift
struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UIViewPreview {
                let view = MyCustomView()
                view.backgroundColor = .systemRed
                return view
            }
            .previewDisplayName("Red Version")
            
            UIViewPreview {
                let view = MyCustomView()
                view.backgroundColor = .systemGreen
                return view
            }
            .previewDisplayName("Green Version")
            
            UIViewPreview {
                MyCustomView()
            }
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
        }
        .frame(width: 300, height: 200)
        .previewLayout(.sizeThatFits)
    }
}
```

## API Reference

### UIViewPreview

A SwiftUI view that wraps a UIView for use in previews.

```swift
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct UIViewPreview<V: UIView>: UIViewRepresentable {
    public init(_ builder: @escaping () -> V)
}
```

**Parameters:**
- `builder`: A closure that returns the UIView instance to preview

### ViewControllerPreview

A SwiftUI view that wraps a UIViewController for use in previews.

```swift
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public struct ViewControllerPreview<V: UIViewController>: UIViewControllerRepresentable {
    public init(_ builder: @escaping () -> V)
}
```

**Parameters:**
- `builder`: A closure that returns the UIViewController instance to preview

## Troubleshooting

### Common Issues

**Package dependency resolution fails:**
- Make sure you're using the correct repository URL: `https://github.com/dwhao84/Preview-in-UIKit.git`
- Try using `branch: "main"` instead of version requirements
- Clean your Xcode derived data and restart Xcode

**Previews not working:**
- Ensure you're importing both `SwiftUI` and `PreviewInUIKit`
- Make sure you're targeting iOS 13.0+, tvOS 13.0+, or watchOS 6.0+
- Check that your UIView/UIViewController classes are properly initialized

**Build errors on macOS:**
- This is expected behavior. The package only compiles on platforms with UIKit
- Use iOS simulators for testing and previews

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.