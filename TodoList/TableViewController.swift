//
//  TableViewController.swift
//  TodoList
//
//  Created by Ajin on 13/07/22.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var category = CategoryData()
    
    var appD = UIApplication.shared.delegate as! AppDelegate
    var moc: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moc = appD.persistentContainer.viewContext
        category.loadItemData(moc: moc)
        
    }
    
    //UI outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //UI component actions
    @IBAction func addItems(_ sender: UIBarButtonItem) {
        let alertToAdd = UIAlertController(title: "Add Category", message: nil, preferredStyle: .alert)
        alertToAdd.addTextField { (textField) in
            textField.placeholder = "Enter the Category"
        }
        
        let ok = UIAlertAction(title: "Ok", style: .default) { (alert) in
            guard let fields = alertToAdd.textFields else{return}
            self.category.saveItemData(moc: self.moc!, item: fields[0].text!)
            self.category.loadItemData(moc: self.moc)
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertToAdd.addAction(ok)
        alertToAdd.addAction(cancel)
        self.present(alertToAdd, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (category.items.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell

        // Configure the cell...
        cell.Category.text = category.items[indexPath.row].item

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toItems", sender: self)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let itemTable = segue.destination as! ItemTableViewController
        if let index = tableView.indexPathForSelectedRow{
            itemTable.selectedCategroy = category.items[index.row]
        }
    }
    

}

//MARK: - Search bar
extension TableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let predicate = NSPredicate(format: "item CONTAINS[c] %@",searchBar.text! )
        category.loadItemData(moc: moc!, predicate: predicate)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            category.loadItemData(moc: moc!)
            tableView.reloadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
