//
//  MainViewController.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

final class MainViewController: UIViewController, LoadableErrorAlertController {
    
    // MARK: - Public Properties
    
    public var viewModel = MainViewModel()
    
    // MARK: - Private Properties
    
    private lazy var mainView = MainView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = mainView
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
        getImagesHandler()
        setupRefreshControl()
    }
    
    // MARK: - Private Methods
    
    private func setupNavBar() {
        setupNavBar(withTitle: AppTitle.mainVCTitle)
    }
    
    private func setupView() {
        mainView.imagesCollectionView.delegate = self
        mainView.imagesCollectionView.dataSource = self
    }
    
    private func getImagesHandler() {
        self.mainView.activityIndicator.startAnimating()
        viewModel.getImages { [weak self] error in
            self?.showErrorAlert(with: error, completionReload: {
                self?.viewModel.getImages(completion: { _ in }, callbackReload: {})
                return self?.mainView.activityIndicator.stopAnimating()
            })
        } callbackReload: {
            self.mainView.imagesCollectionView.reloadData()
            return self.mainView.activityIndicator.stopAnimating()
        }
    }
    
    public func setupRefreshControl() {
        mainView.refreshControlPulled = { [weak self] in
            self?.getImagesHandler()
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.savedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainCell = collectionView.dequeueCell(for: indexPath)
        let item = viewModel.savedImages[indexPath.row]
        cell.configure(with: item, for: indexPath)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MainCell
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        guard let title = cell?.imageIDLabel.text,
              let image = cell?.imageView.image else { return }
        let vc = FullSizeImageViewController(title: title, image: image, downloadDate: viewModel.downloadDate)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        collectionView.setupTwoItemsPerRow(
            on: mainView.imagesCollectionView,
            with: viewModel.insetForSection
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        viewModel.insetForSection
    }
    
}
