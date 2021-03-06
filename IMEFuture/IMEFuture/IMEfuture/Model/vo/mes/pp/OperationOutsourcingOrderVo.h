//
//  OperationOutsourcingOrderVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/28.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ImeCommonVo.h"
#import <MJExtension.h>
#import "OperationOutsourcingOrderItemVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface OperationOutsourcingOrderVo : ImeCommonVo

/**
 * 委外单编号
 */
@property (nonatomic,copy) NSString * outsourcingCode;

/**
 * 供应商编号
 */
@property (nonatomic,copy) NSString * supplierCode;

/**
 * 供应商描述
 */
@property (nonatomic,copy) NSString * supplierText;

/**
 * 出库时间
 */
@property (nonatomic,copy) NSString *outStorageDate;//Date

/**
 * 最后入库时间
 */
@property (nonatomic,copy) NSString *lastInStorageDate;//Date

/**
 * 交货日期
 */
@property (nonatomic,copy) NSString *deliveryDate;//Date

/**
 * 发货总数量
 */
@property (nonatomic,strong) NSNumber * sendQuantityTotal;//Double

/**
 * 收货总数量
 */
@property (nonatomic,strong) NSNumber * deliveryQuantityTotal;//Double

/**
 * 发货总重量
 */
@property (nonatomic,strong) NSNumber * sendWeightTotal;//Double

/**
 * 收货总重量
 */
@property (nonatomic,strong) NSNumber * deliveryWeightTotal;//Double

/**
 * 状态
 */
@property (nonatomic,strong) NSNumber * status;//Integer

/**
 * 工序委外申请单明细
 */
@property (nonatomic,strong) NSMutableArray <__kindof OperationOutsourcingOrderItemVo *>* operationOutsourcingOrderItemList;

@property (nonatomic,copy) NSString *productionControlNum;

@end

NS_ASSUME_NONNULL_END
