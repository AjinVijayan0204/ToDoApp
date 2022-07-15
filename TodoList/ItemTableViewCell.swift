//
//  ItemTableViewCell.swift
//  TodoList
//
//  Created by Ajin on 15/07/22.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var todo: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var priorityColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
