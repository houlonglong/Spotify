//
//  SettingsViewController.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import UIKit // 导入 UIKit 框架，用于创建 UI 界面

// 定义 SettingsViewController 类，继承自 UIViewController，并遵循 UITableViewDataSource 和 UITableViewDelegate 协议


class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    private var sections = [Section]()
    
    private let tabview: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped) // 分组样式
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置"
        view.addSubview(tabview)
        tabview.dataSource = self
        tabview.delegate = self
        configureModel()
        
        // iOS 15+ 去掉 section 顶部默认空白
        if #available(iOS 15.0, *) {
            tabview.sectionHeaderTopPadding = 0
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabview.frame = view.bounds
    }
    
    // MARK: - 数据模型
    private func configureModel() {
        sections = [
            Section(title: "用户资料", options: [
                Option(title: "查看个人资料") { [weak self] in
                    self?.viewProfile()
                }
            ]),
            Section(title: "账户", options: [
                Option(title: "退出登录") { [weak self] in
                    self?.logout()
                }
            ]),
            Section(title: "Account 2", options: [
                Option(title: "测试选项") { [weak self] in
                    self?.testOption()
                }
            ])
        ]
    }
    
    private func viewProfile() {
        print("跳转到个人资料页面")
    }
    
    private func logout() {
        print("执行退出操作")
    }
    
    private func testOption() {
        print("测试选项被点击")
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data.title
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = sections[indexPath.section].options[indexPath.row]
        data.handler() // 执行对应的闭包
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
     //去掉分区顶部空白
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40// 第一个 section 顶部不留空白
        } else {
            return 40 // 其他 section 顶部空白为 2pt
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

// 导入 SwiftUI，用于预览 UIKit 界面
import SwiftUI

// SwiftUI 预览结构体
struct SettingsrPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let  webNav = UINavigationController(rootViewController: SettingsViewController()) // 创建 UINavigationController 包裹 SettingsViewController
            // webNav.navigationBar.prefersLargeTitles = true // 可选：显示大标题
            // webNav.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always // 可选：显示大标题模式
            return  webNav // 返回 UINavigationController
        }
        .edgesIgnoringSafeArea(.all) // 忽略安全区，填满整个屏幕
    }
}
