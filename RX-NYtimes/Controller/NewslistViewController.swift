//
//  ViewController.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 12/11/2021.
//

import UIKit
import RxCocoa
import RxSwift


class NewslistViewController: UIViewController, UITableViewDelegate {
   var newslistViewModel = NewslistViewModel()
    var bag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
       
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        tableView.separatorColor = UIColor.darkGray
        tableView.separatorInset = .zero
        navigationItem.title="Ny Time Most Popular Article"
        bindListData()
        // Do any additional setup after loading the view.
    }

    func bindListData(){
        newslistViewModel.articles.bind(to: tableView.rx.items(cellIdentifier: "MessageCell", cellType: MessageCell.self)){ row,iten, cell in
           
            cell.titleLable.text = iten.title
            cell.ByName.text = iten.byline
            cell.DateText.text = iten.published_date
            let mediaMetaData = iten.media?.first?.metadata
            
            cell.imagev.load(urlString: mediaMetaData?.first?.url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png")
        }.disposed(by: bag)
        tableView.rx.modelSelected(Post.self).bind{
            article in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsNews")as! DetailsViewController
            vc.titletext1 = article.title
            vc.updated = article.updated
            vc.byLine = article.byline
            vc.abstrack1 = article.abstract
            vc.keyword = article.adx_keywords
            vc.imagelink = article.media?.first?.metadata[2].url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png"
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: bag)
        newslistViewModel.fetchdata()
    }

    
    
}

struct NewslistViewModel{
    let articles = PublishSubject<[Post]>()
    var newfetchdata = NewsRepoApi()
    func fetchdata(){
        newfetchdata.fetchallData{ result in
            articles.onNext(result)
            articles.onCompleted()
        }
    }
}

