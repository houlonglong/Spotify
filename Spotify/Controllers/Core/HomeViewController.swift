//
//  ViewController.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import UIKit

class HomeViewController: UIViewController {
  
    
 
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            return self.createSectionLayout(section: sectionIndex)
        }
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()

    override func viewDidLoad()  {
        super.viewDidLoad()
        title = "首页"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .prominent, target: self, action: #selector(didTapSttings))
        configgureCollectionView()
//        Task {
//            try await fetchData()
//            }

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    private  func configgureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .red
    }
    
    /// 创建一个 CollectionView Section 布局
    /// - Parameter section: 当前 section 的索引
    /// - Returns: NSCollectionLayoutSection 对象，用于 UICollectionViewCompositionalLayout
    private func createSectionLayout(section: Int) -> NSCollectionLayoutSection? {

        // -------------------------------
        // 1️⃣ 创建 Item（单个 cell 的布局）
        // -------------------------------
        // NSCollectionLayoutItem 定义了一个 cell 的大小
        // 这里宽度为组的 100%（fractionalWidth: 1.0）
        // 高度为组的 100%（fractionalHeight: 1.0），由 Group 决定最终高度
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        // -------------------------------
        // 2️⃣ 创建 Group（Item 的容器）
        // -------------------------------
        // NSCollectionLayoutGroup 定义了一个 Item 的集合
        // vertical 表示纵向排列
        // widthDimension: 1.0 → 宽度占整个 Section
        // heightDimension: 120 → 高度固定 120pt
        // subitems: [item] → 包含的 item 数组，这里只有一个 item
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(120)
            ),
            subitems: [item]
        )
        
        // -------------------------------
        // 3️⃣ 创建 Section（Group 的容器）
        // -------------------------------
        // NSCollectionLayoutSection 定义了一个 section 的布局
        // 可以包含一个或多个 Group
        let sectionLayout = NSCollectionLayoutSection(group: group)
        
        // 可选：设置组间距
        sectionLayout.interGroupSpacing = 10
        
        // 可选：设置 section 内边距（top, leading, bottom, trailing）
        sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        // 返回 Section
        return sectionLayout
    }
    
    func fetchData() async throws ->  Void  {
        let data =  try await APICaller.shared.getNewReleases();
        print(data)
        
            
             
    }
    @objc func didTapSttings() {
        
        let settingsVc = SettingsViewController()
        settingsVc.hidesBottomBarWhenPushed = true
        navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(settingsVc, animated: true)
      
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        hidesBottomBarWhenPushed = false
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // 假设有 10 个 item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue // 临时显示颜色
        return cell
    }
}

import SwiftUI
struct HomeViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let  webNav = UINavigationController(rootViewController: HomeViewController())
//              webNav.navigationBar.prefersLargeTitles = true
//              webNav.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always;
           return  webNav
        }
        .edgesIgnoringSafeArea(.all)
    }
}
