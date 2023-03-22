
import UIKit
import Firebase

class HomeCell: UITableViewCell {
    @IBOutlet weak var mailLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeCounter: UILabel!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var hiddenIDLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
         // getData
        let firestore = Firestore.firestore()
        
        
            
    }
}
