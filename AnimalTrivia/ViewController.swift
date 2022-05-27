//
//  ViewController.swift
//  AnimalTrivia
//
//  Created by user216781 on 5/27/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lastScore_LBL: UILabel!

        

        override func viewDidLoad() {

            super.viewDidLoad()

            lastScore_LBL.isHidden = true

            NotificationCenter.default.addObserver(self, selector: #selector(getScore(_:)), name: Notification.Name("score"), object: nil)

        }

        

        @objc func getScore(_ notification: Notification){

            let score = notification.object as! String?

            lastScore_LBL.isHidden = false

            lastScore_LBL.text = "Latest game score: " + score!

        }



        @IBAction func startGame(_ sender: Any) {

            guard let vc = storyboard?.instantiateViewController(withIdentifier: "GameScreen") as? GameViewController else{

                return

            }

            vc.modalPresentationStyle = .fullScreen

            vc.modalTransitionStyle = .coverVertical

            present(vc, animated: true)

        }


}

