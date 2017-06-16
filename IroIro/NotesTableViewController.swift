//
//  NotesTableViewController.swift
//  IroIro
//
//  Created by neoman nouiouat on 6/6/17.
//  Copyright © 2017 DeAnza. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController, UISearchResultsUpdating {
    var tag :String! = "all"
    
    var notes:[Note] = []
    
    var searchController : UISearchController!
    var searchResults:[Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: search stuff
    
    func filterContentForSearchText(searchText: String) {
        searchResults = notes.filter({ (note: Note) -> Bool in
            let nameMatch = note.name?.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            let contentMatch = (note.content as! NSAttributedString).string.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            return nameMatch != nil || contentMatch != nil})
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
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteCell
        var cellItem:Note
        
        if searchController.isActive{
            cellItem = searchResults[indexPath.row]
        }
        else{
            cellItem = notes[indexPath.row]
        }
        cell.name?.text = cellItem.name
        cell.content.text = (cellItem.content as! NSAttributedString).string
        cell.time.text = String (cellItem.time)
        
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        if (segue.identifier == "showNote") {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let noteVC = segue.destination as! NoteViewController
                if searchController.isActive {
                    noteVC.note = searchResults[indexPath.row]
                    
                }
                else {
                    noteVC.note = notes[indexPath.row]
                }
            }
        }
    }

    
    //TODO: CALL FUNCTIONS WHEN COLOR BUTTON NEEDS TO BE HIDDEN/SHOWN
    //(no color on all notes/untagged)
    func hideColorButton() {
        self.navigationItem.rightBarButtonItems = [AddButton]
    }
    func showColorButton() {
        self.navigationItem.rightBarButtonItems = [AddButton, ColorButton]
    }
    
    //temp
    var colorIsShown : Bool = true
    
    @IBOutlet var AddButton: UIBarButtonItem!
    @IBAction func AddButtonPress(_ sender: Any) {
        
        //temp
        if colorIsShown == true {
            colorIsShown = false
            hideColorButton()
        } else {
            colorIsShown = true
            showColorButton()
        }
    }
    
    func setColor(color: UIColor) {
        //TODO: ADJUST THE TAG COLOR HERE.
        //print(color)
        UIView.animate(withDuration: 0.5, animations: {
            UIApplication.shared.delegate?.window??.tintColor = color
        })
    }
    
    var colorPopup : ColorPopup!
    
    @IBOutlet var ColorButton: UIBarButtonItem!
    @IBAction func ColorButtonPress(_ sender: Any) {
        colorPopup = ColorPopup(callback: setColor(color:))
    }
    

}
