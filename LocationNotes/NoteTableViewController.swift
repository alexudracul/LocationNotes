//
//  NoteTableViewController.swift
//  LocationNotes
//
//  Created by Aleksey Lavrukhin on 24.07.2020.
//  Copyright © 2020 Aleksey Lavrukhin. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    var note: Note?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var textDescription: UITextView!
    @IBOutlet weak var labelFolder: UILabel!
    @IBOutlet weak var labelFolderTitle: UILabel!
    
    @IBAction func pushDoneAction(_ sender: Any) {
        saveNote()
        navigationController?.popViewController(animated: true)
    }
    
    func saveNote() {
        if note?.title != textTitle.text || note?.textDescription != textDescription.text || note?.imageActual != imageView.image {
            note?.dateUpdate = NSDate() as Date
        }
        note?.title = textTitle.text
        note?.textDescription = textDescription.text
        note?.imageActual = imageView.image
        
        CoreDataManager.sharedInstance.saveContext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let folder = note?.folder {
            labelFolderTitle.text = folder.title
        } else {
            labelFolderTitle.text = "-"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = note?.title
        textTitle.text = note?.title
        textDescription.text = note?.textDescription
        imageView.image = note?.imageActual
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 && indexPath.section == 0 {    
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType(rawValue: 1)!) {
                let actionCamera = UIAlertAction(title: "Make a photo", style: UIAlertAction.Style.default) { (action) in
                    self.imagePicker.sourceType = .camera
                    self.imagePicker.delegate = self
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
                alertController.addAction(actionCamera)
            }
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType(rawValue: 0)!) {
                let actionPhoto = UIAlertAction(title: "Select from library", style: UIAlertAction.Style.default) { (action) in
                    self.imagePicker.sourceType = .savedPhotosAlbum
                    self.imagePicker.delegate = self
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
                alertController.addAction(actionPhoto)
            }
            
            if self.imageView.image != nil {
                let actionDelete = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive) { (action) in self.imageView.image = nil
                }
                alertController.addAction(actionDelete)
            }
            
            let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(actionCancel)
            
            present(alertController, animated: true, completion: nil)
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        if segue.identifier == "goToSelectFolder" {
            (segue.destination as! SelectFolderTableViewController).note = note
        }
    }
    
}

extension NoteTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
