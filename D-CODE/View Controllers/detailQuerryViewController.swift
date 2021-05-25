import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseDatabase

class detailQuerryViewController: UIViewController {

    @IBOutlet var desc: UITextField!
    @IBOutlet var titleTestField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func postPressed(_ sender: Any) {
        
        guard let titleText = self.titleTestField.text, !titleText.isEmpty else { return}
        guard let descText = self.desc.text, !descText.isEmpty else { return}
        
        let values = ["title of the querry": titleText, "description of the querry": descText ]
        Database.database().reference().child("users/querry").childByAutoId().updateChildValues(values){
          (error:Error?, ref:DatabaseReference) in
            if let error = error {
            print("Data could not be saved: \(error).")
          } else {
            print("Data saved successfully!")
          }
        }
        
        let s = ["solutions": "-"]
        Database.database().reference().child("users/querry/description of the querry").childByAutoId().updateChildValues(s)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
