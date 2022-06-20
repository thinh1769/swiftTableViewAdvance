//
//  ViewController.swift
//  TableViewAdvance
//
//  Created by Nguyễn Thịnh on 15/06/2022.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    
    var tableCell = String(describing: TableCell.self)
    var detailCell = String(describing: DetailCell.self)
    let viewModel: ViewModel = ViewModelImpl()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        subscribe()
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
    func subscribe() {
        viewModel.cellViewModels.subscribe { _ in
            self.homeTableView.reloadData()
        }.disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.cellViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + viewModel.cellViewModels.value[section].detailData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! TableCell
            cell.tableCellData = viewModel.cellViewModels.value[indexPath.section]
            cell.setUpTableCell()
            cell.buttonAction = { [unowned self] in
                pushToDetailView(currentIndex: indexPath)
            }
        return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: detailCell, for: indexPath) as! DetailCell
            cell.detailCellData =  viewModel.cellViewModels.value[indexPath.section].detailData[indexPath.row - 1]
            cell.detailTableView.reloadData()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        } else if viewModel.cellViewModels.value[indexPath.section].isCollapsed {
            return CGFloat((viewModel.cellViewModels.value[indexPath.section].detailData[indexPath.row - 1].detailList.count + 1) * 40)
        } else {
            return 0
        }
    }
    
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: DetailViewControllerelegate {
    func addingDetailCell(detailCell: DetailData, cellData: CellData, currentIndex: IndexPath) {
        if viewModel.cellViewModels.value[currentIndex.section].detailData.count == 0 {
            viewModel.addTableData(detailCell: detailCell, index: currentIndex.section)
            reloadWithoutAnimation(indexSection: [currentIndex.section])
        } else {
            if !checkId(cell: detailCell, index: currentIndex.section) {
                viewModel.addTableData(detailCell: detailCell, index: currentIndex.section)
                reloadWithoutAnimation(indexSection: [currentIndex.section])
            } else {
                for (index, element) in viewModel.cellViewModels.value[currentIndex.section].detailData.enumerated() {
                    if detailCell.id == element.id {
                        viewModel.addCellData(cellData: cellData, section: currentIndex.section, index: index)
                        reloadWithoutAnimation(indexSection: [currentIndex.section])
                        break
                    }
            }
        }
        }
    func checkId(cell: DetailData, index: Int) -> Bool {
        for (_, element) in viewModel.cellViewModels.value[index].detailData.enumerated() {
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
