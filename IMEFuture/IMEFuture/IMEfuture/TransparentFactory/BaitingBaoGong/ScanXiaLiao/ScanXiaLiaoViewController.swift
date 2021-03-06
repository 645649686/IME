//
//  ScanXiaLiaoViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/24.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class ScanXiaLiaoViewController: UIViewController,UITextFieldDelegate {
    
    var _viewLoading: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.heightNavBar.constant = Height_NavBar
        self.heightBottomBar.constant = Height_BottomBar
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: Height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW-34)/2, y: 180, width: 34, height: 34));
        self.view.addSubview(_viewLoading);
        _viewLoading.isHidden = true
        
        self.label.attributedText = toolSwiftAttributedString(text: "摄像头对准下料单二维码，\n点击扫描")
        
        self.textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.request(result: textField.text)
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }

    @IBAction func buttonScan(_ sender: Any) {
        let saoYiSao = SaoYiSaoVC.init()
        saoYiSao.scanTitle = "扫描下料码"
        saoYiSao.resultBlock = {(result: String?) -> Void in
            print(result)
            let jsonData = result?.data(using: String.Encoding.utf8)
            let dic = try? JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyHashable : Any]
            if let a = dic {
                if let blankingCode  = a["blankingCode"] as? String {
                    self.request(result: blankingCode )
                } else {
                    MyAlertCenter.default().postAlert(withMessage: "请扫描下料图纸")
                }
            } else {
                MyAlertCenter.default().postAlert(withMessage: "请扫描下料图纸")
            }
        }
        self.present(saoYiSao, animated: true, completion: nil)
    }
    
    func request(result: String?) {
        _viewLoading.isHidden = false
        
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean = MesPostEntityBean.init()
        let blankingWorkTimeLogVo = BlankingWorkTimeLogVo.init()
        blankingWorkTimeLogVo.siteCode = siteCode
        blankingWorkTimeLogVo.blankingCode = (result ?? nil)!
        mesPostEntityBean.entity = blankingWorkTimeLogVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        HttpMamager.postRequest(withURLString: DYZ_blankingWork_blankingChartScan, parameters: dic as? [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnEntityBean = responseObjectModel as! ReturnEntityBean
            self._viewLoading.isHidden = true
            
            if returnEntityBean.status == "SUCCESS"{
                let blankingWorkTimeLogVo = BlankingWorkTimeLogVo.mj_object(withKeyValues: returnEntityBean.entity)
                
                if blankingWorkTimeLogVo?.workUnitCode == nil {
                    print("workUnitCode == nil")
                } else {
                    print("workUnitCode != nil")
                }
                
                
                if ((blankingWorkTimeLogVo?.workUnitCode.count == 0) && (blankingWorkTimeLogVo?.confirmUser.count == 0)) {
                    let vc = ScanXiaLiaoWorkUnitVC()
                    vc.blankingWorkTimeLogVo = blankingWorkTimeLogVo;
                    self.navigationController?.pushViewController(vc, animated: true)
                } else if ((blankingWorkTimeLogVo?.workUnitCode.count == 0) && (blankingWorkTimeLogVo?.confirmUser.count != 0)) {
                    let vc = ScanXiaLiaoWorkUnitVC()
                    vc.blankingWorkTimeLogVo = blankingWorkTimeLogVo;
                    self.navigationController?.pushViewController(vc, animated: true)
                } else if ((blankingWorkTimeLogVo?.workUnitCode.count != 0) && (blankingWorkTimeLogVo?.confirmUser.count == 0)) {
                    let vc = ScanXiaLiaoPersonVC()
                    vc.blankingWorkTimeLogVo = blankingWorkTimeLogVo;
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = XiaLiaoBaoGongViewController.init()
                    vc.blankingWorkTimeLogVo = blankingWorkTimeLogVo
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnEntityBean"))
    }
    
    @IBAction func buttonGoHome(_ sender: Any) {
        for vc in (self.navigationController?.viewControllers)! {
            if vc is TpfMaiViewController {
                self.navigationController?.popToViewController(vc, animated: true)
                return
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
