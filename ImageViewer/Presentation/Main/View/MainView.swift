//
//  MainView.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

final class MainView: UIView {
    
    // MARK: - Public Properties
    
    public var refreshControlPulled: (() -> Void)?
    public lazy var activityIndicator = ActivityIndicatorView()
    public lazy var refreshControl = RefreshControlFactory.generate()
    
    public let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cell: MainCell.self)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = true
        return collectionView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupLayout()
        setupRefreshControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicator.setupActivityIndicator(on: self)
    }
    
    // MARK: - Actions
    
    @objc private func didPullToRefresh(sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.refreshControlPulled?()
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupRefreshControl() {
        imagesCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func addSubviews() {
        addSubview(imagesCollectionView)
        addSubview(activityIndicator)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imagesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            imagesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imagesCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imagesCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
