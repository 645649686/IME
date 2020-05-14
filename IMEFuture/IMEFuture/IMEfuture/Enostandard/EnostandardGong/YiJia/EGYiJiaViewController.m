//
//  EGYiJiaViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/3/27.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "EGYiJiaViewController.h"
#import "VoHeader.h"

#import "BaoJiaDingJiaCell1.h"

#import "MXBaoJiaCell01.h"
#import "BaoJiaHeaderView01.h"
#import "YiJiaECMingXiCell00.h"
#import "YiJiaECMingXiCell01.h"
#import "YiJiaECMingXiCell02.h"
#import "YiJiaECMingXiXiuGaiCell00.h"
#import "YiJiaECMingXiXiuGaiCell01.h"
#import "YiJiaECMingXiXiuGaiCell10.h"
#import "YiJiaECMingXiXiuGaiCell11.h"
#import "YiJiaEGMingXiXiuGaiCell00.h"
#import "YiJiaEGMingXiXiuGaiCell01.h"
#import "YiJiaEGMingXiXiuGaiCell10.h"
#import "YiJiaEGMingXiXiuGaiCell11.h"
#import "MXBaoJiaCell011.h"
#import "MXBaoJiaCell111.h"
#import "YiJiaECMingXiXiuGaiCell12.h"
#import "YiJiaECMingXiXiuGaiCell13.h"


#import "Masonry.h"


#import "QiYeXinXiXiangQingViewController.h"
#import "XunPanXiangQingViewController.h"
#import "CommentUtils.h"
#import "EGOrderViewController.h"


#import "DingDanXiangQingGongViewController.h"
#import "EChooseTaxRateView5Kind.h"

#import "UIButtonIM.h"

#import "PartDetailsViewController.h"
#import "LingJianXiangQingViewController2.h"
#import "NSArray+Transition.h"
#import "UIViewXuanZeYaoQiuDaoHuoRiQi.h"
#import "GlobalSettingManager.h"


@interface EGYiJiaViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate,UITextViewDelegate>{
    NSMutableArray *_arrayInquiryOrderItemModel;
    NSMutableArray *_quotationOrderItems;
    NSMutableArray *_arrayYesOpen;
    NSInteger _integerButtonLineColor;
    QuotationOrder *_quotationOrderHttp;
    NSArray *_arrayJuJueShouPan;
    InquiryOrder *_inquiryOrderHttp;
    
    UIView *_viewLoading;
    
    EChooseTaxRateView5Kind *_eChooseTaxRateView5Kind;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation EGYiJiaViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
   self.titleHeader.text = @"供应商议价";
    
    _arrayJuJueShouPan = @[@"报价有问题",@"还在磋商中",@"工厂产能不足",@"不能按时完成",@"其他原因"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell01" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaoJiaHeaderView01" bundle:nil] forHeaderFooterViewReuseIdentifier:@"baoJiaHeaderView01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell00"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell01" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell02" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell02"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell00"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell01" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell10" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell10"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell11" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell11"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaEGMingXiXiuGaiCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaEGMingXiXiuGaiCell00"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaEGMingXiXiuGaiCell01" bundle:nil] forCellReuseIdentifier:@"yiJiaEGMingXiXiuGaiCell01"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaEGMingXiXiuGaiCell10" bundle:nil] forCellReuseIdentifier:@"yiJiaEGMingXiXiuGaiCell10"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YiJiaEGMingXiXiuGaiCell11" bundle:nil] forCellReuseIdentifier:@"yiJiaEGMingXiXiuGaiCell11"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell011" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell011"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tag = 88;
    
    
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    [self.tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell01" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"BaoJiaHeaderView01" bundle:nil] forHeaderFooterViewReuseIdentifier:@"baoJiaHeaderView01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell00"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell01" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiCell02" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiCell02"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell00"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell01" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell10" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell10"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell11" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell11"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaEGMingXiXiuGaiCell00" bundle:nil] forCellReuseIdentifier:@"yiJiaEGMingXiXiuGaiCell00"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaEGMingXiXiuGaiCell01" bundle:nil] forCellReuseIdentifier:@"yiJiaEGMingXiXiuGaiCell01"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaEGMingXiXiuGaiCell10" bundle:nil] forCellReuseIdentifier:@"yiJiaEGMingXiXiuGaiCell10"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaEGMingXiXiuGaiCell11" bundle:nil] forCellReuseIdentifier:@"yiJiaEGMingXiXiuGaiCell11"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MXBaoJiaCell111" bundle:nil] forCellReuseIdentifier:@"mXBaoJiaCell111"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell12" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell12"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"YiJiaECMingXiXiuGaiCell13" bundle:nil] forCellReuseIdentifier:@"yiJiaECMingXiXiuGaiCell13"];
    self.tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView1.tableFooterView = [UIView new];
    self.tableView1.tag = 89;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    tap.delegate = self;
    [self.tableView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    tap1.delegate = self;
    [self.tableView1 addGestureRecognizer:tap1];
    
    self.titleHeader.text = @"供应商议价";

    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = NO;
    
    [self initRequestQuotationDetail];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 1;
        } else if (section == 2) {
            return 0;
        } else if (section < 3+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
//                return 1;
                return 2;
            }
        } else if (section == 3+_quotationOrderItems.count) {
//            return 1+1+2+1;
            return 1;
        } else if (section == 3+_quotationOrderItems.count+1) {
            return 1;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 1;
        } else if (section == 2) {
            return 0;
        } else if (section < 3+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 0;
            } else {
                return 1+1+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+2+2;
            }
        } else if (section == 3+_quotationOrderItems.count) {
//            return 1+1+[_inquiryOrderHttp.tempCostDetailCount integerValue]+[_inquiryOrderHttp.tempShipPriceDetailCount integerValue]+1;
            return 1;
        } else if (section == 3+_quotationOrderItems.count+1) {
            return 1;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 88) {
        if (indexPath.section == 0) {
            return 68;
        } else if (indexPath.section == 1) {
            return 50;
        } else if (indexPath.section == 2) {
            return 0;
        } else if (indexPath.section < 3+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                return 265;
            } else {
                return 114;
            }
        } else if (indexPath.section == 3+_quotationOrderItems.count) {
//            if (indexPath.row == 0) {
//                return 60;
//            } else {
//                return 40;
//            }
            return 40;
        } else if (indexPath.section == 3+_quotationOrderItems.count+1) {
            return 81;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (indexPath.section == 0) {
            return 68;
        } else if (indexPath.section == 1) {
            return 50;
        } else if (indexPath.section == 2) {
            return 0;
        } else if (indexPath.section < 3+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                return 221;
            } else if (indexPath.row == 1) {
                return 60;
            } else {
                return 40;
            }
        } else if (indexPath.section == 3+_quotationOrderItems.count) {
//            if (indexPath.row == 0) {
//                return 60;
//            } else {
//                return 40;
//            }
            return 40;
        } else if (indexPath.section == 3+_quotationOrderItems.count+1) {
            return 81;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 88) {
        return 1+1+1+1+_quotationOrderItems.count+1;
    } else if (tableView.tag == 89) {
        return 1+1+1+1+_quotationOrderItems.count+1;
    } else {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 0.1;
        } else if (section == 1) {
            return 0.1;
        } else if (section == 2) {
            return 32;
        } else if (section < 3+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 3+_quotationOrderItems.count) {
            return 32;
        } else if (section == 3+_quotationOrderItems.count+1) {
            return 32;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 0.1;
        } else if (section == 1) {
            return 0.1;
        } else if (section == 2) {
            return 32;
        } else if (section < 3+_quotationOrderItems.count) {
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                return 98;
            } else {
                return 0.1;
            }
        } else if (section == 3+_quotationOrderItems.count) {
            return 32;
        } else if (section == 3+_quotationOrderItems.count+1) {
            return 32;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return 5;
        } else if (section == 1) {
            return 0.1;
        } else if (section == 2) {
            return 0.1;
        } else if (section < 3+_quotationOrderItems.count) {
            if (section == 3+_quotationOrderItems.count-1) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 3+_quotationOrderItems.count) {
            return 0.1;
        } else if (section == 3+_quotationOrderItems.count+1) {
            return 0.1;
        } else {
            return 0;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return 5;
        } else if (section == 1) {
            return 0.1;
        } else if (section == 2) {
            return 0.1;
        } else if (section < 3+_quotationOrderItems.count) {
            if (section == 3+_quotationOrderItems.count-1) {
                return 0.1;
            } else {
                return 5;
            }
        } else if (section == 3+_quotationOrderItems.count) {
            return 0.1;
        } else if (section == 3+_quotationOrderItems.count+1) {
            return 0.1;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 88) {
        if (section == 0) {
            return nil;
        } else if (section == 1) {
            return nil;
        } else if (section == 2) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 74, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件报价";
            [view addSubview:labelDiYiBaoJia];
            
            UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(15+74+10, 0, kMainW-30-74-10, 32)];
            labelTitle1.font = [UIFont systemFontOfSize:12];
            labelTitle1.textColor = colorText153;
            labelTitle1.text = _inquiryOrderHttp.title;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
            return view;
        } else if (section < 3+_quotationOrderItems.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewYiBaoJia.hidden = YES;
            view.viewWeiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            view.viewYiJia.hidden = YES;
            
            view.viewYiJia.hidden = NO;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 3];
            QuotationOrderItem *quotationOrderItem = _quotationOrderItems[section - 3];
            
//            if ([quotationOrderItem.price1 doubleValue]>0) {
//                view.viewYiBaoJia.hidden = NO;
//            } else {
//                view.viewWeiBaoJia.hidden = NO;
//            }
            view.viewYiJia.hidden = NO;
            
            NSString *partNumber_specifications;
            if (model.partNumber.length>0&&model.specifications.length>0) {
                partNumber_specifications = [NSString stringWithFormat:@"%@/%@",model.partNumber,model.specifications];
            } else if (model.partNumber.length>0&&model.specifications.length==0) {
                partNumber_specifications = model.partNumber;
            } else if (model.partNumber.length==0&&model.specifications.length>0) {
                partNumber_specifications = model.specifications;
            } else {
                partNumber_specifications = @"--";
            }
            view.labelName.text =  [NSString stringWithFormat:@"%ld、%@",section-3+1,partNumber_specifications];
            view.label00.textColor = colorRGB(0, 168, 255);
            view.label0.textColor = colorRGB(0, 168, 255);
            view.label0.text  = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:nil;
            
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.price1 doubleValue];
            view.label1.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            
            view.label2.text  = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label2DanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            
            view.label0Wei.text = @"待报价";
            view.label0Wei.textColor = colorRGB(0, 168, 255);
            view.label1Wei.text = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label1WeiDanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            view.buttonOpen.tag = section-3;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-3;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            
            view.labelYiJia1.text = quotationOrderItem.purchasePrice1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]]:@"0.00";
            view.labelYiJia2.text = @"采购商报价";
            
            NSString *string = _arrayYesOpen[section-3];
            if ([string isEqualToString:@"no"]) {
                view.textFieldYiJia.hidden = NO;
            } else {
                view.textFieldYiJia.hidden = YES;
            }
            
            view.textFieldYiJia.delegate = self;
            view.textFieldYiJia.tag = section - 3;
            view.textFieldYiJia.inputAccessoryView = [self addToolbar];
            [view.textFieldYiJia addTarget:self action:@selector(priceCalculation:) forControlEvents:UIControlEventEditingChanged];
            view.textFieldYiJia.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%@",quotationOrderItem.price1]:nil;
            return view;
        } else if (section == 3+_quotationOrderItems.count) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件总计";
            [view addSubview:labelDiYiBaoJia];
            
            return view;
        } else if (section == 3+_quotationOrderItems.count+1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"备注";
            [view addSubview:labelDiYiBaoJia];
            return view;
        } else {
            return nil;
        }
    } else if (tableView.tag == 89) {
        if (section == 0) {
            return nil;
        } else if (section == 1) {
            return nil;
        } else if (section == 2) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 74, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件报价明细";
            [view addSubview:labelDiYiBaoJia];
            
            UILabel *labelTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(15+74+10, 0, kMainW-30-74-10, 32)];
            labelTitle1.font = [UIFont systemFontOfSize:12];
            labelTitle1.textColor = colorText153;
            labelTitle1.text = _inquiryOrderHttp.title;
            labelTitle1.textAlignment = NSTextAlignmentRight;
            [view addSubview:labelTitle1];
            
            return view;
        } else if (section < 3+_quotationOrderItems.count) {
            BaoJiaHeaderView01 *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"baoJiaHeaderView01"];
            
            view.viewYiBaoJia.hidden = YES;
            view.viewWeiBaoJia.hidden = YES;
            view.viewZanBuBaoJia.hidden = YES;
            view.viewZongJia.hidden = YES;
            
            InquiryOrderItem *model = _arrayInquiryOrderItemModel[section - 3];
            QuotationOrderItem *quotationOrderItem = _quotationOrderItems[section - 3];
            
            if ([quotationOrderItem.price1 doubleValue]>0) {
                view.viewYiBaoJia.hidden = NO;
            } else {
                view.viewWeiBaoJia.hidden = NO;
            }
            
            NSString *partNumber_specifications;
            if (model.partNumber.length>0&&model.specifications.length>0) {
                partNumber_specifications = [NSString stringWithFormat:@"%@/%@",model.partNumber,model.specifications];
            } else if (model.partNumber.length>0&&model.specifications.length==0) {
                partNumber_specifications = model.partNumber;
            } else if (model.partNumber.length==0&&model.specifications.length>0) {
                partNumber_specifications = model.specifications;
            } else {
                partNumber_specifications = @"--";
            }
            view.labelName.text = [NSString stringWithFormat:@"%ld、%@",section-3+1,partNumber_specifications];
            view.label00.textColor = colorRGB(0, 168, 255);
            view.label0.textColor = colorRGB(0, 168, 255);
            view.label0.text  = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:nil;
            
            double totalPrice = 0;
            totalPrice = [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.price1 doubleValue];
            view.label1.text = [NSString stringWithFormat:@"%.2f",totalPrice];
            
            view.label2.text  = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label2DanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            
            view.label0Wei.text = @"待报价";
            view.label0Wei.textColor = colorRGB(0, 168, 255);
            view.label1Wei.text = [NSString stringWithFormat:@"%@",quotationOrderItem.num1];
            view.label1WeiDanWei.text = [NSString QuantityUnit:model.quantityUnit]?[NSString stringWithFormat:@"%@",[NSString QuantityUnit:model.quantityUnit]]:nil;
            view.buttonOpen.tag = section-3;
            [view.buttonOpen addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            view.buttonOpen1.tag = section-3;
            [view.buttonOpen1 addTarget:self action:@selector(buttonOpenClick:) forControlEvents:UIControlEventTouchUpInside];
            return view;
        } else if (section == 3+_quotationOrderItems.count) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 50, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"零件总计";
            [view addSubview:labelDiYiBaoJia];
        
            return view;
        } else if (section == 3+_quotationOrderItems.count+1) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 32)];
            view.backgroundColor = colorRGB(241, 241, 241);
            [self line:view withY:0 withTag:0];
            
            UILabel *labelDiYiBaoJia = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 32)];
            labelDiYiBaoJia.font = [UIFont systemFontOfSize:12];
            labelDiYiBaoJia.textColor = colorText153;
            labelDiYiBaoJia.text = @"备注";
            [view addSubview:labelDiYiBaoJia];
            return view;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 88) {
        if (indexPath.section == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [self line:cell.contentView withY:67.5 withTag:0];
            UIImageView *imageViewH = [[UIImageView alloc] init];
            [cell.contentView addSubview:imageViewH];
            [imageViewH mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(10);
                make.top.equalTo(cell.contentView.mas_top).with.offset(10);
                make.width.mas_equalTo(48);
                make.height.mas_equalTo(48);
            }];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.textColor = colorRGB(32, 32, 32);
            [cell.contentView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageViewH.mas_right).with.offset(10);
                make.top.equalTo(imageViewH.mas_top).with.offset(5);
                make.right.equalTo(cell.mas_right).with.offset(-83-5);
            }];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.textColor = colorRGB(117, 117, 117);
            label2.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageViewH.mas_right).with.offset(10);
                make.top.equalTo(label1.mas_bottom).with.offset(3);
            }];
            
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            if ([_quotationOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_inquiryOrderHttp.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                label2.text = [NSString stringWithFormat:@"%@ %@",_inquiryOrderHttp.member.enterpriseInfo.province?_inquiryOrderHttp.member.enterpriseInfo.province:@"",_inquiryOrderHttp.member.enterpriseInfo.city?_inquiryOrderHttp.member.enterpriseInfo.city:@""];
                label1.text = _inquiryOrderHttp.member.enterpriseInfo.enterpriseName;
                

            } else {//供应商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_quotationOrderHttp.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                
                label2.text = [NSString stringWithFormat:@"%@ %@",_quotationOrderHttp.member.enterpriseInfo.province?_quotationOrderHttp.member.enterpriseInfo.province:@"",_quotationOrderHttp.member.enterpriseInfo.city?_quotationOrderHttp.member.enterpriseInfo.city:@""];
                label1.text = _quotationOrderHttp.member.enterpriseInfo.enterpriseName;
                
  
            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else if (indexPath.section == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 8 || view.tag == 9 || view.tag == 10 || view.tag == 11 || view.tag == 19921126) {
                    [view removeFromSuperview];
                }
            }
            [self line:cell.contentView withY:0 withTag:8];
            
            NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f%@",[_quotationOrderHttp.supplierTaxRate doubleValue]*100,@"%"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 56)];
            label.text = [NSString stringWithFormat:@"税率(%@)",stringTaxRate];
            label.tag = 9;
            label.textColor = colorRGB(32, 32, 32);
            [cell.contentView addSubview:label];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, kMainW, 56);
            button.backgroundColor = [UIColor clearColor];
            button.tag = 10;
            [button addTarget:self action:@selector(buttonIndexPath00) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
            
            UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 55.5, kMainW, 0.5)];
            viewLine.backgroundColor = colorRGB(221, 221, 221);
            viewLine.tag = 11;
            [cell.contentView addSubview:viewLine];
            
            return cell;
        } else if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 3+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.clipsToBounds = true;
                
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                
                cell.viewZongYiJia.hidden = YES;
                cell.viewZongYiJia.hidden = NO;
                
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 3];
                QuotationOrderItem *quotationOrderItem =  _quotationOrderItems[indexPath.section - 3];
                
                NSString *partNumber_specifications;
                if (inquiryOrderItem.partNumber.length>0&&inquiryOrderItem.specifications.length>0) {
                    partNumber_specifications = [NSString stringWithFormat:@"%@/%@",inquiryOrderItem.partNumber,inquiryOrderItem.specifications];
                } else if (inquiryOrderItem.partNumber.length>0&&inquiryOrderItem.specifications.length==0) {
                    partNumber_specifications = inquiryOrderItem.partNumber;
                } else if (inquiryOrderItem.partNumber.length==0&&inquiryOrderItem.specifications.length>0) {
                    partNumber_specifications = inquiryOrderItem.specifications;
                } else {
                    partNumber_specifications = @"--";
                }
                cell.dyzPartNumber.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section-3+1,partNumber_specifications];
                cell.materialName.text = inquiryOrderItem.materialName2.length>0?inquiryOrderItem.materialName2:@"--";
                
                cell.dyzPartName.text = inquiryOrderItem.partName.length>0?inquiryOrderItem.partName:@"--";
                
                if ([NSString SizeUnit:inquiryOrderItem.sizeUnit]) {
                    cell.sizeLWHUnit.text = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[inquiryOrderItem.length doubleValue],[inquiryOrderItem.width doubleValue],[inquiryOrderItem.height doubleValue],[NSString SizeUnit:inquiryOrderItem.sizeUnit]];
                } else {
                    cell.sizeLWHUnit.text = @"--";
                }
                
                cell.num123.text = [NSString stringWithFormat:@"%@%@",[NSString removeSuffixIsZone:[inquiryOrderItem.num1 doubleValue]],[NSString QuantityUnit:inquiryOrderItem.quantityUnit].length>0?[NSString QuantityUnit:inquiryOrderItem.quantityUnit]:@""];
                
                if ([inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:inquiryOrderItem.sec_thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                } else {
                    
                    NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_inquiryOrderHttp.member.enterpriseInfo.enterpriseId,inquiryOrderItem.partNumber,inquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                }
                
                NSString *batchDeliverItem = [[inquiryOrderItem.deliveryTime componentsSeparatedByString:@" "] firstObject];
                cell.labelDaoHuoTime.text = [NSString stringWithFormat:@"交货日期:%@",batchDeliverItem];
                
                cell.buttonClose.tag = indexPath.section - 3;
                [cell.buttonClose addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonClose1.tag = indexPath.section - 3;
                [cell.buttonClose1 addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonImage.tag = indexPath.section - 3;
                [cell.buttonImage addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonDetail.tag = indexPath.section - 3;
                [cell.buttonDetail setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                
                
                cell.zongYiJialabel1.text = [NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]];
                cell.zongYiJialabel2.text = @"采购商报价:";
                
                cell.zongYiJiaTextField.hidden = true;
//                cell.zongYiJiaTextField.delegate = self;
//                cell.zongYiJiaTextField.tag = indexPath.section - 3;
//                cell.zongYiJiaTextField.inputAccessoryView = [self addToolbar];
//                [cell.zongYiJiaTextField addTarget:self action:@selector(priceCalculation:) forControlEvents:UIControlEventEditingChanged];
//                cell.zongYiJiaTextField.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%@",quotationOrderItem.price1]:nil;
                
                return cell;
            } else if (indexPath.row == 1) {
                MXBaoJiaCell011 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell011" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem =  _quotationOrderItems[indexPath.section - 3];
                
                cell.textFieldPrice.delegate = self;
                cell.textFieldPrice.tag = indexPath.section - 3;
                cell.textFieldPrice.inputAccessoryView = [self addToolbar];
                [cell.textFieldPrice addTarget:self action:@selector(priceCalculation:) forControlEvents:UIControlEventEditingChanged];
                cell.textFieldPrice.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%@",quotationOrderItem.price1]:nil;
                
                cell.textFieldResponseDate.tag = indexPath.section - 3;
                cell.textFieldResponseDate.tintColor = [UIColor clearColor];
                cell.textFieldResponseDate.inputView = [UIView new];
                [cell.textFieldResponseDate addTarget:self action:@selector(textFieldPurchaseDeliverTime:) forControlEvents:UIControlEventEditingDidBegin];
                if (quotationOrderItem.supplierDeliverTime) {
                    cell.textFieldResponseDate.text = [[quotationOrderItem.supplierDeliverTime componentsSeparatedByString:@" "] firstObject];
                } else {
                    cell.textFieldResponseDate.text = nil;
                }
                
                cell.textFieldPartRemark.tag = indexPath.section - 3;
                cell.textFieldPartRemark.inputAccessoryView = [self addToolbar];
                [cell.textFieldPartRemark addTarget:self action:@selector(textFieldPurchaseRemark:) forControlEvents:UIControlEventEditingChanged];
                cell.textFieldPartRemark.text = quotationOrderItem.supplierRemark?quotationOrderItem.supplierRemark:nil;
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 3+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell111 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell111" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrderHttp.supplierTaxRate doubleValue]*100];
//                cell.label0.text = [NSString stringWithFormat:@"总计(含税价%@%@)",stringTaxRate,@"%"];
                cell.label0.text = @"未税总计";
                cell.label2.text = _quotationOrderHttp.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.totalPrice1 doubleValue]]:@"0.00";
                
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 3+_quotationOrderItems.count+1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 9 || view.tag == 10 || view.tag == 11 || view.tag == 19921125 || view.tag == 19921126 || view.tag == 12) {
                    [view removeFromSuperview];
                }
            }
            UITextView *oneTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, kMainW-20, 55)];
            oneTextView.font = [UIFont systemFontOfSize:14];
            oneTextView.delegate = self;
            oneTextView.text = _quotationOrderHttp.remark;
            oneTextView.tag = 19921126;
            oneTextView.inputAccessoryView = [self addToolbar];
            [cell.contentView addSubview:oneTextView];
//            oneTextView.layer.cornerRadius = 7;
//            oneTextView.layer.borderWidth = 0.5;
//            oneTextView.layer.borderColor = colorRGB(209, 209, 209).CGColor;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, oneTextView.frame.size.width, 16)];
            label.text = @"请输入议价备注";
            label.textColor = colorRGB(177, 177, 177);
            label.font = [UIFont systemFontOfSize:14];
            label.tag = 19921125;
            [oneTextView addSubview:label];
            
            if (oneTextView.text.length > 0) {
                label.hidden = YES;
            } else {
                label.hidden = NO;
            }
            
            [self line:cell.contentView withY:80.5 withTag:12];
            
            return cell;
        } else {
            return nil;
        }
    } else if (tableView.tag == 89) {
        if (indexPath.section == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            [self line:cell.contentView withY:67.5 withTag:0];
            UIImageView *imageViewH = [[UIImageView alloc] init];
            [cell.contentView addSubview:imageViewH];
            [imageViewH mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(10);
                make.top.equalTo(cell.contentView.mas_top).with.offset(10);
                make.width.mas_equalTo(48);
                make.height.mas_equalTo(48);
            }];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.textColor = colorRGB(32, 32, 32);
            [cell.contentView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageViewH.mas_right).with.offset(10);
                make.top.equalTo(imageViewH.mas_top).with.offset(5);
                make.right.equalTo(cell.mas_right).with.offset(-83-5);
            }];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.textColor = colorRGB(117, 117, 117);
            label2.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageViewH.mas_right).with.offset(10);
                make.top.equalTo(label1.mas_bottom).with.offset(3);
            }];
            
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            if ([_quotationOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_inquiryOrderHttp.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                label2.text = [NSString stringWithFormat:@"%@ %@",_inquiryOrderHttp.member.enterpriseInfo.province?_inquiryOrderHttp.member.enterpriseInfo.province:@"",_inquiryOrderHttp.member.enterpriseInfo.city?_inquiryOrderHttp.member.enterpriseInfo.city:@""];
                label1.text = _inquiryOrderHttp.member.enterpriseInfo.enterpriseName;
                
    
            } else {//供应商身份进来
                [imageViewH sd_setImageWithURL:[NSURL URLWithString:_quotationOrderHttp.member.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
                
                label2.text = [NSString stringWithFormat:@"%@ %@",_quotationOrderHttp.member.enterpriseInfo.province?_quotationOrderHttp.member.enterpriseInfo.province:@"",_quotationOrderHttp.member.enterpriseInfo.city?_quotationOrderHttp.member.enterpriseInfo.city:@""];
                label1.text = _quotationOrderHttp.member.enterpriseInfo.enterpriseName;
                

            }
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        } else if (indexPath.section == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 8 || view.tag == 9 || view.tag == 10 || view.tag == 11 || view.tag == 19921126) {
                    [view removeFromSuperview];
                }
            }
            [self line:cell.contentView withY:0 withTag:8];
            
            NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f%@",[_quotationOrderHttp.supplierTaxRate doubleValue]*100,@"%"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 56)];
            label.text = [NSString stringWithFormat:@"税率(%@)",stringTaxRate];
            label.tag = 9;
            label.textColor = colorRGB(32, 32, 32);
            [cell.contentView addSubview:label];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, kMainW, 56);
            button.backgroundColor = [UIColor clearColor];
            button.tag = 10;
            [button addTarget:self action:@selector(buttonIndexPath00) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
            
            UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 55.5, kMainW, 0.5)];
            viewLine.backgroundColor = colorRGB(221, 221, 221);
            viewLine.tag = 11;
            [cell.contentView addSubview:viewLine];
            
            return cell;
        } else if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            return cell;
        } else if (indexPath.section < 3+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell01 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell01" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.viewZanBuBaoJia.hidden = YES;
                cell.buttonZanBuBaoJia.hidden = YES;
                cell.viewZongjia.hidden = YES;
                
                InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[indexPath.section - 3];
                QuotationOrderItem *quotationOrderItem =  _quotationOrderItems[indexPath.section - 3];
                NSString *partNumber_specifications;
                if (inquiryOrderItem.partNumber.length>0&&inquiryOrderItem.specifications.length>0) {
                    partNumber_specifications = [NSString stringWithFormat:@"%@/%@",inquiryOrderItem.partNumber,inquiryOrderItem.specifications];
                } else if (inquiryOrderItem.partNumber.length>0&&inquiryOrderItem.specifications.length==0) {
                    partNumber_specifications = inquiryOrderItem.partNumber;
                } else if (inquiryOrderItem.partNumber.length==0&&inquiryOrderItem.specifications.length>0) {
                    partNumber_specifications = inquiryOrderItem.specifications;
                } else {
                    partNumber_specifications = @"--";
                }
                cell.dyzPartNumber.text = [NSString stringWithFormat:@"%ld、%@",indexPath.section-3+1,partNumber_specifications];
                cell.materialName.text = inquiryOrderItem.materialName2.length>0?inquiryOrderItem.materialName2:@"--";
                
                cell.dyzPartName.text = inquiryOrderItem.partName.length>0?inquiryOrderItem.partName:@"--";
                
                if ([NSString SizeUnit:inquiryOrderItem.sizeUnit]) {
                    cell.sizeLWHUnit.text = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[inquiryOrderItem.length doubleValue],[inquiryOrderItem.width doubleValue],[inquiryOrderItem.height doubleValue],[NSString SizeUnit:inquiryOrderItem.sizeUnit]];
                } else {
                    cell.sizeLWHUnit.text = @"--";
                }
                
                cell.num123.text = [NSString stringWithFormat:@"%@%@",[NSString removeSuffixIsZone:[inquiryOrderItem.num1 doubleValue]],[NSString QuantityUnit:inquiryOrderItem.quantityUnit].length>0?[NSString QuantityUnit:inquiryOrderItem.quantityUnit]:@""];
                
                if ([inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:inquiryOrderItem.sec_thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                } else {
                    
                    NSString *stringURL = [[NSString stringWithFormat:@"%@?enterpriseId=%@&partNumber=%@&picVersion=%@",DYZ_drawingCloud_getThumbnailUrl_jpg,_inquiryOrderHttp.member.enterpriseInfo.enterpriseId,inquiryOrderItem.partNumber,inquiryOrderItem.picVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [cell.sec_thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:stringURL] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
                }
                
                NSString *batchDeliverItem = [[inquiryOrderItem.deliveryTime componentsSeparatedByString:@" "] firstObject];
                cell.labelDaoHuoTime.text = [NSString stringWithFormat:@"交货日期:%@",batchDeliverItem];
                
                cell.buttonClose.tag = indexPath.section - 3;
                [cell.buttonClose addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonClose1.tag = indexPath.section - 3;
                [cell.buttonClose1 addTarget:self action:@selector(buttonCloseClick:) forControlEvents:UIControlEventTouchUpInside];
                cell.buttonImage.tag = indexPath.section - 3;
                [cell.buttonImage addTarget:self action:@selector(buttonImageClick:) forControlEvents:UIControlEventTouchUpInside];
                
                cell.buttonDetail.tag = indexPath.section - 3;
                [cell.buttonDetail setTitleColor:colorRGB(0, 168, 255) forState:UIControlStateNormal];
                [cell.buttonDetail addTarget:self action:@selector(buttonDetailClick:) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            } else if (indexPath.row == 1) {
                YiJiaEGMingXiXiuGaiCell10 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaEGMingXiXiuGaiCell10" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.view1.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
                cell.view2.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
                
                cell.label1.text = @"采购商议价(元)";
                cell.label2.text = @"我的报价(元)";
                
                cell.button1.tag = indexPath.section - 3;
                [cell.button1 addTarget:self action:@selector(buttonImportPriceMingXi:) forControlEvents:UIControlEventTouchUpInside];
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]) {
                YiJiaEGMingXiXiuGaiCell11 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaEGMingXiXiuGaiCell11" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                
                cell.label0.text = [_inquiryOrderHttp valueForKey:[NSString stringWithFormat:@"tempPriceDetailName%ld",indexPath.row-1]];
                
                
                NSNumber *purchaseTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"purchaseTempPrice1DetailValue%ld",indexPath.row-1]];
                cell.label1.text = purchaseTempPrice1DetailValue?[NSString stringWithFormat:@"%.2f",[purchaseTempPrice1DetailValue doubleValue]]:nil;
                NSNumber *supplierTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%ld",indexPath.row-1]];
//                if ([supplierTempPrice1DetailValue doubleValue] == 0) {
//                    cell.textField2.placeholder = supplierTempPrice1DetailValue?[NSString stringWithFormat:@"%@",supplierTempPrice1DetailValue]:@"0.00";
//                } else {
//                    cell.textField2.text = supplierTempPrice1DetailValue?[NSString stringWithFormat:@"%@",supplierTempPrice1DetailValue]:@"0.00";
//                }
                cell.textField2.text = supplierTempPrice1DetailValue?[NSString stringWithFormat:@"%@",supplierTempPrice1DetailValue]:@"0.00";
                
                cell.textField2SuperView.tag = indexPath.section - 3;
                cell.textField2.tag = indexPath.row - 2;
                //cell.textField2.delegate = self;
                cell.textField2.inputAccessoryView = [self addToolbar];
                [cell.textField2 addTarget:self action:@selector(price1MingXi:) forControlEvents:UIControlEventEditingChanged];
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+2) {
                YiJiaECMingXiCell02 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiCell02" forIndexPath:indexPath];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                
                cell.view0.backgroundColor = [colorRGB(0, 168, 255) colorWithAlphaComponent:0.05];
                if (indexPath.row == 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]) {
                    cell.label0.text = @"含税单价";
                    cell.label1.text = quotationOrderItem.purchasePrice1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]]:@"0.00";
                    cell.label2.textColor = colorRGB(0, 168, 255);
                    cell.label2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]]:@"0.00";
                } else if (indexPath.row == 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+1) {
                    cell.label0.text = @"不含税单价";
                    cell.label1.text = quotationOrderItem.purchasePrice1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.purchasePrice1 doubleValue]/(1+[_quotationOrderHttp.supplierTaxRate doubleValue])]:nil;
                    cell.label2.textColor = colorRGB(51, 51, 51);
                    cell.label2.text = quotationOrderItem.price1?[NSString stringWithFormat:@"%.2f",[quotationOrderItem.price1 doubleValue]/(1+[_quotationOrderHttp.supplierTaxRate doubleValue])]:nil;
                }
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+2+1) {
                YiJiaECMingXiXiuGaiCell12 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell12" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                
                cell.label0.text = @"回复交期";
                
                cell.textField1.placeholder = @"请选择";
                cell.textField1.tag = indexPath.section - 3;
                cell.textField1.tintColor = [UIColor clearColor];
                cell.textField1.inputView = [UIView new];
                [cell.textField1 addTarget:self action:@selector(textFieldPurchaseDeliverTime:) forControlEvents:UIControlEventEditingDidBegin];
                if (quotationOrderItem.supplierDeliverTime) {
                    cell.textField1.text = [[quotationOrderItem.supplierDeliverTime componentsSeparatedByString:@" "] firstObject];
                } else {
                    cell.textField1.text = nil;
                }
                
                return cell;
            } else if (indexPath.row < 2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+2+2) {
                YiJiaECMingXiXiuGaiCell13 *cell = [tableView dequeueReusableCellWithIdentifier:@"yiJiaECMingXiXiuGaiCell13" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                QuotationOrderItem *quotationOrderItem = _quotationOrderItems[indexPath.section - 3];
                cell.label0.text = @"零件备注";
                cell.textField1.placeholder = @"请输入";
                cell.textField1.tag = indexPath.section - 3;
                cell.textField1.inputAccessoryView = [self addToolbar];
                [cell.textField1 addTarget:self action:@selector(textFieldPurchaseRemark:) forControlEvents:UIControlEventEditingChanged];
                cell.textField1.text = quotationOrderItem.supplierRemark?quotationOrderItem.supplierRemark:nil;
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 3+_quotationOrderItems.count) {
            if (indexPath.row == 0) {
                MXBaoJiaCell111 *cell = [tableView dequeueReusableCellWithIdentifier:@"mXBaoJiaCell111" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrderHttp.supplierTaxRate doubleValue]*100];
//                cell.label0.text = [NSString stringWithFormat:@"总计(含税价%@%@)",stringTaxRate,@"%"];
                cell.label0.text = @"未税总计";
                cell.label2.text = _quotationOrderHttp.totalPrice1?[NSString stringWithFormat:@"%.2f",[_quotationOrderHttp.totalPrice1 doubleValue]]:@"0.00";
                
                return cell;
            } else {
                return nil;
            }
        } else if (indexPath.section == 3+_quotationOrderItems.count+1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 9 || view.tag == 10 || view.tag == 11 || view.tag == 19921125 || view.tag == 19921126 || view.tag == 12) {
                    [view removeFromSuperview];
                }
            }
            UITextView *oneTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, kMainW-20, 55)];
            oneTextView.font = [UIFont systemFontOfSize:14];
            oneTextView.delegate = self;
            oneTextView.text = _quotationOrderHttp.remark;
            oneTextView.tag = 19921126;
            oneTextView.inputAccessoryView = [self addToolbar];
            [cell.contentView addSubview:oneTextView];
//            oneTextView.layer.cornerRadius = 7;
//            oneTextView.layer.borderWidth = 0.5;
//            oneTextView.layer.borderColor = colorRGB(209, 209, 209).CGColor;
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, oneTextView.frame.size.width, 16)];
            label.text = @"请输入议价备注";
            label.textColor = colorRGB(177, 177, 177);
            label.font = [UIFont systemFontOfSize:14];
            label.tag = 19921125;
            [oneTextView addSubview:label];
            
            if (oneTextView.text.length > 0) {
                label.hidden = YES;
            } else {
                label.hidden = NO;
            }
            
            [self line:cell.contentView withY:80.5 withTag:12];
            
            return cell;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
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

- (void)buttonOpenClick:(UIButton *)sender {
    
    [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"yes"];
    [self textFieldDone];
    [_tableView reloadData];
    [_tableView1 reloadData];
}

- (void)buttonCloseClick:(UIButton *)sender {
    NSLog(@"%s %ld",__FUNCTION__,sender.tag);
    [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"no"];
    [_tableView reloadData];
    [_tableView1 reloadData];
}

- (void)buttonImageClick:(UIButton *)sender {
    InquiryOrderItem *inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
    NSLog(@">>>%ld<",inquiryOrderItem.inquiryOrderItemFiles.count);
    
    if (inquiryOrderItem.inquiryOrderItemFiles.count == 1) {
        LingJianXiangQingViewController2 *lingJianXiangQingViewController2 = [[LingJianXiangQingViewController2 alloc] init];
        lingJianXiangQingViewController2.isMatchDrawingCloud = inquiryOrderItem.isMatchDrawingCloud;
        lingJianXiangQingViewController2.inquiryOrderItemFile = inquiryOrderItem.inquiryOrderItemFiles[0];
        [self.navigationController pushViewController:lingJianXiangQingViewController2 animated:YES];
    } else if ([inquiryOrderItem.isMatchDrawingCloud integerValue] == 1) {
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        PurchaseProjectInfo *purchaseProjectInfo = [[PurchaseProjectInfo alloc] init];
        purchaseProjectInfo.sec_enterpriseId = _inquiryOrderHttp.member.enterpriseInfo.enterpriseId;
        purchaseProjectInfo.partNumber = inquiryOrderItem.partNumber;
        purchaseProjectInfo.picVersion = inquiryOrderItem.picVersion;
        postEntityBean.entity = purchaseProjectInfo.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        [HttpMamager postRequestWithURLString:DYZ_purchaseProject_queryDrawingLibrariesInfo parameters:dic success:^(id responseObjectModel) {
            ReturnEntityBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                PurchaseProjectInfo *purchaseProjectInfo = [PurchaseProjectInfo mj_objectWithKeyValues:model.entity];
                AccVersionInter *accVersionInter = purchaseProjectInfo.sec_foundVersion;
                NSMutableArray * arrayAccDrawingInter = [[NSMutableArray alloc] initWithCapacity:0];
                for (AccDrawingInter *acc in accVersionInter.drawings) {
                    if (![acc.previewUrl containsString:@".pdf"]) {
                        [arrayAccDrawingInter addObject:acc];
                    }
                }
                if (arrayAccDrawingInter.count == 1) {
                    LingJianXiangQingViewController2 *lingJianXiangQingViewController2 = [[LingJianXiangQingViewController2 alloc] init];
                    lingJianXiangQingViewController2.isMatchDrawingCloud = [NSNumber numberWithInteger:1];
                    lingJianXiangQingViewController2.accDrawingInter = arrayAccDrawingInter[0];
                    [self.navigationController pushViewController:lingJianXiangQingViewController2 animated:YES];
                } else {
                    LoginModel *loginModel = [DatabaseTool getLoginModel];
                    NSString *sourceCaiOrGong;
                    if ([_inquiryOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
                        sourceCaiOrGong = @"cai";
                    } else {
                        sourceCaiOrGong = @"gong";
                    }
                    PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
//                    partDetailsViewController.indexNum = 1;
                    partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
                    partDetailsViewController.enterpriseId = _inquiryOrderHttp.member.enterpriseInfo.enterpriseId;
                    partDetailsViewController.inquiryType = _inquiryOrderHttp.inquiryType;
                    partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
                    [self.navigationController pushViewController:partDetailsViewController animated:YES];
                }
            }
        } fail:^(NSError *error) {
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    } else {
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSString *sourceCaiOrGong;
        if ([_inquiryOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
            sourceCaiOrGong = @"cai";
        } else {
            sourceCaiOrGong = @"gong";
        }
        PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
//        partDetailsViewController.indexNum = 1;
        partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
        partDetailsViewController.enterpriseId = _inquiryOrderHttp.member.enterpriseInfo.enterpriseId;
        partDetailsViewController.inquiryType = _inquiryOrderHttp.inquiryType;
        partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
        [self.navigationController pushViewController:partDetailsViewController animated:YES];
    }
}

- (void)buttonDetailClick:(UIButton *)sender {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    NSString *sourceCaiOrGong;
    if ([_inquiryOrderHttp.manufacturerId isEqualToString:loginModel.manufacturerId]) {//采购商身份进来
        sourceCaiOrGong = @"cai";
    } else {
        sourceCaiOrGong = @"gong";
    }
    PartDetailsViewController *partDetailsViewController = [[PartDetailsViewController alloc] init];
    partDetailsViewController.inquiryOrderItem = _arrayInquiryOrderItemModel[sender.tag];
    partDetailsViewController.enterpriseId = _inquiryOrderHttp.member.enterpriseInfo.enterpriseId;
    partDetailsViewController.inquiryType = _inquiryOrderHttp.inquiryType;
    partDetailsViewController.sourceCaiOrGong = sourceCaiOrGong;
    
    [self.navigationController pushViewController:partDetailsViewController animated:YES];
}

- (void)buttonImportTotalMingXi:(UIButton *)sender {
    for (int i = 0; i < [_inquiryOrderHttp.tempCostDetailCount integerValue]; i++) {
        [_quotationOrderHttp setValue:[_quotationOrderHttp valueForKey:[NSString stringWithFormat:@"purchaseTempCost1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%d",i+1]];
    }
    for (int i = 0; i < [_inquiryOrderHttp.tempShipPriceDetailCount integerValue]; i++) {
        [_quotationOrderHttp setValue:[_quotationOrderHttp valueForKey:[NSString stringWithFormat:@"purchaseTempShipPrice1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%d",i+1]];
    }
    
//    for (int i = 0; i < _quotationOrderItems.count; i++) {
//        QuotationOrderItem *quotationOrderItem = _quotationOrderItems[i];
//        for (int i = 0; i < [_inquiryOrderHttp.tempPriceDetailCount integerValue]; i++) {
//            [quotationOrderItem setValue:[quotationOrderItem valueForKey:[NSString stringWithFormat:@"purchaseTempPrice1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]];
//        }
//        quotationOrderItem.price1 = quotationOrderItem.purchasePrice1;
//        [self calculateTotalPrice1MingXi];
//    }
    
    [self calculateTotalPrice1MingXi];
    
    [_tableView1 reloadData];
}

- (void)buttonImportPriceMingXi:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    QuotationOrderItem *quotationOrderItem = _quotationOrderItems[sender.tag];
    for (int i = 0; i < [_inquiryOrderHttp.tempPriceDetailCount integerValue]; i++) {
        [quotationOrderItem setValue:[quotationOrderItem valueForKey:[NSString stringWithFormat:@"purchaseTempPrice1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]];
    }
    
    quotationOrderItem.price1 = quotationOrderItem.purchasePrice1;
    [self calculateTotalPrice1MingXi];
    [_tableView1 reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        QiYeXinXiXiangQingViewController *qyxxxqVC = [[QiYeXinXiXiangQingViewController alloc] init];
        qyxxxqVC.enterpriseInfo = _inquiryOrderHttp.member.enterpriseInfo;
        qyxxxqVC.isPrivate = _inquiryOrderHttp.isPrivate;
        qyxxxqVC.ucenterId = _inquiryOrderHttp.member.ucenterId;
        qyxxxqVC.passiveId = _inquiryOrderHttp.member.manufacturerId;
        qyxxxqVC.quotationOrderStatus = _quotationOrderHttp.status;
        qyxxxqVC.caiOrGong = @"gong";
        [self.navigationController pushViewController:qyxxxqVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)buttonIndexPath00 {
    if (!_eChooseTaxRateView5Kind) {
        NSString * stringTaxRate = [NSString stringWithFormat:@"%0.f",[_quotationOrderHttp.supplierTaxRate doubleValue]*100];
        _eChooseTaxRateView5Kind = [[EChooseTaxRateView5Kind alloc] initWithFrame:self.view.frame defaultTax:stringTaxRate buttonConfirmClick:^(NSString *confirmTax) {
            double tax = [confirmTax doubleValue]/100.0;
            _quotationOrderHttp.supplierTaxRate = [NSNumber numberWithDouble:tax];
            
            if ([_inquiryOrderHttp.isQuotationTemplate integerValue] == 1) {
                [self.tableView1 reloadData];
            } else {
                [self.tableView reloadData];
            }
        }];
        [self.view addSubview:_eChooseTaxRateView5Kind];
    } else {
        _eChooseTaxRateView5Kind.hidden = NO;
    }
}

#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.tableView setContentOffset:CGPointMake(0, 10000)];
    [_tableView1 setContentOffset:CGPointMake(0, 10000)];
}

- (void)textViewDidChange:(UITextView *)textView {
    UILabel *label = [textView viewWithTag:19921125];
    if (textView.text.length > 0) {
        label.hidden = YES;
    } else {
        label.hidden = NO;
    }
    _quotationOrderHttp.remark = textView.text;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

#pragma mark UITextFieldDelegate
//键盘只能输入@"-.1234567890"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"-.1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

#pragma mark 供应商议价提交
- (IBAction)gongYingShangYiJiaCommit:(id)sender {
    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:82]]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
        return;
    }
    
    if ([_quotationOrderHttp.totalPrice1 doubleValue] <= 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"总价必须大于0"];
        return;
    }
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    
    QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
    quotationOrder.quotationOrderId = _quotationOrderHttp.quotationOrderId;
    
    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.inquiryOrderCode = _inquiryOrderHttp.inquiryOrderCode;
    
    quotationOrder.inquiryOrder = inquiryOrder;
    
    quotationOrder.verifyCode = _quotationOrderHttp.verifyCode;
    quotationOrder.inquiryOrderId = _quotationOrderHttp.inquiryOrderId;
    
    quotationOrder.targetCost1 = _quotationOrderHttp.targetCost1;
    quotationOrder.targetShipPrice1 = _quotationOrderHttp.targetShipPrice1;
    quotationOrder.targetSubtotalPrice1 = _quotationOrderHttp.targetSubtotalPrice1;
    quotationOrder.targetTotalPrice1 = _quotationOrderHttp.targetTotalPrice1;
    
    quotationOrder.purchaseCost1 = _quotationOrderHttp.purchaseCost1;
    quotationOrder.purchaseShipPrice1 = _quotationOrderHttp.purchaseShipPrice1;
    quotationOrder.purchaseSubtotalPrice1 = _quotationOrderHttp.purchaseSubtotalPrice1;
    quotationOrder.purchaseTotalPrice1 = _quotationOrderHttp.purchaseTotalPrice1;
    
    quotationOrder.cost1 = _quotationOrderHttp.cost1;
    quotationOrder.shipPrice1 = _quotationOrderHttp.shipPrice1;
    quotationOrder.subtotalPrice1 = _quotationOrderHttp.subtotalPrice1;
    quotationOrder.totalPrice1 = _quotationOrderHttp.totalPrice1;
    
    quotationOrder.supplierTaxRate = _quotationOrderHttp.supplierTaxRate;
    quotationOrder.remark = _quotationOrderHttp.remark;
    
    for (QuotationOrderItem *quotationOrderItem in _quotationOrderItems) {
        if (!quotationOrderItem.supplierDeliverTime) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择回复交期"];
            return;
        }
    }
    
    NSMutableArray *quotationOrderItems = [[NSMutableArray alloc] init];
    for (QuotationOrderItem *quotationOrderItem in _quotationOrderItems) {
        QuotationOrderItem *obj = [[QuotationOrderItem alloc] init];
        obj.quotationOrderItemId = quotationOrderItem.quotationOrderItemId;
        obj.inquiryOrderItemId = quotationOrderItem.inquiryOrderItemId;
        obj.num1 = quotationOrderItem.num1;
        obj.purchasePrice1 = quotationOrderItem.purchasePrice1;
        obj.targetPrice1 = quotationOrderItem.targetPrice1;
        obj.price1 = quotationOrderItem.price1;
        
        obj.supplierDeliverTime = quotationOrderItem.supplierDeliverTime;
        obj.supplierRemark = quotationOrderItem.supplierRemark;
        if (!quotationOrderItem.purchaseDeliverTime) {
            obj.purchaseDeliverTime = quotationOrderItem.supplierDeliverTime;
        } else {
            obj.purchaseDeliverTime = quotationOrderItem.purchaseDeliverTime;
        }
        
        if ([_inquiryOrderHttp.isQuotationTemplate integerValue] == 1) {
            for (int i = 0; i < [_inquiryOrderHttp.tempPriceDetailCount integerValue]; i++) {
                [obj setValue:[quotationOrderItem valueForKey:[NSString stringWithFormat:@"purchaseTempPrice1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"purchaseTempPrice1DetailValue%d",i+1]];//采购
                [obj setValue:[quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]];
            }
        }
        
        [quotationOrderItems addObject:obj];
    }
    
    if ([_inquiryOrderHttp.isQuotationTemplate integerValue] == 1) {
        for (int i = 0; i < [_inquiryOrderHttp.tempCostDetailCount integerValue]; i++) {
            [quotationOrder setValue:[_quotationOrderHttp valueForKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%d",i+1]];
        }
        for (int i = 0; i < [_inquiryOrderHttp.tempShipPriceDetailCount integerValue]; i++) {
            [quotationOrder setValue:[_quotationOrderHttp valueForKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%d",i+1]] forKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%d",i+1]];
        }
    }
    
    quotationOrder.quotationOrderItems = quotationOrderItems;
    
    quotationOrder.isTemporary = [NSNumber numberWithInteger:0];
    
    postEntityBean.entity = quotationOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    NSLog(@"%@",dic);
    
    BOOL isTrue = true;
    BOOL isHaveNo0 = true;
    for (QuotationOrderItem *quotationOrderItem in quotationOrderItems) {
        if ([quotationOrderItem.purchasePrice1 doubleValue] != [quotationOrderItem.price1 doubleValue]) {
            isTrue = NO;
            break;
        }
    }
    if ([quotationOrder.purchaseCost1 doubleValue] != [quotationOrder.cost1 doubleValue] || [quotationOrder.purchaseShipPrice1 doubleValue] != [quotationOrder.shipPrice1 doubleValue]) {
        isTrue = NO;
    }
    for (QuotationOrderItem *quotationOrderItem in quotationOrderItems) {
        if ([quotationOrderItem.price1 doubleValue]==0) {
            isHaveNo0 = NO;
            break;
        }
    }
    if (isTrue&&isHaveNo0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"操作提示" message:@"您已与采购商达成议价一致，提交后将不能修改报价，是否提交？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self quotationSedit:dic];
        }];
        [alertC addAction:action1];
        [alertC addAction:action2];
        [self presentViewController:alertC animated:YES completion:nil];
    } else {
        [self quotationSedit:dic];
    }
}

- (void)quotationSedit:(NSDictionary *)dic{
    
#pragma mark 供应商修改议价询盘的报价
    [HttpMamager postRequestWithURLString:DYZ_quo_special_supplier_edit parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"确认成功"];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"确认失败"];
        }
        
        [self.navigationController popViewControllerAnimated:true];
        
        //通知EGOrderViewController 刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshEGOrder" object:nil userInfo:nil];


    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

#pragma mark 总价询盘 含税单价
- (void)priceCalculation:(UITextField *)sender{
    if ([sender.text isEqualToString:@"."]) {
        sender.text = nil;
    }
    QuotationOrderItem *quotationOrderItem = _quotationOrderItems[sender.tag];
    NSArray *array1 = [sender.text componentsSeparatedByString:@"."];
    if (array1.count >= 2) {
        NSString *stringR = array1[1];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array1 firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        } else {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array1 firstObject],array1[1]];
        }
    }
    quotationOrderItem.price1 = [NSNumber numberWithDouble:[sender.text doubleValue]];
    
    [self calculateTotalPrice1];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 总价询盘 回复交期  明细询盘
- (void)textFieldPurchaseDeliverTime:(UITextField *)sender {
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeYaoQiuDaoHuoRiQi" owner:self options:nil];
    UIViewXuanZeYaoQiuDaoHuoRiQi *viewXZSJ = [nib objectAtIndex:0];
    viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewXZSJ];
    viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
        NSLog(@"%@",string);
        QuotationOrderItem *quotationOrderItem = _quotationOrderItems[sender.tag];
        quotationOrderItem.supplierDeliverTime = string;
        sender.text = [[quotationOrderItem.supplierDeliverTime componentsSeparatedByString:@" "] firstObject];
    } buttonQuXiao:^{
        [sender resignFirstResponder];
    }];
}

#pragma mark 总价询盘 零件备注  明细询盘
- (void)textFieldPurchaseRemark:(UITextField *)sender {
    QuotationOrderItem *quotationOrderItem = _quotationOrderItems[sender.tag];
    quotationOrderItem.supplierRemark = sender.text;
}

- (void)totalCost:(UITextField *)sender{
    NSLog(@"sender.tag:>>>%ld",sender.tag);
    
    if ([sender.text isEqualToString:@"."]) {
        sender.text = nil;
    }
    NSArray *array1 = [sender.text componentsSeparatedByString:@"."];
    if (array1.count >= 2) {
        NSString *stringR = array1[1];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array1 firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        } else {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array1 firstObject],array1[1]];
        }
    }
    if (sender.tag == 0) {
        _quotationOrderHttp.cost1 = [NSNumber numberWithDouble:[sender.text doubleValue]];
    }
    if (sender.tag == 1) {
        _quotationOrderHttp.shipPrice1 = [NSNumber numberWithDouble:[sender.text doubleValue]];
    }
    
    [self calculateTotalPrice1];
}

- (void)calculateTotalPrice1 {
    double totalPrice = 0;
    totalPrice = totalPrice + [_quotationOrderHttp.cost1 doubleValue] + [_quotationOrderHttp.shipPrice1 doubleValue];
    double subtotalPrice = 0;
    for (QuotationOrderItem *quotationOrderItem in _quotationOrderItems) {
        subtotalPrice = subtotalPrice + [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.price1 doubleValue];
    }
    subtotalPrice = [[NSString stringWithFormat:@"%.2f",subtotalPrice] doubleValue];
    totalPrice = totalPrice + subtotalPrice;
    _quotationOrderHttp.subtotalPrice1 = [NSNumber numberWithDouble:subtotalPrice];
    _quotationOrderHttp.totalPrice1 = [NSNumber numberWithDouble:totalPrice];
    
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1+1+2 inSection:3+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)buttonImport:(UIButton *)sender{
//    for (QuotationOrderItem *quotationOrderItem in _quotationOrderItems) {
//        quotationOrderItem.price1 = quotationOrderItem.purchasePrice1;
//    }
    _quotationOrderHttp.cost1 = _quotationOrderHttp.purchaseCost1;
    _quotationOrderHttp.shipPrice1 = _quotationOrderHttp.purchaseShipPrice1;
//    _quotationOrderHttp.subtotalPrice1 = _quotationOrderHttp.purchaseSubtotalPrice1;
//    _quotationOrderHttp.totalPrice1 = _quotationOrderHttp.purchaseTotalPrice1;
    
    [self calculateTotalPrice1];
    [self.tableView reloadData];
}

- (void)price1MingXi:(UITextField *)sender {
    NSString *string = sender.text;
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count == 2) {
        NSString *stringR = [array lastObject];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        }
    }
    
    UIView *view = sender.superview;
    NSLog(@"price1MingXi %ld %ld",view.tag,sender.tag);
    
    QuotationOrderItem *quotationOrderItem = _quotationOrderItems[view.tag];
    if (quotationOrderItem) {
        [quotationOrderItem setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%ld",sender.tag+1]];
    }
    
    double price1 = 0;
    for (int i = 0; i < [_inquiryOrderHttp.tempPriceDetailCount integerValue]; i++) {
        NSNumber *supplierTempPrice1DetailValue = [quotationOrderItem valueForKey:[NSString stringWithFormat:@"supplierTempPrice1DetailValue%d",i+1]];
        price1 = price1 + [supplierTempPrice1DetailValue doubleValue];
    }
    price1 = [[NSString stringWithFormat:@"%.2f",price1] doubleValue];
    quotationOrderItem.price1 = [NSNumber numberWithDouble:price1];
    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2+[_inquiryOrderHttp.tempPriceDetailCount integerValue] inSection:view.tag+3],[NSIndexPath indexPathForRow:2+[_inquiryOrderHttp.tempPriceDetailCount integerValue]+1 inSection:view.tag+3]] withRowAnimation:UITableViewRowAnimationNone];
    [self calculateTotalPrice1MingXi];
//    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:3+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)total1costMingXi:(UITextField *)sender {
    NSString *string = sender.text;
    NSArray *array = [string componentsSeparatedByString:@"."];
    if (array.count == 2) {
        NSString *stringR = [array lastObject];
        if (stringR.length > 2) {
            sender.text = [NSString stringWithFormat:@"%@.%@",[array firstObject],[stringR substringWithRange:NSMakeRange(0, 2)]];
        }
    }
    
    if (sender.tag < [_inquiryOrderHttp.tempCostDetailCount integerValue]) {
        [_quotationOrderHttp setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%ld",sender.tag+1]];
    } else if (sender.tag < [_inquiryOrderHttp.tempCostDetailCount integerValue]+[_inquiryOrderHttp.tempShipPriceDetailCount integerValue]) {
        [_quotationOrderHttp setValue:[NSNumber numberWithDouble:[sender.text doubleValue]] forKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%ld",sender.tag+1-[_inquiryOrderHttp.tempCostDetailCount integerValue]]];
    }
    [self calculateTotalPrice1MingXi];
}

- (void)calculateTotalPrice1MingXi {
    double totalPrice = 0;
    
    double costPrice = 0;
    for (int i = 0; i < [_inquiryOrderHttp.tempCostDetailCount integerValue]; i++) {
        NSNumber *supplierTempCost1DetailValue = [_quotationOrderHttp valueForKey:[NSString stringWithFormat:@"supplierTempCost1DetailValue%d",i+1]];
        costPrice = costPrice+[supplierTempCost1DetailValue doubleValue];
    }
    totalPrice = totalPrice + costPrice;
    _quotationOrderHttp.cost1 = [NSNumber numberWithDouble:costPrice];
    double shipPrice = 0;
    for (int i = 0; i < [_inquiryOrderHttp.tempShipPriceDetailCount integerValue]; i++) {
        NSNumber *supplierTempShipPrice1DetailValue = [_quotationOrderHttp valueForKey:[NSString stringWithFormat:@"supplierTempShipPrice1DetailValue%d",i+1]];
        shipPrice = shipPrice+[supplierTempShipPrice1DetailValue doubleValue];
    }
    totalPrice = totalPrice + shipPrice;
    _quotationOrderHttp.shipPrice1 = [NSNumber numberWithDouble:shipPrice];
    
    
    double subtotalPrice = 0;
    for (QuotationOrderItem *quotationOrderItem in _quotationOrderItems) {
        subtotalPrice = subtotalPrice + [quotationOrderItem.num1 doubleValue]*[quotationOrderItem.price1 doubleValue];
    }
    subtotalPrice = [[NSString stringWithFormat:@"%.2f",subtotalPrice] doubleValue];
    totalPrice = totalPrice + subtotalPrice;
    _quotationOrderHttp.subtotalPrice1 = [NSNumber numberWithDouble:subtotalPrice];
    
    _quotationOrderHttp.totalPrice1 = [NSNumber numberWithDouble:totalPrice];
    
//    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1+1+[_inquiryOrderHttp.tempCostDetailCount integerValue]+[_inquiryOrderHttp.tempShipPriceDetailCount integerValue] inSection:3+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];
    [_tableView1 reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:3+_quotationOrderItems.count]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)tapSelector:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 60;
        self.tableViewBottom1.constant = 60;
    } else {
        self.tableViewBottom.constant = rect.size.height;
        self.tableViewBottom1.constant = rect.size.height;
    }
}

- (void)line:(UIView *)view withY:(CGFloat)y withTag:(NSInteger)tag{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, kMainW, 0.5)];
    label.tag = tag;
    label.backgroundColor = colorLine;
    [view addSubview:label];
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 供应商查询报价详情
- (void)initRequestQuotationDetail{
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    QuotationOrder *quotationOrder = [[QuotationOrder alloc] init];
    quotationOrder.inquiryOrderId = self.inquiryOrderId;
    quotationOrder.sec_isNeedTempQuo = [NSNumber numberWithInteger:1];
    postEntityBean.entity = quotationOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_quo_supplier_detail parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            _quotationOrderItems = [[NSMutableArray alloc] init];
            _arrayInquiryOrderItemModel = [[NSMutableArray alloc] init];
            _arrayYesOpen = [[NSMutableArray alloc] initWithCapacity:0];
            
            QuotationOrder *quotationOrder =  [QuotationOrder mj_objectWithKeyValues:returnListBean.list[0]];
            for (QuotationOrderItem *quotationOrderItem in quotationOrder.quotationOrderItems) {
                [_quotationOrderItems addObject:quotationOrderItem];
                [_arrayInquiryOrderItemModel addObject:quotationOrderItem.inquiryOrderItem];
                [_arrayYesOpen addObject:@"no"];
            }
            _quotationOrderHttp = quotationOrder;
            _inquiryOrderHttp = quotationOrder.inquiryOrder;
            
            _integerButtonLineColor = [_quotationOrderHttp.dealIndex integerValue]-1;
            _viewLoading.hidden = YES;
            
            
            if ([_inquiryOrderHttp.isQuotationTemplate integerValue] == 1) {
                self.tableView.hidden = YES;
                [self.tableView1 reloadData];
            } else {
                self.tableView1.hidden = YES;
                [self.tableView reloadData];
            }
        } else {
            
        }
        
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
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