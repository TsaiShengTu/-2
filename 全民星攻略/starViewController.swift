//
//  starViewController.swift
//  全民星攻略
//
//  Created by 蔡勝宇 on 2022/8/30.
//

import UIKit

class starViewController: UIViewController {

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var questionSum: UILabel!
    @IBOutlet weak var questionTittileLable: UILabel!
    @IBOutlet weak var questionNumberLable: UILabel!
    @IBOutlet var questionOption: [UIButton]!
    //題目的數字
    var index = 0
    //現在獲得的分數
    var pointget = 0
    
    var rightAnswer:String?
    
    //
    var point = Point()
    
    var questionAll = [
        Question(question:"越南的首都是？", questionOption: ["河內","胡志明市","金邊","會安"], questionAnsner: "河內"),
        Question(question: "冰島的首都是?", questionOption: ["雷雷亞維克","倫敦","法羅","加薩"], questionAnsner: "雷雷亞維克"),
        Question(question: "日本的首都是？", questionOption: ["北京","首爾","台北","東京"], questionAnsner: "東京"),
        Question(question: "瑞士的首都是？", questionOption: ["伯恩","巴黎","日內瓦","柏林"], questionAnsner:"伯恩" ),
        Question(question: "泰國的首都是？", questionOption: ["曼谷","金邊","雅加達","加爾各答"], questionAnsner: "曼谷"),
        Question(question: "義大利的首都是？", questionOption: ["米蘭","佛羅倫斯","羅馬","柏林"], questionAnsner: "羅馬"),
        Question(question: "澳洲的首都是？", questionOption: ["墨爾本","坎培拉","雪梨","伯恩"], questionAnsner: "坎培拉"),
        Question(question: "中國的首都是？", questionOption: ["南京","北京","東京","四川"], questionAnsner:"北京" ),
        Question(question: "加拿大的首都是？", questionOption: ["西雅圖","渥太華","多倫多","華盛頓"], questionAnsner: "渥太華"),
        Question(question: "美國的首都是？", questionOption: ["紐約","華盛頓","洛杉磯","佛州"], questionAnsner: "華盛頓"),
        Question(question: "馬來西亞的首都？", questionOption: ["雅加達","吉隆坡","金邊","胡志明市"], questionAnsner: "吉隆坡")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionNumberLable.text = "\(1)"
        questionTittileLable.text = "第\(String(index+1))題"
        questionSum.text = "分數:\(pointget)"
        questionAll.shuffle()
        startGame()
    }
    
    
    
    func restart(){
        index = 0
        pointget = 0
        questionSum.text = "分數:\(pointget)"
        startGame()
    }
    
    func startGame(){
        if index < 10
            {
                //第幾題
                question.text = questionAll[index].question
                //第幾題的正確答案
                rightAnswer = questionAll[index].questionAnsner
                //打亂答案的順序
                questionAll[index].questionOption.shuffle()
                //題目加一
                questionNumberLable.text = "\(index+1)"
                //題目加一
                questionTittileLable.text = "第\(index+1)題"
                    //列印按鈕文字
                for i in 0...3{
                    //每個按鈕，是第幾題當中的陣列
                    questionOption[i].setTitle(questionAll[index].questionOption[i], for: .normal)
                }
                //這邊加一是為了題目陣列的索引值
                index += 1
            }
    }

        //確認答案是否正確
        @IBAction func answerClick(i sender:UIButton){
        var title: String = ""
        var message = ""
            //如果當前按鈕的文字等於正確答案
        if sender.currentTitle == rightAnswer{
            questionSum.text = "\(pointget)"
            title = "恭喜答對"
            message = "很棒"
            print("恭喜答對")
        }
        let controller = UIAlertController(title:title, message: message, preferredStyle: .alert)
            //如果答案正確，執行閉包的程式
        if sender.currentTitle == rightAnswer{
            let okAction = UIAlertAction(title: "前往獎金挑戰賽", style: .default) { b in
                // Segue跳頁
                self.performSegue(withIdentifier: "showPoint", sender: nil)
            }
            //加入警報按鈕
            controller.addAction(okAction)
            print("挑戰賽")
            //呈現警報
            present(controller, animated: true)
            // 重置game
            startGame()
        }
            //如果不等於答案
        else if sender.currentTitle != rightAnswer{
            //如果是第十題
            if self.index == 10{
                title   = "遊戲結束"
                message = "總共獲得\(pointget)"
                let controller = UIAlertController(title:title, message: message, preferredStyle: .alert)
                //按下alert後執行 閉包內程式
                let replayAction = UIAlertAction(title: "再一局？", style: .default) { _ in
                    self.restart()
                    print("再開始")
                }
                controller.addAction(replayAction)
                present(controller, animated: true)
            }
            //如果不是第十題
            else{
                title   = "可惜"
                message = "再加油"
                let controller = UIAlertController(title:title, message: message, preferredStyle: .alert)
                //按下alert後執行 閉包內程式
                let replayAction = UIAlertAction(title: "下一題", style: .default) { [self] _ in
                    self.startGame()
                    print("下")
                }
                    controller.addAction(replayAction)
                    present(controller, animated: true)
            }
        }
            //如果小於一就開始遊戲
        if index < 1{
            startGame()
        }
    }
    
    
    
    //傳值過去 pointget的值過去 給下一頁的returnPoint1接起來
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPoint"{
            if index == 10{
                let goToPoint = segue.destination as! PointViewController
                goToPoint.returnPointFinal = pointget
                goToPoint.isTen = true
                restart()
            }
        }
    }

    @IBAction func unwindToStarView(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as? PointViewController
        if index != 10 {
            if let pointsum = sourceViewController?.returnPoint1{
                    pointget += pointsum
                questionSum.text = "分數:\(pointget)"
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
