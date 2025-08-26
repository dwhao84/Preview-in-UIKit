#if canImport(UIKit)
import UIKit
import SwiftUI

@available(
    iOS 13.0,
    tvOS 13.0,
    *
)
public struct UIViewPreview<V: UIView>: UIViewRepresentable {
    private let builder: () -> V
    public init(
        _ builder: @escaping () -> V
    ) {
        self.builder = builder
    }
    public func makeUIView(
        context: Context
    ) -> V {
        builder()
    }
    public func updateUIView(
        _ uiView: V,
        context: Context
    ) {
        
    }
}

@available(
    iOS 13.0,
    tvOS 13.0,
    *
)
public struct ViewControllerPreview<V: UIViewController>: UIViewControllerRepresentable {
    private let builder: () -> V
    public init(
        _ builder: @escaping () -> V
    ) {
        self.builder = builder
    }
    public func makeUIViewController(
        context: Context
    ) -> V {
        builder()
    }
    public func updateUIViewController(
        _ uiViewController: V,
        context: Context
    ) {
        
    }
}
#endif
