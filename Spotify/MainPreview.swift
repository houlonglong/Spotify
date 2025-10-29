import SwiftUI
import UIKit

//8bee83f1304a435e96d229f7d2509acb
//cd82193968c84bfeac90005b1b88cf05

/// 通用 SwiftUI 封装 —— 让任何 UIViewController 可以直接在 SwiftUI Preview 或 SwiftUI 视图中使用
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    
    /// 是否自动嵌入到 UINavigationController 中
    private let embedInNavigation: Bool
    
    /// 构造控制器的闭包
    private let builder: () -> ViewController
    
    /// 初始化
    /// - Parameters:
    ///   - embedInNavigation: 是否在导航控制器中展示（默认 false）
    ///   - builder: 创建 UIViewController 的闭包
    init(embedInNavigation: Bool = false, _ builder: @escaping () -> ViewController) {
        self.embedInNavigation = embedInNavigation
        self.builder = builder
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = builder()
        if embedInNavigation {
            return UINavigationController(rootViewController: viewController)
        } else {
            return viewController
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // 一般不需要更新逻辑
    }
}
