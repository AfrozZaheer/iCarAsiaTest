//
//  HomeViewController.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 01/05/2023.
//

import UIKit

protocol HomeViewInputs: AnyObject {
    func didFetch()
}

class HomeViewController: BaseViewController {

    //MARK: - IBoutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Static function
    
    static func instantiate() -> HomeViewController {
        return UIStoryboard.home.instantiateInitialViewController() as! HomeViewController
    }
    //MARK: - Propetries
    
    var homeVM: HomeViewModel<HomeApiLoader>?
    var contactlist: [Contact]?
    
    //MARK: - Controller flow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.title = homeVM?.title
        homeVM?.getContacts()
        
    }
    
    override func bindWithVM(vm: ViewModel) {
        self.homeVM = vm as? HomeViewModel
    }
    
    //MARK: - Methods
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactsTableViewCell")
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.refreshControl = refresh
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didClickedAdd))
        rightBarButton.tintColor = UIColor.appMainColor
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @objc private func refreshList() {
        contactlist?.removeAll()
        tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {[unowned self] in
            homeVM?.getContacts()
        })
    }
    
    @objc private func didClickedAdd() {
        self.homeVM?.moveToDetail(contact: nil)
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let list = contactlist else {return UITableViewCell()}
        let item = list[indexPath.row]
        let cellVM = ContactCellViewModel(name: "\(String(describing: item.firstName ?? "-"))", img: nil)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as? ContactsTableViewCell else {return UITableViewCell()}
        cell.updateWith(vm: cellVM)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactlist?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = contactlist?[indexPath.item]
        self.homeVM?.moveToDetail(contact: item)

    }
    
}

//MARK: - HomeViewInputs

extension HomeViewController: HomeViewInputs {
    func didFetch() {
        tableView.refreshControl?.endRefreshing()
        self.contactlist = homeVM?.contactList
        self.tableView.reloadData()
    }
}
