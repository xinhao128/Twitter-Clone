//
//  TweetViewController.swift
//  Twitter
//
//  Created by Xinhao Liang on 2/11/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        tweetTextView.becomeFirstResponder()
    }
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var tweetCharCount: UILabel!
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Tweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let characterLimit = 140
        
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        let cnt = newText.count
        tweetCharCount.text = "\(characterLimit - cnt) characters left";
        return cnt < characterLimit
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
