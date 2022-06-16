//
//  DetailViewController.swift
//  TableViewAdvance
//
//  Created by Nguyễn Thịnh on 15/06/2022.
//

import UIKit

protocol DetailViewControllerelegate: NSObject {
    func addingDetailCell(detailCell: DetailData, cellData: CellData, currentIndex: IndexPath)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var detailCell: DetailData?
    var cellData: CellData?
    var currentIndex : IndexPath = [0]
    weak var delegate : DetailViewControllerelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addDetailButton(_ sender: UIButton) {
        let id = Int(idTextField.text ?? "")
        let name = nameTextField.text
        detailCell = DetailData(id: id ?? 0, detailList: [
            CellData(name: name ?? "")
        ])
        cellData = CellData(name: name ?? "")
        self.delegate?.addingDetailCell(detailCell: detailCell!, cellData: cellData!, currentIndex:  currentIndex)
        navigationController?.popToRootViewController(animated: true)
    }
}
