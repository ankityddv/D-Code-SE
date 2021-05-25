import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseDatabase

var myIndex = 1
var descArray = [String]()


class querryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref : DatabaseReference!
    
  
    

    @IBOutlet var querryTableView: UITableView!

    var usertext : String = ""
  
    var tempImageArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        let titleRef = self.ref.child("users/querry")
         titleRef.queryOrdered(byChild: "title of the querry").observe(.childAdded, with: { snapshot in

             if let fbemail = (snapshot.value as AnyObject)["title of the querry"]! as? String
             {
                print(fbemail)
             
                 self.tempImageArray.append(fbemail)

                 // Double-check that the correct data is being pulled by printing to the console.
                 print("\(self.tempImageArray)")
                print(myIndex)

                 // async download so need to reload the table that this data feeds into.
                
             }
            
            self.querryTableView.reloadData()
         })
       
         titleRef.queryOrdered(byChild: "description of the querry").observe(.childAdded, with: { snapshot in
            if let fdesc = (snapshot.value as AnyObject)["description of the querry"]! as? String
               {
                  print(fdesc)
               
                descArray.append(fdesc)

                   // Double-check that the correct data is being pulled by printing to the console.
                print("\(descArray)")

                   // async download so need to reload the table that this data feeds into.
                  
               }
            self.querryTableView.reloadData()
         })
       querryTableView.delegate=self
       querryTableView.dataSource=self
     
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
        }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
    return tempImageArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=querryTableView.dequeueReusableCell(withIdentifier: "iden1", for: indexPath)
        
        
        cell.backgroundColor = .white
        cell.textLabel?.text=self.tempImageArray[indexPath.row]
        cell.textLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segway", sender: self)
    }
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
