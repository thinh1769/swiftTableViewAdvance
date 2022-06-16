//
//  DetailTableViewCell.swift
//  TableViewAdvance
//
//  Created by Nguyễn Thịnh on 15/06/2022.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    var name: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpDetailTableViewCell() {
        nameLabel.text = "name: \(name ?? "")"
    }
}
