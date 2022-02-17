//
//  MainCell.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

final class MainCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    override var isSelected: Bool {
        didSet {
            isSelected ? addBorderForSelectedCell() : removeBorderForUnselectedCell()
        }
    }
    
    public var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    public let imageIDLabel: InsetLabel = {
        $0.textAlignment = .left
        $0.textColor = .black
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(InsetLabel())
    
    // MARK: - Private Properties
    
    private var imageCachingService = ImageCachingService()
    private lazy var activityIndicator = ActivityIndicatorView()
    
    private let imageDateLabel: InsetLabel = {
        $0.textAlignment = .left
        $0.textColor = .black
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.3
        return $0
    }(InsetLabel())
    
    private lazy var labelStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 5
        return $0
    }(UIStackView(arrangedSubviews: [imageIDLabel, imageDateLabel]))
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    // MARK: - Public Methods
    
    public func configure(with item: Images) {
        guard let url = item.image else { return }
        imageIDLabel.text = "Img ID: \(item.id)"
        imageDateLabel.text = "Taken: \(item.takenDate ?? "none")"
        
        activityIndicator.startAnimating()
        imageView.setupImage(
            for: imageView,
               with: imageCachingService,
               url: url
        ) { [weak self] in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Private Methods
    
    private func addBorderForSelectedCell() {
        UIView.animate(withDuration: 0.3) { [self] in
            contentView.layer.borderWidth = 2
            contentView.layer.borderColor = UIColor.systemRed.cgColor
        }
    }
    
    private func removeBorderForUnselectedCell() {
        UIView.animate(withDuration: 0.3) { [self] in
            contentView.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    private func setupView() {
        [contentView, imageView].forEach {
            $0.roundViewWith(cornerRadius: 10)
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(imageView)
        imageView.addSubview(activityIndicator)
        contentView.addSubview(labelStackView)
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: labelStackView.topAnchor, constant: -5),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
