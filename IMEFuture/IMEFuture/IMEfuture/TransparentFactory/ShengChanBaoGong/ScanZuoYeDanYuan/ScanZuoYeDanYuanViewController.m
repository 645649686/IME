//
//  ScanZuoYeDanYuanViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ScanZuoYeDanYuanViewController.h"
#import "VoHeader.h"

#import "SaoYiSaoVC.h"
#import "ScanYuanGongMaViewController.h"
#import "TpfMaiViewController.h"
#import "ZuoYeDanYuanLieBiaoViewController.h"

@interface ScanZuoYeDanYuanViewController () <UITextFieldDelegate> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UILabel *labelOrderNum;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;

@end

@implementation ScanZuoYeDanYuanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserBean *userBean = [UserBean mj_objectWithKeyValues:loginModel.ucenterUser];
    NSString * siteCode = userBean.enterpriseInfo.serialNo;
    NSString *workUnitCode = [DatabaseTool t_TpfPWTableGetWorkUnitCodeWithSiteCode:siteCode];
    if (![workUnitCode isEqualToString:@"(null)"]) {
        NSLog(@"(null):存在");
        [self request:workUnitCode];
    } else {
        NSLog(@"(null):不存在");
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_BottomBar = Height_BottomBar;
    self.heightNavBar.constant = _height_NavBar;
    self.heightBottomBar.constant = _height_BottomBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self setAttributedString:@"摄像头对准作业单元二维码，\n点击扫描"];//设置中间字颜色
    
    self.labelOrderNum.text = [NSString stringWithFormat:@"生产订单：%@",self.productionOrderNum];
    
    self.textField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self request:textField.text];
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}


#pragma mark 扫描
- (IBAction)buttonScan:(id)sender {
    NSLog(@"%s",__FUNCTION__);
    
    SaoYiSaoVC *saoYiSaoVC = [[SaoYiSaoVC alloc] init];
    saoYiSaoVC.scanTitle = @"扫描作业单元二维码";
    [saoYiSaoVC setResultBlock:^(NSString *result) {
        NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        [self request:dic[@"workUnitCode"]];
    }];
    [self presentViewController:saoYiSaoVC animated:YES completion:nil];
}
- (void)request:(NSString *)result {
    
    _viewLoading.hidden = NO;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserBean *userBean = [UserBean mj_objectWithKeyValues:loginModel.ucenterUser];
    NSString * siteCode = userBean.enterpriseInfo.serialNo;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    ReportWorkWorkUnitScanVo *workUnitScanVo = [[ReportWorkWorkUnitScanVo alloc] init];
    workUnitScanVo.siteCode = siteCode;
    workUnitScanVo.productionControlNum = self.productionControlNum;
    workUnitScanVo.workUnitCode = result;
    mesPostEntityBean.entity = workUnitScanVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_scanRest_workUnitScan parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                ReportWorkWorkUnitScanVo *scanVo = [ReportWorkWorkUnitScanVo mj_objectWithKeyValues:dic];
                [dataArray addObject:scanVo];
            }
            if (returnListBean.list.count == 1) {
                ScanYuanGongMaViewController *scanYuanGongMaViewController = [[ScanYuanGongMaViewController alloc] init];
                scanYuanGongMaViewController.workUnitScanVo = [dataArray firstObject];
                scanYuanGongMaViewController.productionOrderNum = self.productionOrderNum;
                scanYuanGongMaViewController.requirementDate = self.requirementDate;
                scanYuanGongMaViewController.workRecordType = self.workRecordType;
                [self.navigationController pushViewController:scanYuanGongMaViewController animated:YES];
            } else {
                ZuoYeDanYuanLieBiaoViewController *zuoYeDanYuanLieBiaoViewController = [[ZuoYeDanYuanLieBiaoViewController alloc] init];
                zuoYeDanYuanLieBiaoViewController.dataArray = dataArray;
                [zuoYeDanYuanLieBiaoViewController setResultBlock:^(NSString *result) {
                    ScanYuanGongMaViewController *scanYuanGongMaViewController = [[ScanYuanGongMaViewController alloc] init];
                    scanYuanGongMaViewController.workUnitScanVo = [dataArray objectAtIndex:[result integerValue]];
                    scanYuanGongMaViewController.productionOrderNum = self.productionOrderNum;
                    scanYuanGongMaViewController.requirementDate = self.requirementDate;
                    scanYuanGongMaViewController.workRecordType = self.workRecordType;
                    [self.navigationController pushViewController:scanYuanGongMaViewController animated:YES];
                }];
                [self.navigationController pushViewController:zuoYeDanYuanLieBiaoViewController animated:YES];
            }
        } else {
            _viewLoading.hidden = YES;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

#pragma mark 回到首页
- (IBAction)buttonGoHome:(id)sender {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[TpfMaiViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
            break;
        }
    }
}

- (void)setAttributedString:(NSString *)text {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:colorRGB(0, 122, 254) range:NSMakeRange(5, text.length - 9)];
    self.label.attributedText = attributeStr;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
