//
//  MovieListTableViewCell.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet weak private var posterImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var yearLabel: UILabel!
    
    private var imageLoadTask: CancellableType?
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadTask?.cancel()
        posterImageView.image = nil
        titleLabel.text = nil
        yearLabel.text = nil
    }
    
    func fill(_ cellViewModel: MovieListCellViewModel) {
        titleLabel.text = cellViewModel.title
        yearLabel.text = cellViewModel.year
        imageLoadTask = posterImageView.downloaded(imageLoader: cellViewModel.imageRepository, from: cellViewModel.poster)
    }
}
