
import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var firstLife: UIImageView!
    @IBOutlet weak var secondLife: UIImageView!
    @IBOutlet weak var thirdLife: UIImageView!
    @IBOutlet weak var questionImage: UIImageView!
    
    @IBOutlet weak var questionNum: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    @IBOutlet weak var firstOption: UIButton!
    @IBOutlet weak var secondOption: UIButton!
    @IBOutlet weak var thirdOption: UIButton!
    @IBOutlet weak var fourthOption: UIButton!
    
    var question: Questions?
    var roundNum: Int = 0
    var score: Int = 0
    var badPoint: Int = 0
    var maxRounds: Int = 0
    let MAX_BAD: Int = 3

    
    struct Questions: Codable{
        let data: [Question]
    }
  
    struct Question: Codable {
        let optionalAnswers: [String]
        let imgURL: String
        let rightAnswer: String

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        maxRounds = (question?.data.count)!
        startRound()
        
    }
    
    private func startRound(){
        if(badPoint == MAX_BAD || roundNum == maxRounds){
            NotificationCenter.default.post(name: Notification.Name("score"), object: String(score))
            dismiss(animated: true, completion: nil)
        }else{
            questionImage.image = Downloader.downloadImageWithURL(url: (question?.data[roundNum].imgURL)!)
            roundNum += 1

            firstOption.setTitle(question?.data[roundNum-1].optionalAnswers[0], for: .normal)
            thirdOption.setTitle(question?.data[roundNum-1].optionalAnswers[1], for: .normal)
            secondOption.setTitle(question?.data[roundNum-1].optionalAnswers[2], for: .normal)
            fourthOption.setTitle(question?.data[roundNum-1].optionalAnswers[3], for: .normal)


        }
    }
    @IBAction func upperLeftClicked(_ sender: Any) {
        if(firstOption.currentTitle == question?.data[roundNum-1].rightAnswer){
            score += 1
            self.progressBar.setProgress(Float(Float(roundNum) / Float(maxRounds)), animated: true)
            questionNum.text = String(roundNum+1)
            startRound()
        }else{
            badPoint += 1
            self.progressBar.setProgress(Float(Float(roundNum) / Float(maxRounds)), animated: true)
            questionNum.text = String(roundNum+1)
            if(badPoint == 1){
                thirdLife.isHidden = true
            }else if(badPoint == 2){
                secondLife.isHidden = true
            }else{
                firstLife.isHidden = true
            }
            startRound()
        }
    }
    @IBAction func lowerLeftClicked(_ sender: Any) {
        if(secondOption.currentTitle == question?.data[roundNum-1].rightAnswer){
            score += 1
            self.progressBar.setProgress(Float(Float(roundNum) / Float(maxRounds)), animated: true)
            questionNum.text = String(roundNum+1)
            startRound()
        }else{
            badPoint += 1
            self.progressBar.setProgress(Float(Float(roundNum) / Float(maxRounds)), animated: true)
            questionNum.text = String(roundNum+1)
            if(badPoint == 1){
                thirdLife.isHidden = true
            }else if(badPoint == 2){
                secondLife.isHidden = true
            }else{
                firstLife.isHidden = true
            }
            startRound()
        }
    }
    @IBAction func upperRightClicked(_ sender: Any) {
        if(thirdOption.currentTitle == question?.data[roundNum-1].rightAnswer){
            score += 1
            self.progressBar.setProgress(Float(Float(roundNum) / Float(maxRounds)), animated: true)
            questionNum.text = String(roundNum+1)
            startRound()
        }else{
            badPoint += 1
            self.progressBar.setProgress(Float(Float(roundNum) / Float(maxRounds)), animated: true)
            questionNum.text = String(roundNum+1)
            if(badPoint == 1){
                thirdLife.isHidden = true
            }else if(badPoint == 2){
                secondLife.isHidden = true
            }else{
                firstLife.isHidden = true
            }
            startRound()
        }
    
    }
    @IBAction func lowerRightClicked(_ sender: Any) {
        if(fourthOption.currentTitle == question?.data[roundNum-1].rightAnswer){
            score += 1
            self.progressBar.setProgress(Float(Float(roundNum) / Float(maxRounds)), animated: true)
            questionNum.text = String(roundNum+1)
            startRound()
        }else{
            badPoint += 1
            self.progressBar.setProgress(Float(Float(roundNum) / Float(maxRounds)), animated: true)
            questionNum.text = String(roundNum+1)
            if(badPoint == 1){
                thirdLife.isHidden = true
            }else if(badPoint == 2){
                secondLife.isHidden = true
            }else{
                firstLife.isHidden = true
            }
            startRound()
        }
    }
    
    
    private func parseJSON(){
        guard let path = Bundle.main.path(
            forResource: "document",
            ofType: "json")
        else{
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do{
            let jsonData = try Data(contentsOf: url)
            question = try JSONDecoder().decode(Questions.self, from: jsonData)
        }
        catch{
            print("Error: \(error)")
        }
    }
    
}

class Downloader {
    
    class func downloadImageWithURL(url: String) -> UIImage! {
        
        let date = NSData(contentsOf: URL(string: url)!)
        return UIImage(data: date! as Data)
    }
}


