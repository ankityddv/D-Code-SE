import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseDatabase

var solutions = [String]()

class answerQuerryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ref : DatabaseReference!
    
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var answerTableView: UITableView!
    @IBOutlet var answertextField: UITextField!
    @IBOutlet var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        let titleRef = self.ref.child("users/querry/description of the querry")
         titleRef.queryOrdered(byChild: "solution").observe(.childAdded, with: { snapshot in

             if let fsol = (snapshot.value as AnyObject)["solution"]! as? String
             {
                print(fsol)
             
                 solutions.append(fsol)

                 // Double-check that the correct data is being pulled by printing to the console.
                 print("\(solutions)")
                print(myIndex)
             }
            
            self.answerTableView.reloadData()
         })
      
        answerTableView.delegate=self
        answerTableView.dataSource=self
        print(myIndex)
        
        descLabel.text = descArray[myIndex]

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
    return descArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=answerTableView.dequeueReusableCell(withIdentifier: "iden2", for: indexPath)
        
        
        cell.backgroundColor = .white
        cell.textLabel?.text=descArray[indexPath.row]
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
    @IBAction func postButtonPressed(_ sender: Any) {
       guard let postText = self.answertextField.text, !postText.isEmpty else { return}
        let values = ["sol": postText]
        Database.database().reference().child("users/querry/description of the querry").child("\(Auth.auth().currentUser!.uid)").updateChildValues(values) {
          (error:Error?, ref:DatabaseReference) in
          
            if let error = error {
            print("Data could not be saved: \(error).")
          } else {
            print("Data saved successfully!")
          }
        }
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
