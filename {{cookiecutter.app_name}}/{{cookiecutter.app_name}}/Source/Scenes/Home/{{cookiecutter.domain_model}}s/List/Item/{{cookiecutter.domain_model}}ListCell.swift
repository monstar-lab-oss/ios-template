//
//  {{cookiecutter.domain_model}}ListCell.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit
import Domain
import Kingfisher

class {{cookiecutter.domain_model}}ListCell: UICollectionViewCell {

    static let identifier = "{{cookiecutter.domain_model}}ListCellIdentifier"

    @IBOutlet private weak var posterImageView: UIImageView!

    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clearAll()
    }

    func configure(forItem item: {{cookiecutter.domain_model}}) {
        if let path = item.posterPath, let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500" + path) {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(
                with: posterUrl,
                placeholder: UIImage(named: "No_image_poster"),
                options: [
                    .loadDiskFileSynchronously,
                    .cacheOriginalImage
                ],
                completionHandler: { result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                        self.posterImageView.image = #imageLiteral(resourceName: "No_image_poster")
                    }
                }
            )
        }
    }
}

fileprivate extension {{cookiecutter.domain_model}}ListCell {
    func clearAll() {
        // Cancel downloading of image and then reset
        posterImageView.kf.cancelDownloadTask()
        posterImageView.image = #imageLiteral(resourceName: "No_image_poster")
    }
}
