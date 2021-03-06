//
//  WeiWaiFaHuoViewController.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class WeiWaiFaHuoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    
    var operationOutsourcingOrderVo: OperationOutsourcingOrderVo!
    
    private let _height_NavBar = Height_NavBar
    private let _height_BottomBar = Height_BottomBar
    
    
    
    private var _viewLoading: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var labelTitle1: UILabel!
    @IBOutlet weak var labelTitle2: UILabel!
    @IBOutlet weak var labelTitle3: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelSupplierText: UILabel!
    
    @IBOutlet weak var heightNavBar: NSLayoutConstraint!
    @IBOutlet weak var heightBottomBar: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.heightNavBar.constant = _height_NavBar!
        self.heightBottomBar.constant = _height_BottomBar!
        
        _viewLoading = UIView.loading(withFrame: CGRect(x: 0, y: 0, width: kMainW, height: kMainH), color: UIColor.clear, imageView: CGRect(x: (kMainW - 34)/2, y: 180, width: 34, height: 34))
        self.view.addSubview(_viewLoading)
        _viewLoading.isHidden = true
        
        self.tableView.register(UINib.init(nibName: "WeiWaiCell", bundle: nil), forCellReuseIdentifier: "weiWaiCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.textField.delegate = self
        
        
        
        if operationOutsourcingOrderVo.status.intValue == 1 { //1 创建
      
        } else if operationOutsourcingOrderVo.status.intValue == 2 || operationOutsourcingOrderVo.status.intValue == 3{ //2 已发货
            for any in self.operationOutsourcingOrderVo.operationOutsourcingOrderItemList {
                let model = any as! OperationOutsourcingOrderItemVo
                model.sendQuantity = NSNumber.init(value: model.sendQuantity.doubleValue - model.deliveryQuantity.doubleValue)
                model.deliveryQuantity = model.sendQuantity
//                model.deliveryWeight = model.sendWeight
                model.deliveryWeight = NSNumber.init()
            }
        } else if operationOutsourcingOrderVo.status.intValue == 4 { //4 已收货
            
        }
        
        refreshUI()
        
    }
    
    func refreshUI() {
        labelSupplierText.text = "供应商-"+operationOutsourcingOrderVo.supplierText
        if operationOutsourcingOrderVo.status.intValue == 1 { //1 创建
            labelTitle1.text = "委外发货"
            labelTitle2.text = "发货数量"
            labelTitle3.text = "发货重量(KG)"
        } else if operationOutsourcingOrderVo.status.intValue == 2 { //2 已发货
            labelTitle1.text = "委外收货"
            labelTitle2.text = "收货数量"
            labelTitle3.text = "收货重量(KG)"
        } else if operationOutsourcingOrderVo.status.intValue == 3 { //3 部分收货
            labelTitle1.text = "委外收货"
            labelTitle2.text = "收货数量"
            labelTitle3.text = "收货重量(KG)"
        } else if operationOutsourcingOrderVo.status.intValue == 4 { //4 已收货
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.request(result: textField.text!)
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operationOutsourcingOrderVo.operationOutsourcingOrderItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeiWaiCell = tableView.dequeueReusableCell(withIdentifier: "weiWaiCell", for: indexPath) as! WeiWaiCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let operationOutsourcingOrderItemVo = operationOutsourcingOrderVo.operationOutsourcingOrderItemList.object(at: indexPath.row) as? OperationOutsourcingOrderItemVo;

        if operationOutsourcingOrderVo.status.intValue == 1 { //1 创建
            cell.label0.text = operationOutsourcingOrderItemVo?.productionControlNum
            cell.label1.text = operationOutsourcingOrderItemVo?.materialText
            cell.textField2.text = operationOutsourcingOrderItemVo?.sendQuantity.stringValue
            cell.textField3.text = operationOutsourcingOrderItemVo?.sendWeight.stringValue
            cell.textField2.isEnabled = false
        } else if operationOutsourcingOrderVo.status.intValue == 2 { //2 已发货
            cell.label0.text = operationOutsourcingOrderItemVo?.productionControlNum
            cell.label1.text = operationOutsourcingOrderItemVo?.materialText
            cell.textField2.text = operationOutsourcingOrderItemVo?.deliveryQuantity.stringValue
            cell.textField3.text = operationOutsourcingOrderItemVo?.deliveryWeight.stringValue
            cell.textField2.isEnabled = true
        } else if operationOutsourcingOrderVo.status.intValue == 3 { //3 部分收货
            cell.label0.text = operationOutsourcingOrderItemVo?.productionControlNum
            cell.label1.text = operationOutsourcingOrderItemVo?.materialText
            cell.textField2.text = operationOutsourcingOrderItemVo?.deliveryQuantity.stringValue
            cell.textField3.text = operationOutsourcingOrderItemVo?.deliveryWeight.stringValue
            cell.textField2.isEnabled = true
        } else if operationOutsourcingOrderVo.status.intValue == 4 { //4 已收货
            cell.textField2.isEnabled = true
        }
        
        cell.textField2.tag = indexPath.row
        cell.textField3.tag = indexPath.row
        cell.textField2.inputAccessoryView = self.addToolbar()
        cell.textField3.inputAccessoryView = self.addToolbar()
        
        cell.textField2.addTarget(self, action: #selector(textField2ValueChange(sender:)), for: UIControlEvents.editingChanged)
        cell.textField3.addTarget(self, action: #selector(textField3ValueChange(sender:)), for: UIControlEvents.editingChanged)
        
        return cell
    }
    
    
    @objc func textField2ValueChange(sender: UITextField) {
        let operationOutsourcingOrderItemVo = operationOutsourcingOrderVo.operationOutsourcingOrderItemList.object(at: sender.tag) as! OperationOutsourcingOrderItemVo;
        if operationOutsourcingOrderVo.status.intValue == 1 { //1 创建
           
        } else if operationOutsourcingOrderVo.status.intValue == 2 || operationOutsourcingOrderVo.status.intValue == 3{ //2 已发货 3 部分发货
            if sender.text?.count ?? 0 > 0 {
                if Double(sender.text!)! > operationOutsourcingOrderItemVo.sendQuantity.doubleValue {
                    sender.text = operationOutsourcingOrderItemVo.sendQuantity.stringValue;
                }
                operationOutsourcingOrderItemVo.deliveryQuantity = NSNumber.init(value: Double(sender.text!)!)
            } else {
                operationOutsourcingOrderItemVo.deliveryQuantity = NSNumber.init()
            }
        } else if operationOutsourcingOrderVo.status.intValue == 4 { //4 已收货
            
        }

    }
    @objc func textField3ValueChange(sender: UITextField) {
        let operationOutsourcingOrderItemVo = operationOutsourcingOrderVo.operationOutsourcingOrderItemList.object(at: sender.tag) as! OperationOutsourcingOrderItemVo;
        if operationOutsourcingOrderVo.status.intValue == 1 { //1 创建
            if sender.text?.count ?? 0 > 0 {
                operationOutsourcingOrderItemVo.sendWeight = NSNumber.init(value: Double(sender.text!)!)
            } else {
                operationOutsourcingOrderItemVo.sendWeight = NSNumber.init()
            }
        } else if operationOutsourcingOrderVo.status.intValue == 2 || operationOutsourcingOrderVo.status.intValue == 3 { //2 已发货 3 部分发货
            if sender.text?.count ?? 0 > 0 {
//                if Double(sender.text!)! > operationOutsourcingOrderItemVo.sendWeight.doubleValue {
//                    sender.text = operationOutsourcingOrderItemVo.sendWeight.stringValue
//                }
                operationOutsourcingOrderItemVo.deliveryWeight = NSNumber.init(value: Double(sender.text!)!)
            } else {
                operationOutsourcingOrderItemVo.deliveryWeight = NSNumber.init()
            }
        } else if operationOutsourcingOrderVo.status.intValue == 4 { //4 已收货
            
        }
    }
    
    
    @IBAction func backCommit(_ sender: Any) {
        if operationOutsourcingOrderVo.status.intValue == 1 { //1 创建
            requestFaHuo();
        } else if operationOutsourcingOrderVo.status.intValue == 2 { //2 已发货
            requestShouHuo()
        } else if operationOutsourcingOrderVo.status.intValue == 3 { //3 部分收货
            requestShouHuo()
        } else if operationOutsourcingOrderVo.status.intValue == 4 { //4 已收货
            
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func request(result: String?) {
        _viewLoading.isHidden = false
        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let userBean = UserBean.mj_object(withKeyValues: loginModel.ucenterUser)
        let siteCode = userBean?.enterpriseInfo.serialNo
        
        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        let operationOutsourcingOrderVo: OperationOutsourcingOrderVo = OperationOutsourcingOrderVo.init()
        operationOutsourcingOrderVo.siteCode = siteCode
        operationOutsourcingOrderVo.outsourcingCode = result ?? ""
        
        mesPostEntityBean.entity = operationOutsourcingOrderVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        print(dic)
        
        HttpMamager.postRequest(withURLString: DYZ_operationOutsourcing_getOperationOutsourcingOrder, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnEntityBean = responseObjectModel as! ReturnEntityBean
            
            self._viewLoading.isHidden = true
            if returnEntityBean.status == "SUCCESS" {
                let operationOutsourcingOrderVo: OperationOutsourcingOrderVo = OperationOutsourcingOrderVo.mj_object(withKeyValues: returnEntityBean.entity)
                if operationOutsourcingOrderVo.status.intValue == 1 { //1 创建
                    self.operationOutsourcingOrderVo = operationOutsourcingOrderVo
                } else if operationOutsourcingOrderVo.status.intValue == 2 || operationOutsourcingOrderVo.status.intValue == 3 { //2 已发货 3 部分收货
                    self.operationOutsourcingOrderVo = operationOutsourcingOrderVo
                    
                    for any in self.operationOutsourcingOrderVo.operationOutsourcingOrderItemList {
                        let model = any as! OperationOutsourcingOrderItemVo
                        model.sendQuantity = NSNumber.init(value: model.sendQuantity.doubleValue - model.deliveryQuantity.doubleValue)
                        model.deliveryQuantity = model.sendQuantity
//                        model.deliveryWeight = model.sendWeight
                        model.deliveryWeight = NSNumber.init()
                    }
                    
                } else if operationOutsourcingOrderVo.status.intValue == 4 { //4 已收货
                    MyAlertCenter.default().postAlert(withMessage: "该委外单已收货")
                }
                self.tableView.reloadData()
            } else {
                MyAlertCenter.default().postAlert(withMessage: returnEntityBean.returnMsg)
            }
            
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnEntityBean"))
        
    }
    
    func requestFaHuo() {
        _viewLoading.isHidden = false

        let logingModel: LoginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: logingModel.tpfUser)
        let siteCode = tpfUser?.siteCode
        let userCode = tpfUser?.userCode

        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        let bean: OperationOutsourcingOrderVo = OperationOutsourcingOrderVo.init()
        bean.siteCode = siteCode
        bean.outsourcingCode = operationOutsourcingOrderVo.outsourcingCode
        bean.modifyUser = userCode
        
        var operationOutsourcingOrderItemList = NSMutableArray.init(capacity: 0)
        for any in self.operationOutsourcingOrderVo.operationOutsourcingOrderItemList {
            let model = any as! OperationOutsourcingOrderItemVo
            let model1 = OperationOutsourcingOrderItemVo.init()
//            model1.operationOutsourcingOrderId = model.idDYZ
            model1.idDYZ = model.idDYZ
            model1.sendWeight = NSNumber.init(value: model.sendWeight.doubleValue)
//            if model1.sendWeight.doubleValue > 0 {
//                MyAlertCenter.default().postAlert(withMessage: "发货数量不需大于0！")
//            } else {
//                return;
//            }
            let weight: NSNumber? = model1.sendWeight
            if weight == nil {
                print("nil")
            } else {
                print("no nil")
            }
            print(weight)
            
            operationOutsourcingOrderItemList.add(model1)
        }
        bean.operationOutsourcingOrderItemList = operationOutsourcingOrderItemList
        
        
        
        mesPostEntityBean.entity = bean.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        
        print(dic)
        
        HttpMamager.postRequest(withURLString: DYZ_mes_operationOutsourcing_delivery, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean

            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {

                self.navigationController?.popViewController(animated: true)
                MyAlertCenter.default().postAlert(withMessage: "委外单发货成功！")

            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnMsgBean"))

    }
    
    func requestShouHuo() {
        _viewLoading.isHidden = false

        let loginModel: LoginModel = DatabaseTool.getLoginModel()
        let tpfUser = UserInfoVo.mj_object(withKeyValues: loginModel.tpfUser)
        let siteCode = tpfUser?.siteCode
        let userCode = tpfUser?.userCode

        let mesPostEntityBean: MesPostEntityBean = MesPostEntityBean.init()
        let operationOutsourcingReceivingNoteVo: OperationOutsourcingReceivingNoteVo = OperationOutsourcingReceivingNoteVo.init()
        operationOutsourcingReceivingNoteVo.siteCode = siteCode
        operationOutsourcingReceivingNoteVo.outsourcingCode = self.operationOutsourcingOrderVo.outsourcingCode;
        operationOutsourcingReceivingNoteVo.createUser = userCode
        
        let operationOutsourcingReceivingNoteItemList = NSMutableArray.init(capacity: 0)
        for any in self.operationOutsourcingOrderVo.operationOutsourcingOrderItemList {
            let model = any as! OperationOutsourcingOrderItemVo
            let model1 = OperationOutsourcingReceivingNoteItemVo.init()
            model1.operationOutsourcingOrderItemId = model.idDYZ
    
            model1.deliveryQuantity = NSNumber.init(value: model.deliveryQuantity.doubleValue)
            model1.deliveryWeight = NSNumber.init(value: model.deliveryWeight.doubleValue)
            operationOutsourcingReceivingNoteItemList.add(model1)
        }
        
        operationOutsourcingReceivingNoteVo.operationOutsourcingReceivingNoteItemList = operationOutsourcingReceivingNoteItemList
        mesPostEntityBean.entity = operationOutsourcingReceivingNoteVo.mj_keyValues()
        let dic = mesPostEntityBean.mj_keyValues()
        print(dic)
        
        HttpMamager.postRequest(withURLString: DYZ_mes_operationOutsourcing_receiving, parameters: dic as! [AnyHashable : Any], success: { (responseObjectModel: Any?) in
            let returnMsgBean = responseObjectModel as! ReturnMsgBean

            self._viewLoading.isHidden = true
            if returnMsgBean.status == "SUCCESS" {

                self.navigationController?.popViewController(animated: true)
                MyAlertCenter.default().postAlert(withMessage: "委外单收货成功！")

            } else {
                MyAlertCenter.default().postAlert(withMessage: returnMsgBean.returnMsg)
            }
        }, fail: { (error: Error?) in
            self._viewLoading.isHidden = true
        }, isKindOfModel: NSClassFromString("ReturnMsgBean"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
