//
//  ZuoYeDanYuanTiJiaoViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/20.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReportWorkWorkUnitScanVo;
@class WorkTimeLogVo;

@interface ZuoYeDanYuanTiJiaoViewController : UIViewController

@property (nonatomic,copy) NSString * productionControlNum;
@property (nonatomic,copy) NSString * processOperationId;
@property (nonatomic,copy) NSString * confirmFlag;
@property (nonatomic,copy) NSString * workUnitText;
@property (nonatomic,copy) NSString * operationText;
@property (nonatomic,copy) NSString * operationTextNext;
@property (nonatomic,strong) NSNumber * planTime;//Double

@property (nonatomic,strong) NSNumber * workTime;//Long
@property (nonatomic,strong) NSNumber * unfinishedQuantity;//Double
@property (nonatomic,copy) NSString * operationCode;
@property (nonatomic,copy) NSString * workUnitCode;
@property (nonatomic,copy) NSString * confirmUser;
@property (nonatomic,strong) NSNumber * status;//int
@property (nonatomic,strong) NSString * actualendDateTime;//Date
@property (nonatomic,strong) NSNumber * logId;//Long

@property (nonatomic,copy) NSString *productionOrderNum;
@property (nonatomic,copy) NSString * requirementDate;
@property (nonatomic,copy) NSString *personnelName;

@property (nonatomic,strong) NSNumber * completionMode;//Integer
@end
