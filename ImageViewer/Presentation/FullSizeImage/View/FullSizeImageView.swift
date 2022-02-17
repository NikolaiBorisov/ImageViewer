//
//  FullSizeImageView.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

final class FullSizeImageView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var fullSizeImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .lightGray
        return $0
    }(UIImageView())
    
    public lazy var downloadDateLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = .black
        $0.text = "Date"
        return $0
    }(UILabel())
    
    // MARK: - Private Properties
    
    private lazy var imageAndLabelStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 5
        return $0
    }(UIStackView(arrangedSubviews: [fullSizeImageView, downloadDateLabel]))
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupLayout()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func addSubviews() {
        addSubview(imageAndLabelStackView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageAndLabelStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageAndLabelStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            imageAndLabelStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageAndLabelStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            downloadDateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
