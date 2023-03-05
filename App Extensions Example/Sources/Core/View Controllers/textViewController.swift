// Copyright (c)  2023-present Frédéric Maquin <fred@ephread.com> and contributors.
// Licensed under the terms of the MIT License.

import UIKit
import Instructions

class textViewController: UIViewController,
                          CoachMarksControllerDataSource {

    
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonStackView: UIView!
    @IBOutlet weak var stackView: UIStackView!

    // チュートリアルを表示する前に、Instructionsを初期化します。
    var coachMarksController = CoachMarksController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // delegateの委任を受ける
        self.coachMarksController.dataSource = self

        // スキップボタン
        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle("スキップ", for: .normal)
        self.coachMarksController.skipView = skipView

        // 背景タップで次の指示へ
        coachMarksController.overlay.isUserInteractionEnabled = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 指示を始める
        self.coachMarksController.start(in: .newWindow(over: self, at: UIWindow.Level.statusBar + 1))
    }

    // 表示回数
    func numberOfCoachMarks(for coachMarksController: Instructions.CoachMarksController) -> Int {
        return 6
    }


    // どのViewに対して表示するか coachMarkAtがindexとなる
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt: Int)
    -> CoachMark {
        switch coachMarkAt {
        case 0: return coachMarksController.helper.makeCoachMark(for: testView)
        case 1: return coachMarksController.helper.makeCoachMark(for: imageView)
        case 2: return coachMarksController.helper.makeCoachMark(for: nextButton)
        case 3: return coachMarksController.helper.makeCoachMark(for: returnButton)
        case 4: return coachMarksController.helper.makeCoachMark(for: stackView)
        case 5: return coachMarksController.helper.makeCoachMark(for: buttonStackView)
        default: return coachMarksController.helper.makeCoachMark(for: testView)
        }
    }

    /**
        吹き出し内容
        - Parameters:
        - coachMarksController: チュートリアル用のVC
        - index: 何ステップ目か
        - coachMark: 吹き出し
    */
    func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: Instructions.CoachMark) -> (bodyView: (UIView & Instructions.CoachMarkBodyView), arrowView: (UIView & Instructions.CoachMarkArrowView)?) {

        var hintText: String {
            switch index {
            case 0: return "testViewだよ"
            case 1: return "imageViewだよ"
            case 2: return "nextButtonだよ"
            case 3: return "returnButtonだよ"
            case 4: return "stackViewだよ"
            case 5: return "viewだよ"
            default: return ""
            }
        }

        // 指示するViewの作成
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(
            withArrow: true,
            arrowOrientation: coachMark.arrowOrientation,
            hintText: hintText,
            nextText: nil
        )

        // テキスト内容を下記のように指定することもできる
//        coachViews.bodyView.hintLabel.text = "Hello! I'm a Coach Mark!"
//        coachViews.bodyView.nextLabel.text = "Ok!"

        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
}


