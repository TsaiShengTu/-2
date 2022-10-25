//
//  PointViewController.swift
//  全民星攻略
//
//  Created by Sheng-Yu on 2022/8/31.
//

import UIKit

class PointViewController: UIViewController {
    
    //分數型別
    var point:Point = Point()
    
    //按鈕群組
    @IBOutlet var pointCard: [UIButton]!
    @IBOutlet weak var pointLable: UILabel!
    var isGetPoint: Bool = true
    
    //接取 第十題答對以前總分的值
    var returnPoint1 = 0
    
    //最終第十題答對時，傳過來的值
    var returnPointFinal = 0
    var isTen = false
    //回去的按鈕
    @IBOutlet weak var returnButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointLable.text = "獎金挑戰賽"
        returnButton.setTitle("繼續", for: .normal)
        
    }
    
    //翻牌
    //會回傳一個數字，同時執行翻牌的動作
    //這邊的i是指個別牌組的按鈕
    func pointPlayGet(i: Int) -> Int
    {
        //取出 Data的陣列，並亂數打散
        point.pointStar.shuffle()
        //迴圈列印
        for j in 0...4{
            //點選的按鈕，會以title顯示在按鈕上
            pointCard[j].setTitle(String(point.pointStar[j]), for: .normal)
            //選完後每一個都是false，不可點擊
            pointCard[j].isEnabled = false
        }
        pointCard[i].alpha = 0.4
        //動畫效果
        UIView.transition(with: pointCard[i], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
        
        print(point.pointStar[i])
        
        return point.pointStar[i]
    }
        
    //真正按下按鈕會觸發
    @IBAction func returnPointGet(_ sender: UIButton)  {
        
        //被點選的按鈕，代表第幾個按鈕，是個數字
        let index = pointCard.firstIndex(of: sender)!
        print(index)
        //獲得一個分數，因為上面有迴圈列印，所以是相通的
        let pointGet = self.pointPlayGet(i: index)
        
        
        //如果是 第十題的話
        if isTen {
            returnButton.setTitle("重新開始", for: .normal)
            let title: String = "恭喜"
            let message = "分數獲得\(pointGet)\n分數總共獲得\(returnPointFinal)"
            let controller1 = UIAlertController(title:title, message: message, preferredStyle: .alert)
            let okation1 = UIAlertAction(title: "OK", style: .default)
            controller1.addAction(okation1)
            print("分數獲得")
            present(controller1, animated: true)
            //最後一題時會得到的總分
            returnPointFinal += pointGet
        }
        //不是第十題的話
        else{
            let title: String = "恭喜"
            let message = "分數獲得\(pointGet)"
            let controller1 = UIAlertController(title:title, message: message, preferredStyle: .alert)
            let okation1 = UIAlertAction(title: "OK", style: .default)
            controller1.addAction(okation1)
            print("分數獲得")
            present(controller1, animated: true)
            //翻牌後每次都會相加
            returnPoint1 +=  pointGet
        }
        print(returnPointFinal)
        print(returnPoint1)
        print(isTen)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        var a = 0
        for i in 0..<pointCard.count{
            if pointCard[i].isEnabled == false {
                a += 1
            }
        }
        if a == 0 {
            let title: String = "請翻牌抽出分數"
            let message = "抽起來！"
            let controller1 = UIAlertController(title:title, message: message, preferredStyle: .alert)
            let okation1 = UIAlertAction(title: "OK", style: .default)
            controller1.addAction(okation1)
            print("抽取")
            present(controller1, animated: true)
            return false
        }
        else {
            return true
        }
    }
    
            
            
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            returnPoint1
//        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
    

}
