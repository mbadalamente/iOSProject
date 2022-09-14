//
//  ManagedAssignmentTableViewCell.swift
//  FinalProject
//
//  Created by Madison Badalamente on 5/7/22.
//

import UIKit

class ManagedAssignmentTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ManagedAssignmentCell"
    
    // from initial table view cell
    @IBOutlet var assignmentNameLabel: UILabel!
    @IBOutlet var assignmentTypeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
