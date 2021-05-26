import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseDatabase


class finalQuerryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

     var ref : DatabaseReference!
    
    var solutions1 = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard (Auth.auth().currentUser?.uid) != nil else {
            return
        }
        ref = Database.database().reference()

        let titleRef = self.ref.child("users/querry/description of the querry")
         titleRef.queryOrdered(byChild: "solution").observe(.childAdded, with: { snapshot in

             if let fsol = (snapshot.value as AnyObject)["solution"]! as? String
             {
                print(fsol)
             
                self.solutions1.append(fsol)

                 // Double-check that the correct data is being pulled by printing to the console.
                print("\(self.solutions1)")
                print(myIndex)

                 // async download so need to reload the table that this data feeds into.
                
             }
            
            self.finalTableView.reloadData()
            self.finalTableView.delegate=self
            self.finalTableView.dataSource=self
         })

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var finalTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return solutions1.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=finalTableView.dequeueReusableCell(withIdentifier: "iden3", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.text=solutions1[indexPath.row]
        cell.textLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segway", sender: self)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
