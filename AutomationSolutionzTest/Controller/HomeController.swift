//
//  HomeController.swift
//  AutomationSolutionzTest
//
//  Created by Sohanur Rahman on 6/11/22.
//

import UIKit

let JSON_DATA_NAME = "StoreData"

class HomeController: UIViewController {
    
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var storeDataTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var storeResponseModel = [StoreResponseModel]()
    
    // We will use secondary array for data manipulation
    var storeList = [StoreResponseModel]()
    
    var selectedProduct = StoreResponseModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        getData()
    }
    
    func initView(){
        searchTextField.delegate = self
        searchTextField.borderStyle = .none
        searchTextField.setLeftPaddingPoints(35)
        
        menuStackView.layer.cornerRadius = 20
        menuStackView.layer.masksToBounds = true
        
        storeDataTableView.dataSource = self
        storeDataTableView.delegate = self
        storeDataTableView.separatorStyle = .none
        storeDataTableView.register(UINib(nibName: StoreDataTableViewCell.identifire, bundle: nil), forCellReuseIdentifier: StoreDataTableViewCell.identifire)
    }
    
    func getData() {
        RestApiRequest.getDataFromJSON(fileName: JSON_DATA_NAME, decodableModel: [StoreResponseModel].self, successCompletionHandler: successCompletionHandler, errorCompletionHandler: errorCompletionHandler)
    }
    
    func successCompletionHandler(data: [StoreResponseModel]) {
        print("Data Retrive Successfully Done. \(data)")
        storeResponseModel = data
        
        // Assiging ID Manually
        for index in 0...storeResponseModel.count - 1 {
            storeResponseModel[index].id = (index + 1)
        }
        
        reloadCollectionViewWithData(storeResponseModel)
    }
    
    func searchData(searchKey: String){
        if searchKey.isEmpty{
            reloadCollectionViewWithData(storeResponseModel)
        }
        else{
            reloadCollectionViewWithData(storeResponseModel.filter{ ($0.name ?? "").lowercased().contains(searchKey.lowercased()) })
        }
    }
    
    func reloadCollectionViewWithData(_ data: [StoreResponseModel]){
        storeList = data
        DispatchQueue.main.async {
            self.storeDataTableView.reloadData()
        }
    }
    
    func errorCompletionHandler(error: String) {
        print("Failed To get Data: \(error)")
    }
    
    @IBAction func bookButtonAction(_ sender: Any) {
        if (selectedProduct.id ?? 0) == 0 {
            self.addAlert(title: "Failed!", message: "Please select item from avove to Book")
        }
        else if !(selectedProduct.availability ?? true){
            self.addAlert(title: "Failed!", message: "Selected Item is not available to Book")
        }
        else{
            let bookItemView = BookItemView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
            bookItemView.bindData(data: selectedProduct)
            bookItemView.viewController = self
            view.addSubview(bookItemView)
        }
    }
}


extension HomeController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            if searchTextField.text!.isEmpty {
                searchData(searchKey: "")
            }
            else{
                searchData(searchKey: searchTextField.text!)
            }
            return false
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                var str = searchTextField.text!
                str.removeLast()
                if str.isEmpty {
                    searchData(searchKey: "")
                }
                else{
                    searchData(searchKey: str)
                }
            }
            else{
                searchData(searchKey: searchTextField.text! + string)
            }
        }
        return true
    }
}

extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreDataTableViewCell.identifire) as! StoreDataTableViewCell
        cell.bindData(storeList[indexPath.row])
        return cell
    }
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = storeList[indexPath.row]
    }
}

