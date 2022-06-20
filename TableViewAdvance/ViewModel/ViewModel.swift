//
//  ViewModel.swift
//  TableViewAdvance
//
//  Created by Nguyễn Thịnh on 20/06/2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModel {
    var cellViewModels : BehaviorRelay<[TableData]> {get}
    func setUpData()
    func addTableData(detailCell: DetailData, index: Int)
    func addCellData(cellData: CellData, section: Int, index: Int)
}
