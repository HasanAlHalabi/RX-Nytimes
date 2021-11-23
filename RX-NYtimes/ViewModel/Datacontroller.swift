//
//  Datacontroller.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 23/11/2021.
//

import Foundation
import UIKit
import RxSwift
//class DataSource: NSObject, UITableViewDataSource, ObserverType {
//    init(tableView: UITableView) {
//        self.tableView = tableView
//        super.init()
//        tableView.dataSource = self
//    }
//
//    func on(_ event: Event<[Post]>) {
//        switch event {
//        case .next(let newData):
//            data = newData
//            tableView.reloadData()
//        case .error(let error):
//            print("there was an error: \(error)")
//        case .completed:
//            data = []
//            tableView.reloadData()
//        }
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = data[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        // configure cell with item
//        return cell
//    }
//
//    let tableView: UITableView
//    var data: [Post] = []
//}
