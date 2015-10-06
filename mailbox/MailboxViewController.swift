//
//  MailboxViewController.swift
//  mailbox
//
//  Created by Nathan Visconti on 10/3/15.
//  Copyright © 2015 Nathan Visconti. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIView!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuView: UIImageView!

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var archiveView: UIImageView!
    @IBOutlet weak var deleteView: UIImageView!
    @IBOutlet weak var laterView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listBoxView: UIImageView!
    
    
    var messageOriginalCenter:CGPoint!
    var messageViewOriginalCenter: CGPoint!
    var archiveOriginalCenter:CGPoint!
    var deleteOriginalCenter:CGPoint!
    var laterOriginalCenter:CGPoint!
    var listOriginalCenter:CGPoint!
    var feedViewOriginalCenter:CGPoint!
    var contentViewOriginalCenter:CGPoint!
    
    func delay(delay:Double, closure:()->()) {
            
            dispatch_after(
                dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        }

    
    
    @IBAction func onPanGestureRecognizer(panGestureRecognizer: UIPanGestureRecognizer) {
        
        var point = panGestureRecognizer.locationInView(view)
        var translation = panGestureRecognizer.translationInView(view).x
        var velocity = panGestureRecognizer.velocityInView(view)
        
        var backgroundColor = messageView.backgroundColor
        
        
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            messageOriginalCenter = messageImageView.center
            messageViewOriginalCenter = messageView.center
            archiveOriginalCenter = archiveView.center
            deleteOriginalCenter = deleteView.center
            laterOriginalCenter = laterView.center
            listOriginalCenter = listView.center
            
            messageView.alpha = 1
            archiveView.alpha = 0
            deleteView.alpha = 0
            laterView.alpha = 0
            listView.alpha = 0
            
            
            messageView.backgroundColor = UIColor(red: 0.5, green: 0.5 , blue: 0.5, alpha: 0.3)
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            print(messageImageView.center.x)
            
            messageImageView.center = CGPoint(x:messageOriginalCenter.x + translation, y: messageOriginalCenter.y)
            
            archiveView.center = CGPoint(x:archiveOriginalCenter.x + translation, y: archiveOriginalCenter.y)
            
            deleteView.center = CGPoint(x: archiveOriginalCenter.x + translation, y: archiveOriginalCenter.y)
            
            laterView.center = CGPoint(x: laterOriginalCenter.x + translation, y: laterOriginalCenter.y)
            
            listView.center = CGPoint(x: listOriginalCenter.x + translation, y: listOriginalCenter.y)
            
            
            
            if translation < 60 && translation > 0 {
                
                
                archiveView.center = CGPoint(x:archiveOriginalCenter.x, y: archiveOriginalCenter.y)
                
                deleteView.center = CGPoint(x: archiveOriginalCenter.x, y: archiveOriginalCenter.y)
            }
                
                else if translation > 60 {
                    
                    archiveView.center = CGPoint(x:archiveOriginalCenter.x + translation - 60, y: archiveOriginalCenter.y)
                    
                    deleteView.center = CGPoint(x: archiveOriginalCenter.x + translation - 60 , y: archiveOriginalCenter.y)
                    
                }
            
            if translation > -60 && translation < 0 {
                
                
                laterView.center = CGPoint(x:laterOriginalCenter.x, y: laterOriginalCenter.y)
                
                listView.center = CGPoint(x: listOriginalCenter.x, y: listOriginalCenter.y)
            }
                
            else if translation < -60 {
                
                laterView.center = CGPoint(x:laterOriginalCenter.x + translation + 60, y: laterOriginalCenter.y)
                
                listView.center = CGPoint(x: listOriginalCenter.x + translation + 60 , y: listOriginalCenter.y)
                
            }

            
            
            
            if (messageImageView.center.x) < 210 && messageImageView.center.x > 145 {
                
                messageView.backgroundColor = UIColor(red: 0.5, green: 0.5 , blue: 0.5, alpha: 0.3)
                archiveView.alpha = 0
                deleteView.alpha = 0
                laterView.alpha = 0
                listView.alpha = 0
            }
                
            else if (messageImageView.center.x) > 200 && messageImageView.center.x < 320 {
                
                messageView.backgroundColor = .greenColor()
                archiveView.alpha = translation/60
                deleteView.alpha = 0
                laterView.alpha = 0
                listView.alpha = 0
            }
            
            else if (messageImageView.center.x) > 320  {
                
                messageView.backgroundColor = .redColor()
                archiveView.alpha = 0
                deleteView.alpha = 1
                laterView.alpha = 0
                listView.alpha = 0
                
            }else if (messageImageView.center.x) < 155 && messageImageView.center.x > -40 {
                
                messageView.backgroundColor = UIColor(red: 1, green: 0.9 , blue: 0.0, alpha: 0.8)
                archiveView.alpha = 0
                deleteView.alpha = 0
                laterView.alpha = translation/(-60)
                listView.alpha = 0
                
            }
            else if (messageImageView.center.x) < -40 {
                
                messageView.backgroundColor = UIColor(red: 0.9, green: 0.8 , blue: 0.7, alpha: 0.5)
                archiveView.alpha = 0
                deleteView.alpha = 0
                laterView.alpha = 0
                listView.alpha = 1
                
            }

            

            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            print("Gesture ended at: \(point)")
            
            if (messageImageView.center.x) < 210 && messageImageView.center.x > 145 {
             
                messageImageView.center.x = 180
                
            }
            
            else if messageImageView.center.x > 200 {
                
                
                UIView.animateWithDuration(0.2) { () -> Void in
                    self.rescheduleView.alpha = 0
                    self.messageImageView.center.x += 500
                    self.archiveView.center.x += 500
                    self.deleteView.center.x += 500
                }
                
                delay(0.3, closure: { () -> () in
                    
                    UIView.animateWithDuration(0.5) { () -> Void in
                        
                        self.messageImageView.alpha = 0
                        self.feedView.center=CGPoint(x: self.feedViewOriginalCenter.x , y: self.feedViewOriginalCenter.y - 86)
                    }
                    

                })

                
                
                
               
            }
            
            else if (messageImageView.center.x) < 155 && messageImageView.center.x > -40 {
            
                rescheduleView.alpha = 1
            }
            
            else if (messageImageView.center.x) < -40 {
                listBoxView.alpha = 1
                
            }
        }
        
        
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.messageImageView.alpha = 0
            self.feedView.center=CGPoint(x: self.feedViewOriginalCenter.x , y: self.feedViewOriginalCenter.y - 86)
        }
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.rescheduleView.alpha = 0
        }
    }

    @IBAction func onTapBox(sender: UITapGestureRecognizer) {
        
        feedView.center=CGPoint(x: feedViewOriginalCenter.x , y: feedViewOriginalCenter.y)
        messageImageView.alpha = 1
        
        messageView.center = messageViewOriginalCenter
        messageImageView.center = messageOriginalCenter
        
        archiveView.center = archiveOriginalCenter
        deleteView.center = deleteOriginalCenter
        laterView.center =  laterOriginalCenter
        listView.center = listOriginalCenter
    }
    
    @IBAction func onTapList(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.5) { () -> Void in
            
            self.listBoxView.alpha = 0
            self.feedView.center=CGPoint(x: self.feedViewOriginalCenter.x , y: self.feedViewOriginalCenter.y - 86)
        }
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.rescheduleView.alpha = 0
        }
    
    }
    
    
    @IBAction func onEdgePan(edgePan: UIPanGestureRecognizer){
            
//        var translation = edgePan.translationInView(view)
//        var velocity = edgePan.velocityInView(view)
        
        var velocity = edgePan.velocityInView(view).x
        var trans = edgePan.translationInView(view).x
        
        
        if edgePan.state == UIGestureRecognizerState.Began {
            print("Gesture began")
            
            
        } else if edgePan.state == UIGestureRecognizerState.Changed {
            print("Gesture changed")
        
            contentView.center = CGPoint(x: contentViewOriginalCenter.x + trans, y: contentViewOriginalCenter.y)
            print(trans)
            
        } else if edgePan.state == UIGestureRecognizerState.Ended {
            print("Gesture ended")
            
            if velocity > 0 {
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                   self.contentView.center = CGPoint(x: self.contentViewOriginalCenter.x + 400, y: self.contentViewOriginalCenter.y)
                })
                
                
                
            }
            
            else {
                contentView.center = contentViewOriginalCenter
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        contentView.addGestureRecognizer(edgeGesture)
        
        
        scrollView.contentSize = CGSize(width: 320, height: 1313)
        
        rescheduleView.alpha = 0
        listBoxView.alpha = 0
        menuView.alpha = 1
        
        
        feedViewOriginalCenter = feedView.center
        contentViewOriginalCenter = contentView.center
        
        

        
        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
