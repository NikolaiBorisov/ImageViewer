//
//  FullSizeImageViewController.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

final class FullSizeImageViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var viewModel = FullSizeImageViewModel()
    
    // MARK: - Private Properties
    
    private lazy var mainView = FullSizeImageView()
    
    // MARK: - Initializers
    
    init(
        title: String,
        image: UIImage,
        downloadDate: Date
    ) {
        self.viewModel.vcTitle = title
        self.viewModel.singleImage = image
        self.viewModel.downloadDate = downloadDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupDate()
    }
    
    // MARK: - Private Methods
    
    private func setupNavBar() {
        title = viewModel.vcTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupImage() {
        mainView.fullSizeImageView.image = viewModel.singleImage
    }
    
    private func setupDate() {
        mainView.downloadDateLabel.text = viewModel.showDate
    }
    
}
