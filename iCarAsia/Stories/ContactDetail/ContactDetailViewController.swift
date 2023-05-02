//
//  ContactDetailViewController.swift
//  iCarAsia
//
//  Created by Afroz Zaheer on 02/05/2023.
//

import UIKit

protocol ContactDetailViewControllerInputs: AnyObject {
    func updateUIWith(contact: Contact?)
}

class ContactDetailViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Static function
    static func instantiate() -> ContactDetailViewController {
        return UIStoryboard.contactDetail.instantiateInitialViewController() as! ContactDetailViewController
    }
    //MARK: - Properties
    var contactDetailVM: ContactDetailViewModel?
    private var contact: Contact?
    //MARK: - Controller flow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = contactDetailVM?.title
        setupView()
        contactDetailVM?.loadData()
    }
    
    override func bindWithVM(vm: ViewModel) {
        self.contactDetailVM = vm as? ContactDetailViewModel
    }
    
    //MARK: - Methods
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InformationTableViewCell", bundle: nil), forCellReuseIdentifier: "InformationTableViewCell")
        tableView.register(UINib(nibName: "ProfilePicTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfilePicTableViewCell")
        
        let rightNavBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveContact))
        rightNavBtn.tintColor = UIColor.appMainColor
        self.navigationItem.rightBarButtonItem = rightNavBtn
    }
    
    @objc private func saveContact() {
        self.view.endEditing(true)
        guard let contact = self.contact else {return}
        contactDetailVM?.addContactToList(contact: contact)
    }
}

extension ContactDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {return 1}
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfilePicTableViewCell") else {return UITableViewCell()}
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell") as? InformationTableViewCell else {return UITableViewCell()}
            cell.delegate = self
            var cellVM: InformationTableCellViewModel

            if indexPath.row == 0 {
                cellVM = InformationTableCellViewModel(type: .firstName, text: contact?.firstName ?? "")
            } else {
                cellVM = InformationTableCellViewModel(type: .lastName, text: contact?.lastName ?? "")
            }
            cell.updateUIWith(vm: cellVM)
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InformationTableViewCell") as? InformationTableViewCell else {return UITableViewCell()}
            cell.delegate = self
            var cellVM: InformationTableCellViewModel
            if indexPath.row == 0 {
                cellVM = InformationTableCellViewModel(type: .email, text: contact?.email ?? "")
            } else {
                cellVM = InformationTableCellViewModel(type: .phone, text: contact?.phone ?? "")
            }
            cell.updateUIWith(vm: cellVM)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Main Information"
        } else if section == 2 {
            return "Sub information"
        }
        return nil
    }
    
    
}

extension ContactDetailViewController: InformationTableViewCellDelegate {
    func infoCell(_ cell: InformationTableViewCell, updateTextField text: String, fieldType: InfomationFieldType) {
        let newContact = Contact(id: self.contact?.id, firstName: self.contact?.firstName, lastName: self.contact?.lastName, email: self.contact?.email, phone: self.contact?.phone)
        switch fieldType {
        case .firstName:
            newContact.firstName = text
        case .lastName:
            newContact.lastName = text

        case .email:
            newContact.email = text

        case .phone:
            newContact.phone = text
        }
        self.contact = newContact
    }
}

extension ContactDetailViewController: ContactDetailViewControllerInputs {
    func updateUIWith(contact: Contact?) {
        self.contact = contact
        self.tableView.reloadData()
    }
}
