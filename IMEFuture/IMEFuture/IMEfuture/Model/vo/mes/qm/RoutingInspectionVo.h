//
//  RoutingInspectionVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/9.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CauseDetailVo.h"

@class ProcessOperationVo;

@interface RoutingInspectionVo : NSObject

/**
 * 工厂编号
 */
@property (nonatomic, copy) NSString * siteCode;

/**
 * 生产作业号
 */
@property (nonatomic, copy) NSString * productionControlNum;

/**
 * 生产订单号
 */
@property (nonatomic, copy) NSString * productionOrderNum;

/**
 * 作业单元号
 */
@property (nonatomic, copy) NSString * workUnitCode;

/**
 * 作业单元描述
 */
@property (nonatomic, copy) NSString * workUnitText;

/**
 * 工艺工序id
 */
@property (nonatomic, strong) NSNumber * processOperationId;//Long

/**
 * 工艺编号
 */
@property (nonatomic, copy) NSString * processCode;

/**
 * 工艺版本
 */
@property (nonatomic, copy) NSString * processRev;

/**
 * 物料编号
 */
@property (nonatomic, copy) NSString * materialCode;

/**
 * 物料描述
 */
@property (nonatomic, copy) NSString * materialText;

/**
 * 工序编号
 */
@property (nonatomic, copy) NSString * operationCode;

/**
 * 工序描述
 */
@property (nonatomic, copy) NSString * operationText;

/**
 * 下达数量
 */
@property (nonatomic, strong) NSNumber * controlQuantity;//Double

/**
 * 合格数量
 */
@property (nonatomic, strong) NSNumber * qualifiedQuantity;//Double

/**
 * 报废数量
 */
@property (nonatomic, strong) NSNumber * scrapQuantity;//Double

/**
 * 巡检日期
 */
@property (nonatomic, copy) NSString * routingDate;//Date

/**
 * 客户编号
 */
@property (nonatomic, copy) NSString * customerCode;

/**
 * 客户名称
 */
@property (nonatomic, copy) NSString * customerText;

/**
 * 项目编号
 */
@property (nonatomic, copy) NSString * projectNum;

/**
 * 项目名称
 */
@property (nonatomic, copy) NSString * projectName;


/**
 * 是否返修
 */
@property (nonatomic, strong) NSNumber * isRepairFlag;//Integer

/**
 * 巡检人编号
 */
@property (nonatomic, copy) NSString * routingUserCode;

/**
 * 巡检人名称
 */
@property (nonatomic, copy) NSString * routingUserText;

/**
 * 巡检完成数
 */
@property (nonatomic, strong) NSNumber * routingCompletedQuantity;//Double

/**
 * 巡检报废数
 */
@property (nonatomic, strong) NSNumber * routingScrapQuantity;//Double

/**
 * 巡检数
 */
@property (nonatomic, strong) NSNumber * routingQuantity;//Double

/**
 * 图号
 */
@property (nonatomic, copy) NSString * figureNum;

/**
 * 交期
 */
@property (nonatomic, copy) NSString *requirementDate;//Date

/**
 * 开始时间
 */
@property (nonatomic, copy) NSString *startDate;//Date

/**
 * 结束时间
 */
@property (nonatomic, copy) NSString * endDate;//Date

/**
 * 巡检查询
 */
@property (nonatomic, copy) NSString * routingQueryText;

/**
 * 零件版本 id
 */
@property (nonatomic, copy) NSString * partsVersionId;
@property (nonatomic, strong) NSMutableArray <__kindof ProcessOperationVo *> * processOperationVoList;

@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * causeList;

@property (nonatomic, strong) NSMutableArray <__kindof CauseDetailVo *>*scrappedCauseDetailVos;

@end
