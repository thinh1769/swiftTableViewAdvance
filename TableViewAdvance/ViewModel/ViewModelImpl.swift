//
//  ViewModelImpl.swift
//  TableViewAdvance
//
//  Created by Nguyễn Thịnh on 20/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModelImpl: NSObject, ViewModel {
   
    let cellViewModels: BehaviorRelay<[TableData]> = BehaviorRelay(value: [])
    
    override init() {
        super.init()
        setUpData()
    }
    
    func setUpData() {
        var cellViewModels : [TableData] = []
        
        for i in 0...3 {
            cellViewModels.append(TableData(id: i, name: "Number \(i)", isCollapsed: true, detailData: self.createData()))
        }
        
        self.cellViewModels.accept(cellViewModels)
    }
    
    func addTableData(detailCell: DetailData, index: Int) {
        var fakeList : [TableData] = self.cellViewModels.value
        fakeList[index].detailData.append(detailCell)
        fakeList[index].isCollapsed = true
        self.cellViewModels.accept(fakeList)
    }
    
    func addCellData(cellData: CellData, section: Int, index: Int) {
        var fakeList : [TableData] = self.cellViewModels.value
        fakeList[section].detailData[index].detailList.append(cellData)
        self.cellViewModels.accept(fakeList)
    }
    
    func createData() -> [DetailData] {
        var detailDatas: [DetailData] = []
        
        for i in 0...2 {
            detailDatas.append(DetailData(id: i, detailList: self.createCell()))
        }
        return detailDatas
    }
    
    func createCell() -> [CellData] {
        var cellDatas: [CellData] = []
        
        for i in 0...1 {
            cellDatas.append(CellData(name: "No \(i)"))
        }
        return cellDatas
    }
    
}
