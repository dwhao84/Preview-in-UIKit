import XCTest
@testable import PreviewInUIKit

#if canImport(UIKit)
import UIKit
import SwiftUI

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
final class PreviewInUIKitTests: XCTestCase {
    
    func testUIViewPreviewInitialization() {
        // Test that UIViewPreview can be initialized with a UIView builder
        let preview = UIViewPreview {
            let view = UIView()
            view.backgroundColor = .systemBlue
            return view
        }
        
        // Since UIViewPreview conforms to UIViewRepresentable, we can create it
        XCTAssertNotNil(preview)
    }
    
    func testViewControllerPreviewInitialization() {
        // Test that ViewControllerPreview can be initialized with a UIViewController builder
        let preview = ViewControllerPreview {
            let viewController = UIViewController()
            viewController.view.backgroundColor = .systemGreen
            return viewController
        }
        
        // Since ViewControllerPreview conforms to UIViewControllerRepresentable, we can create it
        XCTAssertNotNil(preview)
    }
    
    func testUIViewPreviewMakeUIView() {
        let testView = UIView()
        testView.backgroundColor = .systemRed
        
        let preview = UIViewPreview { testView }
        let context = UIViewRepresentableContext<UIViewPreview<UIView>>(
            coordinator: ()
        )
        
        let resultView = preview.makeUIView(context: context)
        XCTAssertEqual(resultView.backgroundColor, .systemRed)
    }
    
    func testViewControllerPreviewMakeUIViewController() {
        let testViewController = UIViewController()
        testViewController.title = "Test Controller"
        
        let preview = ViewControllerPreview { testViewController }
        let context = UIViewControllerRepresentableContext<ViewControllerPreview<UIViewController>>(
            coordinator: ()
        )
        
        let resultViewController = preview.makeUIViewController(context: context)
        XCTAssertEqual(resultViewController.title, "Test Controller")
    }
}

#else
// For platforms without UIKit, provide a minimal test
final class PreviewInUIKitTests: XCTestCase {
    func testUnavailableOnNonUIKitPlatforms() {
        // This test ensures the package compiles on platforms without UIKit
        // The actual functionality is only available on platforms with UIKit
        XCTAssert(true, "Package compiles successfully on platforms without UIKit")
    }
}
#endif
