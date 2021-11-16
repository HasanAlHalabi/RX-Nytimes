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
       fetchdata()
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        tableView.separatorColor = UIColor.darkGray
        tableView.separatorInset = .zero
        navigationItem.title="Ny Time Most Popular Article"
//        bindListData()
        // Do any additional setup after loading the view.
    }
    
    func fetchdata(){
        
        newfetchdata.fetchallData{ result in
            self.newslistViewModel = NewslistViewModel(result)
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }
    }
//    func bindListData(){
//        newslistViewModel.articles.bind(to: tableView.rx.items(cellIdentifier: "MessageCell", cellType: MessageCell.self)){ row,iten, cell in
//
//            cell.titleLable.text = iten.title
//            cell.ByName.text = iten.byline
//            cell.DateText.text = iten.published_date
//            let mediaMetaData = iten.media?.first?.metadata
//
//            cell.imagev.load(urlString: mediaMetaData?.first?.url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png")
//        }.disposed(by: bag)
//        tableView.rx.modelSelected(Post.self).bind{
//            article in
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsNews")as! DetailsViewController
//            vc.titletext1 = article.title
//            vc.updated = article.updated
//            vc.byLine = article.byline
//            vc.abstrack1 = article.abstract
//            vc.keyword = article.adx_keywords
//            vc.imagelink = article.media?.first?.metadata[2].url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png"
//            self.navigationController?.pushViewController(vc, animated: true)
//        }.disposed(by: bag)
//
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        
        
        
        cell .imagev.load(urlString: newslistViewModel.articlesVM[indexPath.row].imageurl)
        cell.titleLable.text = newslistViewModel.articlesVM[indexPath.row].title
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
               vc.titletext1 = selectednews.title
        vc.abstrack1 = selectednews.abstract
        vc.byLine = selectednews.byLine
        vc.imagelink = selectednews.thumb
        vc.updated = selectednews.updated
               navigationController?.pushViewController(vc, animated: true)
    }
    
}



