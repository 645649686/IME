//
//  InquiryOrderItem.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class InquiryOrder;
@class InquiryOrderItemFile;
#import "BatchDeliverItem.h"

@interface InquiryOrderItem : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * inquiryOrderItemId;
/**
 * 询盘明细状态
 */
@property (nonatomic,copy) NSString * inquiryOrderItemStatus;//NSString InquiryOrderItemStatus
/**
 * 询盘明细状态
 */
@property (nonatomic,copy) NSString * inquiryOrderItemStatusDesc;
/**
 * 被授单的企业ID
 */
@property (nonatomic,copy) NSString * sendManufacturerId;
/**
 * 生产批次
 */
@property (nonatomic,copy) NSString * productionBatch;
/**
 * 生产批次序号
 */
@property (nonatomic,copy) NSString * batchIndex;
/**
 * 授盘人
 */
@property (nonatomic,copy) NSString * sendName;
/**
 * 零件名称
 */
@property (nonatomic,copy) NSString * partName;
/**
 * 行号
 */
@property (nonatomic,strong) NSNumber * lineNumber;//Integer
/**
 * 发货时间
 */
@property (nonatomic,copy) NSString * deliveryTime;//Date
/**
 * 品牌
 */
@property (nonatomic,copy) NSString * brand;
/**
 * 一级材质名称
 */
@property (nonatomic,copy) NSString * materialName1;
/**
 * 一级材质ID
 */
@property (nonatomic,copy) NSString * materialId1;
/**
 * 二级材质名称
 */
@property (nonatomic,copy) NSString * materialName2;
/**
 * 二级材质ID
 */
@property (nonatomic,copy) NSString * materialId2;
/**
 * 工艺
 * 以.工艺名.分割
 */
@property (nonatomic,copy) NSString * tags;
/**
 * 第一报价数量
 */
@property (nonatomic,strong) NSNumber * num1;//BigDecimal
/**
 * 第一报价目标单价
 */
@property (nonatomic,strong) NSNumber * price1;//BigDecimal
/**
 * 订单成交价
 */
@property (nonatomic,strong) NSNumber * price;//BigDecimal
/**
 * 最小单位
 */
@property (nonatomic,copy) NSString * quantityUnit;
/**
 * 最小单位描述
 */
@property (nonatomic,copy) NSString * quantityUnitDesc;
/**
 * 清单采购说明
 */
@property (nonatomic,copy) NSString * purchaseDes;
/**
 * 物料号
 */
@property (nonatomic,copy) NSString * materialNumber;
/**
 * 是否匹配图纸云
 */
@property (nonatomic,strong) NSNumber * isMatchDrawingCloud;//Integer
/**
 * 零件号
 */
@property (nonatomic,copy) NSString * partNumber;
/**
 * 所属项目名(erp或图纸云)
 */
@property (nonatomic,copy) NSString * ownProjectName;
/**
 * 物料描述
 */
@property (nonatomic,copy) NSString * materialDescription;





















/**
 * 询盘订单
 */
@property (nonatomic,strong) InquiryOrder *inquiryOrder;

/**
 * 询盘订单ID
 */
@property (nonatomic,copy) NSString *inquiryOrderId;

/**
 * 图纸文件
 */
@property (nonatomic,strong) NSMutableArray <__kindof InquiryOrderItemFile *> *inquiryOrderItemFiles;

/**
 * 内部编码
 */
@property (nonatomic,copy) NSString *insideCode;

/**
 * 是否无图纸(既无普通上传的图纸也未对接图纸云)
 */
@property (nonatomic,strong) NSNumber *hasNoPic;//Integer

/**
 * 形状
 */
@property (nonatomic,copy) NSString *shape;

/**
 * 规格
 */
@property (nonatomic,copy) NSString *specifications;

/**
 * 材料牌号
 */
@property (nonatomic,copy) NSString * materialNo;

/**
 * 长
 */
@property (nonatomic,strong) NSNumber *length;//Double

/**
 * 宽
 */
@property (nonatomic,strong) NSNumber *width;//Double

/**
 * 高
 */
@property (nonatomic,strong) NSNumber *height;//Double

/**
 * 净重
 */
@property (nonatomic,strong) NSNumber *suttle;//Double

/**
 * 尺寸单位
 */
@property (nonatomic,copy) NSString *sizeUnit;//A("英寸"),B("毫米");

/**
 * 目标价供应商是否可见
 */
@property (nonatomic,strong) NSNumber *isVisiblePrice;//Integer
//------170224 两种议价托管 end -------------

/**
 * 描述
 */
@property (nonatomic,copy) NSString *detail;

/**
 * 年采购量
 */
@property (nonatomic,strong) NSNumber *purchaseNum;//Double

/**
 * 文件别名（上传时的文件名称）
 */
@property (nonatomic,copy) NSString *fileName;

/**
 * 文件的真名
 */
@property (nonatomic,copy) NSString *fileRealName;

/**
 * 文件路径（全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径）
 */
@property (nonatomic,copy) NSString *filePath;

/**
 * OSS存储空间名称
 */
@property (nonatomic,copy) NSString *fileBucketName;

/**
 * 文件ID
 */
@property (nonatomic,copy) NSString *fileId;

/**
 * 图纸版本
 */
@property (nonatomic,copy) NSString * picVersion;

/**
 * 图号
 */
@property (nonatomic,copy) NSString * figureNo;

/**
 * 图纸云零件ID
 */
@property (nonatomic,copy) NSString * partId;

/**
 * 用户多次发货详情
 */
@property (nonatomic,copy) NSString * batchDeliverItem;

/**
 * 预发货批次数
 */
@property (nonatomic,strong) NSNumber * batchDeliverNum;//Integer

/**
 * 用户定制的工艺
 * 以.工艺名.分割
 */
@property (nonatomic,copy) NSString * customTags;

/**
 * 采购需求单明细的ID(非标)
 */
@property (nonatomic,copy) NSString * projectInfoId;

/**
 * 图纸云bom零件主键(图纸云)
 */
@property (nonatomic,copy) NSString * bomAccId;

/**
 * 采购申请类型(erp或图纸云)
 */
@property (nonatomic,copy) NSString * applyType;

/**
 * 采购申请号(erp或者图纸云，但是图纸云允许为空)
 */
@property (nonatomic,copy) NSString * applyNumber;

/**
 * 采购需求单明细的行号(erp)
 */
@property (nonatomic,strong) NSNumber * lineNum;//Integer

/**
 * 来源
 */
@property (nonatomic,copy) NSString * source;//PartSourceType

/**
 * 物料组
 */
@property (nonatomic,copy) NSString * materialGroup;

/**
 * 处理状态
 */
@property (nonatomic,copy) NSString * processingStatus;
/**
 * 审批标识
 */
@property (nonatomic,copy) NSString * approvalLabel;
/**
 * 审批状态
 */
@property (nonatomic,copy) NSString * approvalStatus;
/**
 * 成本中心
 */
@property (nonatomic,copy) NSString * costCenter;
/**
 * 结算标识
 */
@property (nonatomic,copy) NSString * settlementIdentifier;
/**
 * 联系人/电话
 */
@property (nonatomic,copy) NSString * linkMan;
/**
 * 工厂
 */
@property (nonatomic,copy) NSString * factory;
/**
 * 库存地点
 */
@property (nonatomic,copy) NSString * inventoryLocation;
/*---------ERP对接新增字段end---------*/

@property (nonatomic,strong) NSMutableArray * sei_inquiryOrderId;//private String [] sei_inquiryOrderId;

/**
 * 查询询盘单号
 */
@property (nonatomic,copy) NSString *se_i__inquiryOrderId;

@property (nonatomic,copy) NSString *i__manufacturerId;

@property (nonatomic,copy) NSString * i__inquiryType;//InquiryType

/**
 * 缩略图临时存储字段
 */
@property (nonatomic,copy) NSString *sec_thumbnailUrl;

/**
 * 查询多个采购项目明细的ID
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_projectInfoId;//String[]

/**
 * 回填采购项目明细的ID
 */
@property (nonatomic,copy) NSString *sec_projectInfoId;


@property (nonatomic,copy) NSString *partType;

@property (nonatomic,copy) NSString * processType;

@property (nonatomic,strong) NSNumber * supplierTaxRate;


/**
 * 批量发货明细原始数据
 * (前端传递的)
 */
@property (nonatomic,strong) NSMutableArray <__kindof BatchDeliverItem *>* sec_batchDeliverItem;
@end
