//
//  ViewController.swift
//  SettingsApp
//
//  Created by Mohan K on 01/12/22.
//

import UIKit


struct Section {
    
    var title:  String
    var options : [SettingsOption]
    
}

struct SettingsOption {
    
    var title: String
    let  icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        return table
    }()
    
    var models = [Section]()
    
    var titleText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        title = "Settings"
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.bounds
        
        view.addSubview(tableView)
        
    }
    
    func configure() {
        
        models.append(Section(title: "General", options:[
            SettingsOption(title: "wifi" , icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            },
            SettingsOption(title: "wifi" , icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            },
            SettingsOption(title: "wifi" , icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            }
        ]))
        
        models.append(Section(title: "Tabs", options:[
            SettingsOption(title: "wifi1" , icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            },
            SettingsOption(title: "wifi2" , icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            },
            SettingsOption(title: "wifi3" , icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            }
        ]))
        models.append(Section(title: "app", options:[
            SettingsOption(title: "wifi00" , icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            },
            SettingsOption(title: "wifi01" , icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            },
            SettingsOption(title: "wifi02" , icon: UIImage(systemName: "house"), iconBackgroundColor: .systemPink) {
                
            }
        ]))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath ) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.section].options[indexPath.row]

        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)

        let alert = UIAlertController(title: "Edit", message: "Edit TableView Row", preferredStyle: .alert)
        let update = UIAlertAction(title: "Update", style: .default) { action in
            
            let updatedModels = self.titleText?.text
            
            self.models[indexPath.section].options[indexPath.row].title = updatedModels!
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        alert.addAction(update)
        alert.addAction(cancel)
        alert.addTextField { textField in
            self.titleText = textField
            self.titleText?.placeholder = "Edit cell Names"
        }
        present(alert, animated: true,completion: nil)

    }
    

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            models[indexPath.section].options.remove(at: indexPath.row)
            
            if(models[indexPath.section].options.count == 0){
                
                models.remove(at: indexPath.section)
                tableView.reloadData()
                
            }else{
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
            }
          
        }
    }

    
}
