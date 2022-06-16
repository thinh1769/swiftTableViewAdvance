//
//  DetailCell.swift
//  TableViewAdvance
//
//  Created by Nguyễn Thịnh on 15/06/2022.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var detailTableView: UITableView!
    
    var detailCellData: DetailData?
    var detailTableViewCell = String(describing: DetailTableViewCell.self)
    var headerDetailTableViewCell = String(describing: HeaderDetailTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpDetailCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension DetailCell {
    func setUpDetailCell() {
        detailTableView.dataSource = self
        detailTableView.delegate = self
        detailTableView.register(UINib(nibName: self.detailTableViewCell, bundle: nil), forCellReuseIdentifier: self.detailTableViewCell)
        detailTableView.register(UINib(nibName: self.headerDetailTableViewCell, bundle: nil), forCellReuseIdentifier: self.headerDetailTableViewCell)
    }
}

extension DetailCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (detailCellData?.detailList.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerDetailTableViewCell, for: indexPath) as! HeaderDetailTableViewCell
            cell.id = detailCellData?.id
            cell.setUpHeaderDetailTableViewCell()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: detailTableViewCell, for: indexPath) as! DetailTableViewCell
            cell.name = detailCellData?.detailList[indexPath.row - 1].name
            cell.setUpDetailTableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

extension DetailCell: UITableViewDelegate {
}
