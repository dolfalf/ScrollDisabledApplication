//
//  RootPageViewController.swift
//  ScrollDisabledApplication
//
//  Created by j.lee on 2023/05/15.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    private var scrollView: UIScrollView!
    private var pageViews: [UIScrollView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = .gray
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        // PageScrollViewより子ScrollViewがイベントを受け取るように設定
        scrollView.canCancelContentTouches = false
        scrollView.delaysContentTouches = false
        
        let colors = [UIColor.yellow, UIColor.orange, UIColor.green, UIColor.red]
        
        pageViews = (0..<3).map { index in
            let pageView = UIScrollView(frame: view.bounds)
            pageView.backgroundColor = colors[index]
            pageView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 1.5)
            
            /**
             * 制御したいView が一般View(ScrollViewではない)の場合どうしても親ScrollViewのイベントを受け取るようになる
             * mediaViewをScrollViewに変更し、スクロールをわざわざ作るようにしたらできるかもしれません。
             * その前に仕様を検討が必要。
             */
            // scrollViewをさせたくないView生成
            let mediaView = MediaView(frame: CGRect(x: 0 + 16,
                                                    y: 100,
                                                    width: self.view.bounds.size.width - 32,
                                                    height: 200))
            mediaView.backgroundColor = .white
            pageView.addSubview(mediaView)
            
            // 親ビューのスクロール制御する（タッチされるの検知し、制御を行う。）
            /**
             * Swipe制御を素早くすると親ScrollViewにイベントを奪われるため、呼ばれない
             * ゆっくり操作する時は制御できる
             *
             */
            
            mediaView.touchBeganHandler = { [weak self] in
                self?.scrollView.isScrollEnabled = false
            }
            
            mediaView.touchEndedHandler = { [weak self] in
                self?.scrollView.isScrollEnabled = true
            }
            return pageView
        }
        
        for (index, pageView) in pageViews.enumerated() {
            pageView.frame.origin.x = CGFloat(index) * view.bounds.width
            scrollView.addSubview(pageView)
        }
        
        scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(pageViews.count), height: view.bounds.height)
    }
    
    
    
    // MARK: UIScrolleViewDelete
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // スクロール操作が終わったら必ずenableに戻す
        scrollView.isScrollEnabled = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            // スクロール操作が終わったら必ずenableに戻す
            scrollView.isScrollEnabled = true
        }
    }
}

