import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseDatabase

class profileViewController: UIViewController {

    var ref : DatabaseReference!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let uid = Auth.auth().currentUser?.uid else{
            return
        }
        ref = Database.database().reference()
        let userReference = ref.child("users").child(uid)
        
        userReference.observeSingleEvent(of: .value, with: { (snapshot) in
        
                if let dictionary = snapshot.value as? [String: AnyObject] {
                            let nameText = dictionary["name"] as! String
                     let emailText = dictionary["email"] as! String
                    
                    self.name.text = nameText
                    self.email.text = emailText
                // Do any additional setup after loading the view.
                }
            })
        }
            
    
    @IBAction func logout(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
           try firebaseAuth.signOut()
           print("signedOut")
        }
        catch let signOutError as NSError {
           print("Error signing Out: %@", signOutError)
        }
        performSegue(withIdentifier: "abc6", sender: nil)
               
    }

}
