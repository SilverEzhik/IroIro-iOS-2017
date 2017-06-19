//
//  TagsTableViewController.swift
//  IroIro
//
//  Created by neoman nouiouat on 6/6/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit
import CoreData

class TagsTableViewController: UITableViewController, UISearchResultsUpdating, NSFetchedResultsControllerDelegate {
    var tags:[Tag] = []
    
    var searchController : UISearchController!
    var searchResults:[Tag] = []

    //coredata
    var fetchResultsController : NSFetchedResultsController<Tag>!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        //coredata
        let fetchRequest : NSFetchRequest<Tag> = Tag.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            
            do{
                try fetchResultsController.performFetch()
                if let fetchedObjects = fetchResultsController.fetchedObjects {
                    tags = fetchedObjects
                }
            } catch{
                print(error)
            }
        }
        //coredataend
        
        //THIS IS IMPORTANT
        //With this, even though the tags list is the first view, when the app starts, it will load the list of all notes.
        //TODO: ENSURE THAT IT LOADS THE ALL NOTES VIEW AND NOT A TAG VIEW
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "NotesListView")
        self.navigationController?.pushViewController(secondViewController!, animated: false)

        //setup tableView colors
        self.view.backgroundColor = UIColor.black
        let bgView = UIView()
        bgView.backgroundColor = UIColor.black
        self.tableView.backgroundView = bgView
        //self.tableView.tableFooterView = bgView
        
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        //setup search bar colors
        self.searchController.searchBar.backgroundColor = UIColor.black
        self.searchController.searchBar.barTintColor = UIColor(hexString: "141414")
        let textFieldInsideSearchBar = self.searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        textFieldInsideSearchBar?.backgroundColor = UIColor.black
        
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.tableView.tableHeaderView = self.searchController.searchBar

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //coredata
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
            
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            tags = fetchedObjects as! [Tag]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    //coredataend

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: search stuff
    
    func filterContentForSearchText(searchText: String) { //not sure why it gives error here
        searchResults = tags.filter({(tag:Tag)->Bool in
            let match = tag.name?.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            return match != nil
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let textToSearch = searchController.searchBar.text {
            filterContentForSearchText(searchText: textToSearch)
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive{
            return searchResults.count
        }
        return tags.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath) as! TagCell
        var cellItem:Tag

        if searchController.isActive{
            cellItem = searchResults[indexPath.row]
        }
        else{
             cellItem = tags[indexPath.row]
        }
        cell.name?.text = cellItem.name
        cell.color = cellItem.color as! UIColor
        cell.count.text = String(describing: cellItem.notes?.count)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { //still need to add in deleting it from core data
            // Delete the row from the data source
            if searchController.isActive{
                searchResults.remove(at: indexPath.row) //not really necessary but will let them skim down on search results they find as clutter
            }
            else{
                tags.remove(at: indexPath.row)
               
            }
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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
        if (segue.identifier == "showTaggedNotes") {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let noteVC = segue.destination as! NotesTableViewController
                if searchController.isActive {
                    noteVC.tag = searchResults[indexPath.row].name
                    
                }
                else {
                    noteVC.tag = tags[indexPath.row].name
                }
            }
        }
    }


}
