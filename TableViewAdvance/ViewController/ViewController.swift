//
//  ViewController.swift
//  TableViewAdvance
//
//  Created by Nguyễn Thịnh on 15/06/2022.
//

import UIKit

struct TableData {
    var id: Int = 0
    var name: String = ""
    var isCollapsed : Bool
    var detailData: [DetailData] = []
}
struct DetailData {
    var id: Int = 0
    var detailList: [CellData] = []
}
struct CellData {
    var name: String = ""
}
class ViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    var tableCell = String(describing: TableCell.self)
    var detailCell = String(describing: DetailCell.self)
    var tableData: [TableData] = [
        TableData(id: 1, name: "One", isCollapsed: true, detailData: [
            DetailData(id: 1, detailList: [
                CellData(name: "thinh"),
                CellData(name: "nguyen"),
                CellData(name: "phuc")
            ])
//            DetailData(id: 2, detailList: [
//                CellData(name: "long")
//            ])
        ]),
        TableData(id: 2, name: "Two", isCollapsed: false, detailData: [])
//        TableData(id: 3, name: "Three", isCollapsed: false, detailData: []),
//        TableData(id: 4, name: "Four", isCollapsed: true, detailData: []),
//        TableData(id: 5, name: "Five", isCollapsed: false, detailData: [])
    ]
//    var tableData: [TableData] = [
//        TableData(id: 1, name: "One", isCollapsed: true, detailData: []),
//        TableData(id: 2, name: "Two", isCollapsed: false, detailData: []),
//        TableData(id: 3, name: "Three", isCollapsed: false, detailData: []),
//        TableData(id: 4, name: "Four", isCollapsed: true, detailData: []),
//        TableData(id: 5, name: "Five", isCollapsed: false, detailData: [])
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
}
extension ViewController {
    func setUpTableView() {
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.register(UINib(nibName: self.tableCell, bundle: nil), forCellReuseIdentifier: self.tableCell)
        homeTableView.register(UINib(nibName: self.detailCell, bundle: nil), forCellReuseIdentifier: self.detailCell)
    }
    func pushToDetailView(currentIndex: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.delegate = self
        detailVC.currentIndex = currentIndex
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + tableData[section].detailData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! TableCell
            cell.tableCellData = tableData[indexPath.section]
            cell.setUpTableCell()
            cell.buttonAction = { [unowned self] in
                pushToDetailView(currentIndex: indexPath)
            }
        return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: detailCell, for: indexPath) as! DetailCell
            cell.detailCellData = tableData[indexPath.section].detailData[indexPath.row - 1]
            cell.detailTableView.reloadData()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        } else if tableData[indexPath.section].isCollapsed {
            return CGFloat((tableData[indexPath.section].detailData[indexPath.row-1].detailList.count + 1) * 40)
        } else {
            return 0
        }
    }
    
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: DetailViewControllerelegate {
    func addingDetailCell(detailCell: DetailData, cellData: CellData, currentIndex: IndexPath) {
        if tableData[currentIndex.section].detailData.count == 0 {
            tableData[currentIndex.section].detailData.append(detailCell)
            tableData[currentIndex.section].isCollapsed = true
//            UIView.performWithoutAnimation {
//                homeTableView.reloadSections([currentIndex.section], with: .none)
//            }
            reloadWithoutAnimation(indexSection: [currentIndex.section])
        } else {
            if !checkId(cell: detailCell, index: currentIndex.section) {
                tableData[currentIndex.section].detailData.append(detailCell)
                reloadWithoutAnimation(indexSection: [currentIndex.section])
            } else {
                for (index, element) in tableData[currentIndex.section].detailData.enumerated() {
                    if detailCell.id == element.id {
                        tableData[currentIndex.section].detailData[index].detailList.append(cellData)
                        reloadWithoutAnimation(indexSection: [currentIndex.section])
                        break
                }
                
            }
        }
    }
    func checkId(cell: DetailData, index: Int) -> Bool {
        for (_, element) in tableData[index].detailData.enumerated() {
            if cell.id == element.id {
                return true
            }
        }
        return false
    }
        
        func reloadWithoutAnimation(indexSection: IndexSet) {
            UIView.performWithoutAnimation {
                homeTableView.reloadSections(indexSection, with: .none)
            }
        }
}
}
