//
//  ViewController.swift
//  SlideshowApp
//
//  Created by mba2408.starlight kyoei.engine on 2024/10/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!

    
    // 配列に指定するindex番号を宣言
    var nowIndex:Int = 0
    
    var selectedIndex:Int = 0
    
    var isPlaying = false

    // スライドショーに使用するタイマーを宣言
    var timer: Timer!

    // スライドショーさせる画像の配列を宣言
    var imageArray:[UIImage] = [
        UIImage(named: "爆弾1.jpeg")!,
        UIImage(named: "爆弾2.jpeg")!,
        UIImage(named: "爆弾3.png")!,
    ]
    
//    var selectedImage:UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 画像を設定
        let sampleImage = UIImage(named: "爆弾1.jpeg")!
        imageView.image = sampleImage
    }
    
    @IBAction func onPrev(sender: AnyObject) {
        nowIndex -= 1
        
        if (nowIndex < 0) {
            nowIndex = 2
        }

        imageView.image = imageArray[nowIndex]
    }
    
    @IBAction func onNext(sender: AnyObject) {
        nowIndex += 1
        
        if (nowIndex == imageArray.count) {
            nowIndex = 0
        }
        
        imageView.image = imageArray[nowIndex]
    }
    

    // 再生ボタンを押した時の処理
    @IBAction func slideShowButton(_ sender: Any) {
        print("test")
        // 再生中か停止しているかを判定
        if (timer == nil) {
            // 再生時の処理を実装
            isPlaying = true
            // タイマーをセットする
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)

            prevBtn.isEnabled = false
            nextBtn.isEnabled = false
        
            // ボタンの名前を停止に変える
            startButton.setTitle("停止", for: .normal)

        } else {
            // 停止時の処理を実装
            isPlaying = false
            // タイマーを停止する
            timer.invalidate()

            // タイマーを削除しておく(timer.invalidateだけだとtimerがnilにならないため)
            timer = nil
            
            prevBtn.isEnabled = true
            nextBtn.isEnabled = true

            // ボタンの名前を再生に直しておく
            startButton.setTitle("再生", for: .normal)
        }
    }

    @objc func changeImage() {
            // indexを増やして表示する画像を切り替える
           nowIndex += 1

           // indexが表示予定の画像の数と同じ場合
           if (nowIndex == imageArray.count) {
               // indexを一番最初の数字に戻す
               nowIndex = 0
           }
           // indexの画像をstoryboardの画像にセットする
           imageView.image = imageArray[nowIndex]
    }
    
    @IBAction func onTapImg(_ sender: Any) {
        performSegue(withIdentifier: "extededImage", sender: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if isPlaying {
            // @IBActionメソッドを呼び出し
            self.slideShowButton(startButton!)
        }
    
        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        // 遷移先のResultViewControllerで宣言しているx, yに値を代入して渡す
//        selectedIndex = nowIndex
        let selectedImage = imageArray[nowIndex]
        resultViewController.image = selectedImage
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
//        self.slideShowButton(startButton!)
//        nowIndex = selectedIndex
//        imageView.image = imageArray[nowIndex]
    }

}

