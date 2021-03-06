//
//  XiaLiaoCompleteVC.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/4.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class XiaLiaoCompleteVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    private let _height_NavBar = Height_NavBar!
    private let _height_BottomBar = Height_BottomBar!
    
    var blankingWorkTimeLogVo: BlankingWorkTimeLogVo!
    
    
    var list: NSMutableArray!
    var listDataImage: NSMutableArray!
    
    var _viewLoading: UIView!
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar
        self.heightBottomBar.constant = _height_BottomBar
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: _height_NavBar, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW-34)/2, y: 180, width: 34, height: 34));
        self.view.addSubview(_viewLoading);
        _viewLoading.isHidden = true
        
        self.list = NSMutableArray.init()
        self.listDataImage = NSMutableArray.init()
        
        for vv in self.blankingWorkTimeLogVo.blankingWorkTimeLogDetailList {
            let blankingWorkTimeLogDetailVo = vv as! BlankingWorkTimeLogDetailVo
            
            blankingWorkTimeLogDetailVo.completedQuantity = NSNumber.init(value: blankingWorkTimeLogDetailVo.blankingQuantity.doubleValue - blankingWorkTimeLogDetailVo.finishedQuantity.doubleValue)
        }
        
        self.tableView.register(UINib.init(nibName: "XiaLiaoCompleteCell", bundle: nil), forCellReuseIdentifier: "xiaLiaoCompleteCell")
        self.tableView.register(UINib.init(nibName: "XiaLiaoCompleteHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "xiaLiaoCompleteHeader")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView.init()
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "xiaLiaoCompleteHeader") as! XiaLiaoCompleteHeader
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blankingWorkTimeLogVo.blankingWorkTimeLogDetailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "xiaLiaoCompleteCell", for: indexPath) as! XiaLiaoCompleteCell
        cell.selectionStyle = .none
        
        let blankingWorkTimeLogDetailVo = self.blankingWorkTimeLogVo.blankingWorkTimeLogDetailList[indexPath.row] as! BlankingWorkTimeLogDetailVo
        cell.label0.text = blankingWorkTimeLogDetailVo.materialText
        cell.label1.text = blankingWorkTimeLogDetailVo.blankingQuantity.stringValue
        cell.label2.text = blankingWorkTimeLogDetailVo.finishedQuantity.stringValue
        
        cell.textField0.text = blankingWorkTimeLogDetailVo.completedQuantity.stringValue
        cell.textField0.addTarget(self, action: #selector(textField0(sender:)), for: UIControlEvents.editingChanged)
        cell.textField0.tag = indexPath.row
        cell.textField0.inputAccessoryView = self.addToolbar()

        return cell
    }

    @objc func textField0(sender: UITextField) {
        let blankingWorkTimeLogDetailVo = self.blankingWorkTimeLogVo.blankingWorkTimeLogDetailList[sender.tag] as! BlankingWorkTimeLogDetailVo
        
        if sender.text?.count ?? 0 > 0 {
            if Double(sender.text!)! > (blankingWorkTimeLogDetailVo.blankingQuantity.doubleValue - blankingWorkTimeLogDetailVo.finishedQuantity.doubleValue) {
                MyAlertCenter.default().postAlert(withMessage: "本次完工数量大于未完工数量")
                return
            }
            blankingWorkTimeLogDetailVo.completedQuantity = NSNumber.init(value: Double(sender.text!)!)
        } else {
            blankingWorkTimeLogDetailVo.completedQuantity = NSNumber.init(value: 0)
        }
    }
    
    @IBAction func buttonCommit(_ sender: Any) {
        _viewLoading.isHidden = false

        let mesPostEntityBean = MesPostEntityBean.init()
        let blankingConfirmReportVo = BlankingConfirmReportVo.init()
        blankingConfirmReportVo.blankingWorkTimeLogVo = self.blankingWorkTimeLogVo
        blankingConfirmReportVo.blankingWorkTimeLogDetailVoList = self.blankingWorkTimeLogVo.blankingWorkTimeLogDetailList
//        for vv in self.list {
//            let batchWorkItemReportVo = vv as! BatchWorkItemReportVo
//            if batchWorkItemReportVo.productionOperationVo.completedQuantity.doubleValue > batchWorkItemReportVo.productionOperationVo.unCompletedQuantity.doubleValue{
//                MyAlertCenter.default().postAlert(withMessage: "报工数大于计划数")
//                _viewLoading.isHidden = true
//                return
//            }
//        }
        mesPostEntityBean.entity = blankingConfirmReportVo.mj_keyValues()
        let dic1 = mesPostEntityBean.mj_keyValues()
        let dic2 = ["data":String.toolSwiftGetJSONFromDictionary(dictionary: dic1!)]
        
//        let data : NSData! = try? JSONSerialization.data(withJSONObject: dic2, options: []) as NSData!
//        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
//
//        print(JSONString)
        

        
        HttpMamager.postRequestImage(withURLString: DYZ_blankingWork_doConfirmProduction, parameters: dic2, uploadImageBean: nil, success: { (responseObjectModel) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean
            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {
                MyAlertCenter.default().postAlert(withMessage: "提交成功")
                for vc in (self.navigationController?.viewControllers)! {
                    if vc is ScanXiaLiaoViewController {
                        self.navigationController?.popToViewController(vc, animated: true)
                        return
                    }
                }
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
        }, progress: nil, fail: { (error) in
            self._viewLoading.isHidden = true
        }, isKindOfModelClass: NSClassFromString("ReturnMsgBean"))
        
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
        
        if self.blankingWorkTimeLogVo.status.intValue == 4 {
            for temp in (self.navigationController?.viewControllers)! {
                if temp is ScanXiaLiaoViewController {
                    self.navigationController?.popToViewController(temp, animated: true)
                    return
                }
            }
        } else {
            self.navigationController?.popViewController(animated: true);
        }
        
    }
    
    func addToolbar() -> UIToolbar {
        let toolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 38))
        toolbar.tintColor = colorRGB(r: 0, g: 168, b: 255)
        let space = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let bar = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(textFieldDone))
        toolbar.items = [space, bar]
        return toolbar
    }
    
    @objc func textFieldDone() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
