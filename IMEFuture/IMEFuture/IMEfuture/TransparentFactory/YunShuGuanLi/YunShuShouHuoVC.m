//
//  YunShuShouHuoVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/8.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "YunShuShouHuoVC.h"
#import "VoHeader.h"
#import "YunShuShouHuoHeader.h"
#import "YunShuShouHuoCell.h"

#import "YunShuYuNanVC.h"

#import <AVFoundation/AVFoundation.h>

#import "UploadImageBean.h"


@interface YunShuShouHuoVC () <UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *affirmButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (nonatomic,assign) NSInteger index;

@end

@implementation YunShuShouHuoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    for (TransportOrderVo *transportOrderVo in self.transportOrder.transportOrderVoList) {
        for (TransportOrderDetailVo *transportOrderDetailVo in transportOrderVo.transportOrderDetailVoList) {
            transportOrderDetailVo.deliveryQuantity = transportOrderDetailVo.actualQuantity;
        }
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"YunShuShouHuoHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"yunShuShouHuoHeader"];

    [self.tableView registerNib:[UINib nibWithNibName:@"YunShuShouHuoCell" bundle:nil] forCellReuseIdentifier:@"yunShuShouHuoCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedSectionHeaderHeight = 0.1;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.sectionFooterHeight = 0.1;
    
    self.affirmButton.enabled = NO;
    self.affirmButton.backgroundColor = colorRGB(217, 217, 217);
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 70;
    } else {
        self.tableViewBottom.constant = rect.size.height-Height_BottomBar;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.transportOrder.transportOrderVoList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transportOrder.transportOrderVoList[section].transportOrderDetailVoList.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YunShuShouHuoHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"yunShuShouHuoHeader"];
    
    TransportOrderVo *transportOrder = self.transportOrder.transportOrderVoList[section];
    
    view.label1.text = [NSString stringWithFormat:@"送货单号：%@",transportOrder.outgoingOrderNum];
    
    if (transportOrder.uploadImageBean == nil) {
        view.button1.backgroundColor = colorRGB(127, 185, 45);
        view.button1.layer.cornerRadius = 4;
        [view.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [view.button1 setTitle:@"拍照" forState:UIControlStateNormal];
    } else {
        view.button1.backgroundColor = [UIColor whiteColor];
        view.button1.layer.cornerRadius = 4;
        [view.button1 setTitleColor:colorRGB(127, 185, 45) forState:UIControlStateNormal];
        [view.button1 setTitle:@"预览" forState:UIControlStateNormal];
        view.button1.layer.borderColor = colorRGB(127, 185, 45).CGColor;
        view.button1.layer.borderWidth = 1;
    }
    
    [view.button1 addTarget:self action:@selector(buttonClickPaiZhaoAndYuNan:) forControlEvents:UIControlEventTouchUpInside];
    view.button1.tag = section;
    
    return view;
}

- (void)buttonClickPaiZhaoAndYuNan:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"拍照"]) {
        self.index = sender.tag;
        [self take_A_Picture];
    } else if ([sender.currentTitle isEqualToString:@"预览"]) {
        TransportOrderVo *transportOrder = self.transportOrder.transportOrderVoList[sender.tag];
        YunShuYuNanVC *vc = [[YunShuYuNanVC alloc] init];
        vc.uploadImageBean = transportOrder.uploadImageBean;
        [vc setCallBack:^{
            transportOrder.uploadImageBean = nil;
            [self.tableView reloadData];
        }];
        [self.navigationController pushViewController:vc animated:true];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YunShuShouHuoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yunShuShouHuoCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    TransportOrderVo *transportOrder = self.transportOrder.transportOrderVoList[indexPath.section];
    TransportOrderDetailVo *transportOrderDetail = transportOrder.transportOrderDetailVoList[indexPath.row];
    
    cell.label0.text = [NSString stringWithFormat:@"物料号：%@",transportOrderDetail.materialCode];
    cell.label1.text = [NSString stringWithFormat:@"名称：%@",transportOrderDetail.materialText];
    cell.label2.text = transportOrderDetail.actualQuantity.stringValue;
    
    cell.textField.text = transportOrderDetail.deliveryQuantity.stringValue;
    [cell.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    cell.textField.tag = indexPath.row;
    cell.testFieldSupperView.tag = indexPath.section;
    
    
    cell.textField.inputAccessoryView = [self addToolbar];
    
    return cell;
}

- (void)textFieldChange:(UITextField *)textField {
    TransportOrderVo *transportOrder = self.transportOrder.transportOrderVoList[textField.superview.tag];
    TransportOrderDetailVo *transportOrderDetail = transportOrder.transportOrderDetailVoList[textField.tag];
    
    transportOrderDetail.deliveryQuantity = [NSNumber numberWithDouble:textField.text.doubleValue];
}

- (IBAction)affirmBuuttonClick:(id)sender {
    BOOL flag = YES;
    for (TransportOrderVo *transportOrderVo in self.transportOrder.transportOrderVoList) {
        if (!transportOrderVo.uploadImageBean) {
            flag = NO;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"上传图片"];
            return;
        }
    }
    
    
    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (TransportOrderVo *transportOrderVo in self.transportOrder.transportOrderVoList) {
        TransportOrderVo *tempTransportOrderVo = [[TransportOrderVo alloc] init];
        tempTransportOrderVo.siteCode = transportOrderVo.siteCode;
        tempTransportOrderVo.transportOrderNum = transportOrderVo.transportOrderNum;
        tempTransportOrderVo.outgoingOrderNum = transportOrderVo.outgoingOrderNum;
        tempTransportOrderVo.deliveryUser = userInfo.userCode;
        tempTransportOrderVo.modifyUser = userInfo.userCode;
        tempTransportOrderVo.idDYZ = transportOrderVo.idDYZ;
        
        NSMutableArray *detailList = [[NSMutableArray alloc] init];
        for (TransportOrderDetailVo *transportOrderDetailVo in transportOrderVo.transportOrderDetailVoList) {
            TransportOrderDetailVo *tempTransportOrderDetail = [[TransportOrderDetailVo alloc] init];
            tempTransportOrderDetail.idDYZ = transportOrderDetailVo.idDYZ;
            tempTransportOrderDetail.deliveryQuantity = transportOrderDetailVo.deliveryQuantity;
            tempTransportOrderDetail.materialOutgoingOrderDetailId = transportOrderDetailVo.materialOutgoingOrderDetailId;
            tempTransportOrderDetail.productionControlNum = transportOrderDetailVo.productionControlNum;
            tempTransportOrderDetail.productionOrderNum = transportOrderDetailVo.productionOrderNum;
            tempTransportOrderDetail.transportOrderId = transportOrderDetailVo.transportOrderId;
            [detailList addObject:tempTransportOrderDetail];
        }
        tempTransportOrderVo.transportOrderDetailVoList = detailList;
        [list addObject:tempTransportOrderVo];
    }
    postEntityBean.entity = list;
    
    
    NSDictionary *dic = @{@"data":postEntityBean.mj_JSONString};
    
    NSMutableArray <UploadImageBean *> *uploadImageArray = [[NSMutableArray alloc] init];
    for (TransportOrderVo *transportOrderVo in self.transportOrder.transportOrderVoList) {
        [uploadImageArray addObject:transportOrderVo.uploadImageBean];
    }
    
    [HttpMamager postRequestImageWithURLString:DYZ_mes_transportOrder_transportOrderDeliveryCommit parameters:dic UploadImageBean:uploadImageArray success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"收货成功"];
            self.transportOrderDeliveryCallBack();
            [self.navigationController popViewControllerAnimated:true];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"收货失败"];
        }
    } progress:^(NSProgress *progress) {
           
    } fail:^(NSError *error) {
        
    } isKindOfModelClass:NSClassFromString(@"ReturnMsgBean")];
}

- (void)take_A_Picture {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相机权限
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。
            authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.imagePicker = [[UIImagePickerController alloc] init];
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.imagePicker.delegate = self;
//                self.imagePicker.allowsEditing = true;
                [self presentViewController:self.imagePicker animated:YES completion:nil];
                
                
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请在iPhone的“设置－隐私”选项中，允许智造家访问你的摄像机和麦克风" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:action];
                [self.imagePicker presentViewController:alertController animated:YES completion:nil];
            }
        }else{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.imagePicker = [[UIImagePickerController alloc] init];
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.imagePicker.delegate = self;
//                self.imagePicker.allowsEditing = true;
                [self presentViewController:self.imagePicker animated:YES completion:nil];
                
            }
            else
            {
                NSLog(@"手机不支持相机");
            }
        }
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            self.imagePicker = [[UIImagePickerController alloc] init];
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.imagePicker.delegate = self;
            self.imagePicker.allowsEditing = YES;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
    }];
    
   
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [action0 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];

    [action3 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:action3];
    
    if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
        alertController.popoverPresentationController.sourceView = self.view;//必须加
        alertController.popoverPresentationController.sourceRect = CGRectMake(0, kMainH, kMainW, kMainH);//可选
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
//    UIImage *image = info[UIImagePickerControllerEditedImage];
//
//    CGSize size = CGSizeMake(640, 640);
//    UIGraphicsBeginImageContext(size);
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    CGSize size = CGSizeMake(kMainW, kMainH);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    UserBean *userBean = [[UserBean alloc] init];
    userBean.userId = loginModel.userId;
    
    postEntityBean.entity = userBean.mj_keyValues;
    
    NSDictionary *dic1 = postEntityBean.mj_keyValues;
    
    NSDictionary *dic = @{@"data":[NSString convertToJsonData:dic1]};
    
    
    TransportOrderVo *transportOrder = self.transportOrder.transportOrderVoList[self.index];
    
    UploadImageBean *uploadImageBean = [[UploadImageBean alloc] init];
    uploadImageBean.data = data;
    uploadImageBean.name = transportOrder.outgoingOrderNum;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [formatter stringFromDate:[NSDate date]];
    uploadImageBean.fileName = [NSString stringWithFormat:@"%@.png",strDate];
    uploadImageBean.mimeType = @"image/png";
    
    
    
    transportOrder.uploadImageBean = uploadImageBean;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:self.index] withRowAnimation:UITableViewRowAnimationNone];
    
    BOOL flag = YES;
    for (TransportOrderVo *vo in self.transportOrder.transportOrderVoList) {
        if (vo.uploadImageBean == nil) {
            flag = NO;
        }
    }
    if (flag) {
        self.affirmButton.enabled = YES;
        self.affirmButton.backgroundColor = colorRGB(40, 155, 229);
    } else {
        self.affirmButton.enabled = NO;
        self.affirmButton.backgroundColor = colorRGB(217, 217, 217);
    }
    
    
    
//    [HttpMamager postRequestImageWithURLString:DYZ_user_appUserHeadUpload parameters:dic UploadImageBean:@[uploadImageBean] success:^(id responseObjectModel) {
//        ReturnMsgBean *returnMsgBean = responseObjectModel;
//        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
////            [_tabelViewNORMAL reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
////            [_tabelViewENTERPRISE reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//        } else {
//            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
//        }
//    } fail:^(NSError *error) {
//        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
//    } isKindOfModelClass:NSClassFromString(@"ReturnMsgBean")];
    
    [self dismissViewControllerAnimated:true completion:nil];
}


- (UIToolbar *)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 38)];
    toolbar.tintColor = colorRGB(0, 168, 255);
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space,bar];
    return toolbar;
}

- (void)textFieldDone {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
