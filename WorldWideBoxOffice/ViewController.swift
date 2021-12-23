//
//  ViewController.swift
//  WorldWideBoxOffice
//
//  Created by Wen Luo on 2021/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectedYearSlider: UISlider!
    
    @IBOutlet weak var selectedYearLabel: UILabel!
    
    @IBOutlet weak var selectedYearDatePicker: UIDatePicker!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var chineseTitleLabel: UILabel!
    
    @IBOutlet weak var englishTitleLabel: UILabel!
    
    let movieInfos = [
        "2011":[
            "poster": "2011.jpeg",
            "chineseTitle": "哈利波特：死神的聖物2",
            "englishTitle": "Harry Potter and the Deathly Hallows: Part 2"
        ],
        "2012":[
            "poster": "2012.jpeg",
            "chineseTitle": "復仇者聯盟",
            "englishTitle": "The Avengers"
        ],
        "2013":[
            "poster": "2013.jpeg",
            "chineseTitle": "冰雪奇緣",
            "englishTitle": "Frozen"
        ],
        "2014":[
            "poster": "2014.jpeg",
            "chineseTitle": "變形金剛4：絕跡重生",
            "englishTitle": "Transformers: Age of Extinction"
        ],
        "2015":[
            "poster": "2015.jpeg",
            "chineseTitle": "STAR WARS：原力覺醒",
            "englishTitle": "Star Wars: Episode VII - The Force Awakens"
        ],
        "2016":[
            "poster": "2016.jpeg",
            "chineseTitle": "美國隊長3：英雄內戰",
            "englishTitle": "Captain America: Civil War"
        ],
        "2017":[
            "poster": "2017.jpeg",
            "chineseTitle": "STAR WARS：最後的絕地武士",
            "englishTitle": "Star Wars: Episode VIII - The Last Jedi"
        ],
        "2018":[
            "poster": "2018.jpeg",
            "chineseTitle": "復仇者聯盟：無限之戰",
            "englishTitle": "Avengers: Infinity War"
        ],
        "2019":[
            "poster": "2019.jpeg",
            "chineseTitle": "復仇者聯盟：終局之戰",
            "englishTitle": "Avengers: End Game"
        ],
        "2020":[
            "poster": "2020.jpeg",
            "chineseTitle": "鬼滅之刃劇場版 無限列車篇",
            "englishTitle": "Demon Slayer: Mugen Train"
        ]
    
    ]
    
    func showMovie(year: String){
        if let movieInfo = movieInfos[year]{
            if let posterFileName = movieInfo["poster"]{
                moviePosterImageView.image = UIImage(named: posterFileName)
            }
            if let chineseTitle = movieInfo["chineseTitle"]{
                chineseTitleLabel.text = chineseTitle
            }
            if let englishTitle = movieInfo["englishTitle"]{
                englishTitleLabel.text = englishTitle
            }
        }
        
    }
    
    
    //漸層背景函式
    func addGradientLayer(){
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [
            CGColor(red: 4/255, green: 3/255, blue: 3/255, alpha: 1),
            CGColor(red: 70/255, green: 17/255, blue: 17/255, alpha: 1),
            CGColor(red: 161/255, green: 51/255, blue: 51/255, alpha: 1),
            CGColor(red: 236/255, green: 219/255, blue: 186/255 , alpha: 1)
        ]
        layer.locations = [0, 0.5, 0.7, 1]
        view.layer.insertSublayer(layer, at: 0)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //插入間曾背景
        addGradientLayer()
    }

    @IBAction func changeYearSlider(_ sender: UISlider) {
        //將slider的value四捨五入到整數
        //因為是改變slider.value本身所以會以整數來變動thumb位置
        sender.value.round()
        //將slider選取的年度改以整數型態儲存起來
        let selectedYear = Int(sender.value)
        //下面的年度label再將selectedYear以字串方式賦予
        selectedYearLabel.text = selectedYear.description
        //與date picker連動程式
        //因為slider變動只會改變date picker的year，所以要先將原本date picker的月日取出
        //取出後先存到originalDateComponents
        let originalDateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: selectedYearDatePicker.date)
        //建立格式器來用來創造新的date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        //先用字串宣告新的日期，只有年份會更新，月日都代入原本date picker的月日
        let newDateString = "\(selectedYear)/\(originalDateComponents.month!)/\(originalDateComponents.day!)"
        //將新日期轉換成date物件
        let newDate = dateFormatter.date(from: newDateString)
        //將date picker的date設定為newDate
        selectedYearDatePicker.date = newDate!
        
        //顯示電影資訊
        showMovie(year: "\(selectedYear)")
    }
    
    
    @IBAction func changeYearDatePicker(_ sender: UIDatePicker) {
        //先將date picker的日期轉換為dateComponents物件
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: sender.date)
        //擷取dateComponents物件的年份後設定到slider的value
        //將slider value轉換成整數、字串後再設定到year label的text
        if let selectedYear = dateComponents.year {
            selectedYearSlider.value = Float(selectedYear)
            selectedYearLabel.text = Int(selectedYearSlider.value).description
            //顯示電影資訊
            showMovie(year: "\(selectedYear)")
            
        }
    }
    
    
}

