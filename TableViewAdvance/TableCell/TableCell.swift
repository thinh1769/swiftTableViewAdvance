//
//  TableCell.swift
//  TableViewAdvance
//
//  Created by Nguyễn Thịnh on 15/06/2022.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var idTableCellLabel: UILabel!
    @IBOutlet weak var nameTableCellLabel: UILabel!
    
    var buttonAction : (() -> ())?
    var tableCellData: TableData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setUpTableCell() {
        idTableCellLabel.text = "id: \(tableCellData?.id ?? 0)"
        nameTableCellLabel.text = "name: \(tableCellData?.name ?? "")"
    }
    @IBAction func addButton(_ sender: UIButton) {
        buttonAction?()
    }
}
