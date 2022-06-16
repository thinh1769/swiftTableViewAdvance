//
//  HeaderDetailTableViewCell.swift
//  TableViewAdvance
//
//  Created by Nguyễn Thịnh on 16/06/2022.
//

import UIKit

class HeaderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    
    var id : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpHeaderDetailTableViewCell() {
        idLabel.text = "id: \(id ?? 0)"
    }
}
