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
    
    // MARK: - Life Cycle
    
    override func loadView() {
        
        view = viewModel.mainView
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
        getImagesHandler()
        refreshControlHandler()
    }
    
    // MARK: - Private Methods
    
    private func setupNavBar() {
        setupNavBar(withTitle: AppTitle.mainVCTitle)
    }
    
    private func setupView() {
        viewModel.mainView.imagesCollectionView.delegate = self
        viewModel.mainView.imagesCollectionView.dataSource = self
    }
    
    private func getImagesHandler() {
        viewModel.getImages { [weak self] error in
            self?.showErrorAlert(with: error, completionReload: {
                self?.viewModel.getImages(completion: { _ in })
            })
        }
    }
    
    private func refreshControlHandler() {
        viewModel.setupRefreshControl { [weak self] error in
            self?.showErrorAlert(with: error, completionReload: {
                self?.viewModel.getImages(completion: { _ in })
            })
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
            on: viewModel.mainView.imagesCollectionView,
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
