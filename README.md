# PreviewInUIKit

![CI](https://github.com/dwhao84/Preview-in-UIKit/workflows/CI/badge.svg)
![Release](https://github.com/dwhao84/Preview-in-UIKit/workflows/Release/badge.svg)
![Swift 5.7+](https://img.shields.io/badge/Swift-5.7+-orange.svg)
![Platforms](https://img.shields.io/badge/Platforms-iOS%2013.0%2B%20%7C%20tvOS%2013.0%2B%20%7C%20watchOS%206.0%2B%20%7C%20macOS%2010.15%2B-blue.svg)

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

## GitHub Actions CI/CD

This repository includes comprehensive GitHub Actions workflows for continuous integration and automated releases.

### Continuous Integration (CI)

The CI workflow (`.github/workflows/swift.yml`) automatically runs on every push and pull request to the `main` branch:

**Features:**
- **Multi-platform testing**: Tests on iOS, tvOS, and watchOS simulators using Xcode
- **Swift Package Manager**: Builds and tests using SPM for macOS compatibility
- **Code coverage**: Generates test coverage reports
- **Documentation**: Validates that documentation can be built
- **Caching**: Uses GitHub Actions cache to speed up builds

**Jobs:**
1. **SPM Tests**: Builds and tests using Swift Package Manager on macOS
2. **Xcode Tests**: Cross-platform testing matrix for iOS, tvOS, and watchOS
3. **Build Documentation**: Ensures documentation can be generated

### Release Automation

The release workflow (`.github/workflows/release.yml`) automatically creates GitHub releases when version tags are pushed:

**To create a release:**
1. Create and push a version tag: `git tag v1.0.0 && git push origin v1.0.0`
2. The workflow will automatically:
   - Validate the release by running tests
   - Create a GitHub release with installation instructions
   - Generate release notes

**Workflow features:**
- Validates release by running full test suite
- Auto-generates release notes with installation instructions
- Supports semantic versioning (e.g., v1.0.0, v1.2.3)

### Local Development

Before pushing changes, you can run the same checks locally:

```bash
# Build and test with SPM (for macOS)
swift build
swift test

# Test on iOS Simulator (requires Xcode)
xcodebuild test -scheme PreviewInUIKit \
  -destination "platform=iOS Simulator,name=iPhone 15,OS=latest"

# Test on tvOS Simulator
xcodebuild test -scheme PreviewInUIKit \
  -destination "platform=tvOS Simulator,name=Apple TV,OS=latest"

# Test on watchOS Simulator
xcodebuild test -scheme PreviewInUIKit \
  -destination "platform=watchOS Simulator,name=Apple Watch Series 9 (45mm),OS=latest"

# Generate documentation
swift package generate-documentation --target PreviewInUIKit
```

### Status Badges

You can add these badges to show the build status in your README:

```markdown
![CI](https://github.com/dwhao84/Preview-in-UIKit/workflows/CI/badge.svg)
![Release](https://github.com/dwhao84/Preview-in-UIKit/workflows/Release/badge.svg)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

**Before submitting:**
1. Ensure all tests pass locally
2. Add tests for new functionality
3. Update documentation if needed
4. Follow the existing code style

The CI workflow will automatically test your changes across all supported platforms.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.