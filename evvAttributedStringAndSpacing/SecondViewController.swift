//
//  SecondViewController.swift
//  evvAttributedStringAndSpacing
//
//  Created by artist on 5/28/16.
//  Copyright © 2016 artist. All rights reserved.
//

//  목적: line spacing 에 따른 전체 label 의 높이를 구하고자 함.
//  방법:  attributedString 을 사용함 ( 7.0 deplyment target 시험완료 )
//  TODO: objc converstion needed.

import UIKit

class SecondViewController: UIViewController {
 
    @IBOutlet weak var flexibleLabel: UILabel!  //testing label  적용할 라벨
    @IBOutlet weak var refBlock: UIView!        //just a reference ( 100,100 )
    
    let myoptions = unsafeBitCast(
        NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
            NSStringDrawingOptions.UsesFontLeading.rawValue,
        NSStringDrawingOptions.self )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawIt()
        
    }

    @IBAction func actionUpdate(sender: AnyObject) {
        
        
        drawIt()
    }
    
    
    @IBAction func clearScreen(sender: AnyObject) {
    
        for aView in self.view.subviews {
            
            if aView.tag == 666 {
                aView.removeFromSuperview()
            }
        }
    }
    
    func drawIt(){
        
        // access fucntion.
        
        let widthLeft = self.view.frame.width - 100 - 100
        
        let labelContents = "i am a testing message haha hoho---i am a testing message haha --i am a testing message haha😬😬😬 "
        
        let labelHeight = applyAttrLabelAndGetHeight(labelContents, label: flexibleLabel, lineSpacing: 5, width: widthLeft )
        
        
        
        // we can use labelHeight now!
        
        let refPosY = refBlock.frame.origin.y
        
        let bView = UIView(frame: CGRectMake(100,refPosY,200,labelHeight) )
        self.view.addSubview(bView)
        
        bView.tag = 666
        bView.alpha = 0.2
        bView.backgroundColor = UIColor.init(red: 0.3, green: 0.2, blue: 0.3, alpha: 0.2)
        bView.layer.borderColor = UIColor.blackColor().CGColor
        bView.layer.borderWidth = 2

        
        
    }
    func applyAttrLabelAndGetHeight(aString: String , label aLabel:UILabel , lineSpacing aSpacing: CGFloat, width aWidth:CGFloat) -> CGFloat {
    
        // prepare parameters
        
        let aFont = aLabel.font
        let paraStyle = NSMutableParagraphStyle()
            paraStyle.lineSpacing = aSpacing
            paraStyle.alignment = NSTextAlignment.Center
        
        let attrString = NSMutableAttributedString(string: aString)
        let range = NSMakeRange(0, attrString.length)
        
        
        // apply font 폰트 추가
        attrString.addAttribute(NSFontAttributeName, value: aFont, range: range)
        
        // apply line spacing 라인스페이싱
        attrString.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: range)
        
        // apply color ( option )  색상 속성 ( 옵션 )
        attrString.addAttribute(NSBackgroundColorAttributeName, value:UIColor.yellowColor(),  range: NSRange(location: 1, length:3 ))
        
        
        
        // put everything into aLabel
        aLabel.attributedText = attrString
        aLabel.numberOfLines = 0 //crucial!!  매우 중요.
        
        let retHeight = attrString.boundingRectWithSize(CGSizeMake(aWidth, CGFloat.infinity), options: myoptions, context: nil).height
    
        return retHeight
    }
    
}


//        
//        
//        NSString* string = @"Hello World";
//        
//        UIFont *font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:21];
//        
//        CGSize constraint = CGSizeMake(300,NSUIntegerMax);
//        
//        NSDictionary *attributes = @{NSFontAttributeName: font};
//        
//        CGRect rect = [string boundingRectWithSize:constraint
//            options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
//            attributes:attributes
//            context:nil];
//        
//        // Construct your label
//        
//        UILabel* label = [[UILabel alloc] initWithFrame:rect];
//        
//        [label setText:string];
//        
//        [label setTextAlignment:NSTextAlignmentRight];
//        
//        label.lineBreakMode = NSLineBreakByWordWrapping;
//        
//        label.numberOfLines = 0;
//        
//        [label setFont:font];
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


