//
//  ViewController.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 12/11/2021.
//

import UIKit
import RxCocoa
import RxSwift


class NewslistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    var newslistViewModel : NewslistViewModel!
    var bag = DisposeBag()
    var newfetchdata = NewsRepoApi()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       fetchdata(selected: 1)
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        tableView.separatorColor = UIColor.darkGray
        tableView.separatorInset = .zero
        navigationItem.title="Ny Time Most Popular Article"

    }
    @IBAction func didChangeSegment(_ sender : UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            fetchdata(selected: 1)
        }
        else if sender.selectedSegmentIndex == 1 {
            fetchdata(selected: 7)
        }else {
            fetchdata(selected: 30)
        }
            
        
    }
    func fetchdata(selected : Int){
        
        newfetchdata.fetchallData(nb: selected){ result in
            self.newslistViewModel = NewslistViewModel(result)
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        
        let articleVM = newslistViewModel.articlesVM[indexPath.row]
        articleVM.title.asDriver(onErrorJustReturn: "")
        .drive(cell.titleLable.rx.text)
        .disposed(by: bag)
        cell .imagev.load(urlString: newslistViewModel.articlesVM[indexPath.row].imageurl)
//        cell.titleLable.text = newslistViewModel.articlesVM[indexPath.row].title
        cell.ByName.text = newslistViewModel.articlesVM[indexPath.row].byLine
        cell.DateText.text = newslistViewModel.articlesVM[indexPath.row].publishdate
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
           return self.newslistViewModel == nil ? 0 : self.newslistViewModel.numberOfSections
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.newslistViewModel.numberOfRowsInSection(section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 133
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let  selectednews = self.newslistViewModel.newsAtindex(indexPath.row)
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsNews")as! DetailsViewController
        selectednews.title.bind(onNext: {titletext in
            vc.titletext1 = titletext
        }).disposed(by: bag)
        

        vc.abstrack1 = selectednews.abstract
        vc.byLine = selectednews.byLine
        vc.imagelink = selectednews.thumb
        vc.updated = selectednews.updated
               navigationController?.pushViewController(vc, animated: true)
    }
    
}



