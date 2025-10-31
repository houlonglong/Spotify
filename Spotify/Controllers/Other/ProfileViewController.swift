//
//  ProfileViewController.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import SDWebImage
import UIKit

class ProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var  models:[String] = []
    private let tabview:UITableView = {
        let tabview = UITableView()
        tabview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tabview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人信息"
        hidesBottomBarWhenPushed = true
        
        tabview.dataSource = self
        tabview.delegate = self
        view.addSubview(tabview)
        view.backgroundColor = .systemBackground
        if isPreview {
            guard let model  = UserProfile.parseMockData() else { return }
            updateUI(with: model)
            
        } else {
            fetchProile()
        }
        view.backgroundColor = .systemBackground
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabview.frame = view.bounds
    }
    
    private func updateUI(with model:UserProfile) {
        //          tabview.isHidden = true
        models.append("姓名:\(model.displayName)")
        models.append("邮箱: mayun@jack.com")
        models.append("订阅:\(model.product == "free" ? "免费" : "收费")")
        tabview.reloadData()
        crateTableHeader(with: model.images?.first?.url)
        
        
    }
    
    private func crateTableHeader(with string:String?) {
        guard let urlString = string, let url = URL(string: urlString) else {
            return
        }
        
        let headerView = UIView(frame:CGRect(x: 0, y: 0, width: view.width, height:  view.width / 1.5))
      
        let imgeSize:CGFloat = headerView.height / 2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imgeSize, height: imgeSize))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imgeSize / 2
        tabview.tableHeaderView = headerView
        
    }
    
    
    
    private func fetchProile() {
        Task {
            do {
                let model = try await APICaller.shared.getCurrentUserProfile()
                updateUI(with: model)
                
            } catch {
                print("❌ 获取用户信息失败:", error.localizedDescription)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let data = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
}


// 导入 SwiftUI，用于预览 UIKit 界面
import SwiftUI

// SwiftUI 预览结构体
struct ProfilePreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let  webNav = UINavigationController(rootViewController: ProfileViewController()) // 创建 UINavigationController 包裹 igationItem.largeTitleDisplayMode = .always // 可选：显示大标题模式
            return  webNav // 返回 UINavigationController
        }
        .edgesIgnoringSafeArea(.all) // 忽略安全区，填满整个屏幕
    }
}
