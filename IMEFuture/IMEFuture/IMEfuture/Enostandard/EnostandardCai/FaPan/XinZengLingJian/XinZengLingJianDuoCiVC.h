//
//  XinZengLingJianDuoCiVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/2/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InquiryOrderItem.h"

@interface XinZengLingJianDuoCiVC : UIViewController

@property (nonatomic,copy) void(^buttonBackBlock)(InquiryOrderItem *inquiryOrderItem);//保存
@property (nonatomic,copy) void(^buttonBaoCunBingJiXuTianJiaBlock)(InquiryOrderItem *inquiryOrderItem);//保存并继续添加
@property (nonatomic,copy) void(^buttonShanChuBlock)(InquiryOrderItem *inquiryOrderItem);//删除

@property (nonatomic,strong) InquiryOrderItem *inquiryOrderItem;


@property (nonatomic,assign) BOOL isZeng;

@property (nonatomic,strong) NSNumber * isPre;
@property (nonatomic,copy) NSString *inquiryType;//为定价询盘添加标识 FTG

@property (nonatomic,copy) NSString *partType;
@property (nonatomic,copy) NSString *processType;
@property (nonatomic,strong) NSNumber * supplierTaxRate;


@end
