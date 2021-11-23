//
//  ViewController.swift
//  RX-NYtimes
//
//  Created by hasan al halabi on 12/11/2021.
//

import UIKit
import RxCocoa
import RxSwift


class NewslistViewController: UIViewController, UITableViewDelegate{
   
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    var NewListVM = NewsListViewModel()
       var bag = DisposeBag()
    
   
   
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        
        setupBinding()
        tableView.delegate = self
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        tableView.separatorColor = UIColor.darkGray
        tableView.separatorInset = .zero
        navigationItem.title="Ny Time Most Popular Article"

       
        //        MARK: - tablew Selection
                tableView.rx.modelSelected(Post.self).bind(onNext: {news in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsNews")as! DetailsViewController

                    vc.titletext1 = news.title
                    vc.abstrack1 = news.abstract
                    vc.byLine = news.byline
                   vc.imagelink = news.media?[0].metadata[2].url ?? "https://1000logos.net/wp-content/uploads/2017/04/Symbol-New-York-Times.png"
                           vc.updated = news.updated
                    vc.url1 = news.url
                    vc.keyword = news.adx_keywords
                    self.navigationController?.pushViewController(vc, animated: true)


                    
                }).disposed(by: bag)
    }
    //        MARK: - SEGMENT SELLECTION
    @IBAction func didChangeSegment(_ sender : UISegmentedControl){
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        if sender.selectedSegmentIndex == 0 {
            self.present(self.alert, animated: true, completion: nil)
            cell.imagev = nil
            NewListVM.requestData(time: 1)
            tableView.setContentOffset(.zero, animated:true)
            
        }
        else if sender.selectedSegmentIndex == 1 {
            self.present(self.alert, animated: true, completion: nil)
            cell.imagev = nil
            NewListVM.requestData(time: 7)
            tableView.setContentOffset(.zero, animated:true)
            
            
        }else {
            self.present(self.alert, animated: true, completion: nil)
            cell.imagev = nil
            NewListVM.requestData(time: 30)
            tableView.setContentOffset(.zero, animated:true)
          
        }
            
        
    }
    //        MARK: - BINDING
    private func setupBinding(){
        present(alert, animated: true, completion: nil)
        NewListVM.requestData(time: 1)
        
        NewListVM.news.bind(to: tableView.rx.items(cellIdentifier: "MessageCell", cellType: MessageCell.self)){ row,iten, cell in
            cell.news = iten
            self.dismiss(animated: false, completion: nil)

                }.disposed(by: bag)
       
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        return cell.frame.height
        }
 
}


