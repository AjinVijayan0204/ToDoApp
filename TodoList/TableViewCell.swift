//
//  TableViewCell.swift
//  TodoList
//
//  Created by Ajin on 13/07/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var Category: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
