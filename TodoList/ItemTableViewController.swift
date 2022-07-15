//
//  ItemTableViewController.swift
//  TodoList
//
//  Created by Ajin on 15/07/22.
//

import UIKit
import CoreData

class ItemTableViewController: UITableViewController {
    
    var selectedCategroy:Category?
    var itemData = ItemData()
    var colorData = ColorData()
    var selectedPriority:String?

    var appD = UIApplication.shared.delegate as! AppDelegate
    var moc: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print(selectedCategroy)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moc = appD.persistentContainer.viewContext
        let predicate = NSPredicate(format: "parentRelationship.item MATCHES %@", selectedCategroy!.item!)
        itemData.loadItemData(moc: moc!, predicate: predicate)
    }
    
    //MARK: - UI functions
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        print("Clicked")
        self.dismiss(animated: true)
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        //defining picker view
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250, height: 300)
        let pickerView = UIPickerView(frame: CGRect(x: 10, y: 0, width: 250, height: 300))
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        vc.view.addSubview(pickerView)
        
        let alertToAdd = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        alertToAdd.addTextField { (textField) in
            textField.placeholder = "Enter the Category"
        }
        
        //adding pickerview into alert
        alertToAdd.setValue(vc, forKey: "contentViewController")
        
        
        let ok = UIAlertAction(title: "Ok", style: .default) { (alert) in
            guard let fields = alertToAdd.textFields else{return}
            self.itemData.saveItemData(moc: self.moc!, name: alertToAdd.textFields![0].text!, priroty: self.selectedPriority!, done: true, parent: self.selectedCategroy!)
            let predicate = NSPredicate(format: "parentRelationship.item MATCHES %@", self.selectedCategroy!.item!)
            self.itemData.loadItemData(moc: self.moc!, predicate: predicate)
            
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertToAdd.addAction(ok)
        alertToAdd.addAction(cancel)
        self.present(alertToAdd, animated: true, completion: nil)
        
    }
    
    @IBAction func filter(_ sender: UIButton) {
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemData.items!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ItemTableViewCell

        // Configure the cell...
        cell.todo.text = itemData.items![indexPath.row].name
        cell.checkMark.isHidden = itemData.items![indexPath.row].done ? false : true
        cell.priorityColor.backgroundColor = colorData.colorList[itemData.items![indexPath.row].priority!]

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemData.items![indexPath.row].done = !itemData.items![indexPath.row].done
        itemData.doSave(moc: moc)
        
        tableView.reloadData()
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ItemTableViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorData.colorList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(colorData.colorList)[row].key
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = Array(colorData.colorList)[row].key
    }
}


extension ItemTableViewController: UISearchBarDelegate{
    
}
