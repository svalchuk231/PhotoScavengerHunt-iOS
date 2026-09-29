//
//  TaskCellTableViewCell.swift
//  photoScavengerHunt
//
//  Created by Snezhana Valchuk on 3/19/23.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var completedImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with task: Task) {
        titleLabel.text = task.title
        titleLabel.textColor = task.isComplete ? .secondaryLabel : .label
        completedImageView.image = UIImage(systemName: task.isComplete ? "square.inset.filled" : "square")?.withRenderingMode(.alwaysTemplate)
        completedImageView.tintColor = task.isComplete ? .systemBlue : .tertiaryLabel
    }

}
