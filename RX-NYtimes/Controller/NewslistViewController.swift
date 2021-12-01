//
//  ViewController.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 12/11/2021.
//

import UIKit
//import RxCocoa
import RxSwift


class NewslistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let LoadingAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    var NewListVM = NewsListViewModel()
    var bag = DisposeBag()
    private var newslist : [Post] = []
    let ErrorAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating();
        
        LoadingAlert.view.addSubview(loadingIndicator)
        getdata(index: 1)
        setupBinding()
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        tableView.separatorColor = UIColor.darkGray
        tableView.separatorInset = UIEdgeInsets(top: 20,left: 20,bottom: 20,right: 20)
        navigationItem.title="Ny Time Most Popular Article"
        
        
        
        
    }
    //        MARK: - SEGMENT SELLECTION
    @IBAction func didChangeSegment(_ sender : UISegmentedControl){
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        if sender.selectedSegmentIndex == 0 {
            cell.imagev = nil
                updateTableviewWhenSegmentChange(time:1)
            self.tableView.setContentOffset(.zero, animated:true)
        }
        else if sender.selectedSegmentIndex == 1 {
            cell.imagev = nil
            updateTableviewWhenSegmentChange(time:7)
            self.tableView.setContentOffset(.zero, animated:true)
        }else {
            cell.imagev = nil
            updateTableviewWhenSegmentChange(time:30)
            self.tableView.setContentOffset(.zero, animated:true)
        }
        
        
    }
    //        MARK: - BINDING
    private func setupBinding(){
        NewListVM.news.asObserver().subscribe(onNext: {  newslist in
            DispatchQueue.main.async {
                self.newslist = newslist
                self.tableView.reloadData()
                
            }
            
        }).disposed(by: bag)
        NewListVM.error.asObserver().subscribe(onNext: { error in
            if !error.isEmpty{
                self.ErrorAlert.title = error
                self.present(self.ErrorAlert, animated: true, completion: nil)
            }else{
                self.ErrorAlert.dismiss(animated: true, completion: nil)
            }
        }).disposed(by: bag)
        NewListVM.isLoading.asObserver().subscribe(onNext: { load in
            if load == true {
               
                self.present(self.LoadingAlert, animated: true, completion: nil)
            }else {
                DispatchQueue.main.async {
//                    self.dismiss(animated: false, completion: nil)
                    self.LoadingAlert.dismiss(animated: false, completion: nil)
                }
//
               
            }
        }).disposed(by: bag)
        
        
    }
    //        MARK: - tablew update When Segment Change
    func updateTableviewWhenSegmentChange(time:Int){
      getdata(index: time)
      
    }
    
    func getdata(index: Int){
        
        NewListVM.requestData(time: index)
        
    }
}




extension NewslistViewController{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectednews = self.newslist[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsNews")as! DetailsViewController
        vc.titletext1 = selectednews.title
        vc.abstrack1 = selectednews.abstract
        vc.byLine = selectednews.byline
        vc.imagelink = selectednews.media?.first?.metadata[2].url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png"
        vc.updated = selectednews.updated
        vc.url1 = selectednews.url
        vc.keyword = selectednews.adx_keywords
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newslist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        
        cell.titleLable.text = self.newslist[indexPath.row].title
        cell.ByName.text = self.newslist[indexPath.row].byline
        cell.DateText.text = self.newslist[indexPath.row].published_date
        cell.imagev.load(urlString: self.newslist[indexPath.row].media?.first?.metadata[2].url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png")
        
        
        return cell
    }
    
}
