//
//  QuotationOrder.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class InquiryOrder;
@class Member;
@class QuotationOrderItem;
//#import "InquiryOrder.h"
//#import "Member.h"
//#import "QuotationOrderItem.h"

@interface QuotationOrder : BaseEntity


/**
 * 主键
 */
@property (nonatomic,copy) NSString * quotationOrderId;
/**
 * 提交报价单的用户
 */
@property (nonatomic,strong) Member *member;
/**
 * 报价的询盘单
 */
@property (nonatomic,strong) InquiryOrder *inquiryOrder;
/**
 * 报价的询盘单Id
 */
@property (nonatomic,copy) NSString * inquiryOrderId;
/**
 * 询盘订单项
 */
@property (nonatomic,strong) NSMutableArray <__kindof QuotationOrderItem *> *quotationOrderItems;//QuotationOrderItem对象
/**
 * 第一报价小计(供应商报价)
 */
@property (nonatomic,strong) NSNumber *subtotalPrice1;//BigDecimal
/**
 * 第一报价总计(供应商报价)
 */
@property (nonatomic,strong) NSNumber *totalPrice1;//BigDecimal
/**
 * 第一报价小计(采购商报价)
 */
@property (nonatomic,strong) NSNumber *purchaseSubtotalPrice1;//BigDecimal
/**
 * 第一报价总计(采购商报价)
 */
@property (nonatomic,strong) NSNumber *purchaseTotalPrice1;//BigDecimal
/**
 * 是否使用了报价模板
 */
@property (nonatomic,strong) NSNumber * isQuotationTemplate;//Integer
/**
 * 报价模板Id
 */
@property (nonatomic,copy) NSString * quotationTemplateId;
/**
 * 报价模板的名称
 */
@property (nonatomic,copy) NSString * quotationTemplateName;
/**
 * 模板类型
 */
@property (nonatomic,strong) NSNumber * templateType;//Integer
/**
 * 是否是临时用户生成的报价单
 */
@property (nonatomic,strong) NSNumber * isTemporary;//Integer
/**
 * 供应商税率
 */
@property (nonatomic,strong) NSNumber *supplierTaxRate;//Double
/**
 * 提交报价单的企业Id
 */
@property (nonatomic,copy) NSString * manufacturerId;
/**
 * 是否可以修改价格
 */
@property (nonatomic,strong) NSNumber * canEditPrice;//Integer
/**
 * 创建时间
 */
@property (nonatomic,copy) NSString * createTime;//Date
/**
 * 是否需要暂存报价
 */
@property (nonatomic,strong) NSNumber * sec_isNeedTempQuo;//Integer
/**
 * 暂存报价ID
 */
@property (nonatomic,copy) NSString * sec_tempQuotationOrderId;

//是否是比较授盘
@property (nonatomic,strong) NSNumber * sec_isDesignated;//Integer

@property (nonatomic,copy) NSString *sec_tradeOrderTime;


















/**
 * 报价单状态
 */
@property (nonatomic,copy) NSString *status;

/**
 * 提交报价单的用户Id
 */
@property (nonatomic,copy) NSString *memberId;

/**
 * 第一报价杂费
 */
@property (nonatomic,strong) NSNumber *cost1;//double

/**
 * 第一报价运费
 */
@property (nonatomic,strong) NSNumber *shipPrice1;//double


/**
 * 第一报价杂费(采购商目标价)
 */
@property (nonatomic,strong) NSNumber * targetCost1;//double

/**
 * 第一报价运费(采购商目标价)
 */
@property (nonatomic,strong) NSNumber *targetShipPrice1;//double

/**
 * 第一报价小计(采购商目标价)
 */
@property (nonatomic,strong) NSNumber *targetSubtotalPrice1;//double

/**
 * 第一报价总计(采购商目标价)
 */
@property (nonatomic,strong) NSNumber *targetTotalPrice1;//double

/**
 * 第一报价杂费(采购商报价)
 */
@property (nonatomic,strong) NSNumber *purchaseCost1;//double

/**
 * 第一报价运费(采购商报价)
 */
@property (nonatomic,strong) NSNumber * purchaseShipPrice1;//double


/**
 * 报价模板运费明细的总计数量
 */
@property (nonatomic,strong) NSNumber * tempShipPriceDetailCount;//Integer

/**
 * 报价模板杂费明细的总计数量
 */
@property (nonatomic,strong) NSNumber * tempCostDetailCount;//Integer

/**
 * 第一报价的报价模板运费明细值1(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice1DetailValue1;//BigDecimal

/**
 * 第一报价的报价模板运费明细值2(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice1DetailValue2;//BigDecimal

/**
 * 第一报价的报价模板运费明细值3(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice1DetailValue3;//BigDecimal

/**
 * 第一报价的报价模板运费明细值4(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice1DetailValue4;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值1(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost1DetailValue1;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值2(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost1DetailValue2;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值3(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost1DetailValue3;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值4(供应商)
 */
@property (nonatomic,strong) NSNumber * supplierTempCost1DetailValue4;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值5(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost1DetailValue5;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值6(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost1DetailValue6;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值7(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost1DetailValue7;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值8(供应商)
 */
@property (nonatomic,strong) NSNumber * supplierTempCost1DetailValue8;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值9(供应商)
 */
@property (nonatomic,strong) NSNumber * supplierTempCost1DetailValue9;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值10(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost1DetailValue10;//BigDecimal

/**
 * 第二报价的报价模板运费明细值1(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice2DetailValue1;//BigDecimal

/**
 * 第二报价的报价模板运费明细值2(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice2DetailValue2;//BigDecimal

/**
 * 第二报价的报价模板运费明细值3(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice2DetailValue3;//BigDecimal

/**
 * 第二报价的报价模板运费明细值4(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice2DetailValue4;//BigDecimal

/**
 * 第二报价的报价模板杂费明细值1(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost2DetailValue1;//BigDecimal

/**
 * 第二报价的报价模板杂费明细值2(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost2DetailValue2;//BigDecimal

/**
 * 第二报价的报价模板杂费明细值3(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost2DetailValue3;//BigDecimal

/**
 * 第二报价的报价模板杂费明细值4(供应商)
 */
@property (nonatomic,strong) NSNumber * supplierTempCost2DetailValue4;//BigDecimal

/**
 * 第二报价的报价模板杂费明细值5(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost2DetailValue5;//BigDecimal

/**
 * 第二报价的报价模板杂费明细值6(供应商)
 */
@property (nonatomic,strong) NSNumber * supplierTempCost2DetailValue6;//BigDecimal

/**
 * 第二报价的报价模板杂费明细值7(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost2DetailValue7;//BigDecimal

/**
 * 第二报价的报价模板杂费明细值8(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost2DetailValue8;//BigDecimal

/**
 * 第二报价的报价模板杂费明细值9(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost2DetailValue9;//BigDecimal

/**
 * 第二报价的报价模板杂费明细值10(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost2DetailValue10;//BigDecimal

/**
 * 第三报价的报价模板运费明细值1(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice3DetailValue1;//BigDecimal

/**
 * 第三报价的报价模板运费明细值2(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice3DetailValue2;//BigDecimal

/**
 * 第三报价的报价模板运费明细值3(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice3DetailValue3;//BigDecimal

/**
 * 第三报价的报价模板运费明细值4(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempShipPrice3DetailValue4;//BigDecimal

/**
 * 第三报价的报价模板杂费明细值1(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost3DetailValue1;//BigDecimal

/**
 * 第三报价的报价模板杂费明细值2(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost3DetailValue2;//BigDecimal

/**
 * 第三报价的报价模板杂费明细值3(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost3DetailValue3;//BigDecimal

/**
 * 第三报价的报价模板杂费明细值4(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost3DetailValue4;//BigDecimal

/**
 * 第三报价的报价模板杂费明细值5(供应商)
 */
@property (nonatomic,strong) NSNumber * supplierTempCost3DetailValue5;//BigDecimal

/**
 * 第三报价的报价模板杂费明细值6(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost3DetailValue6;//BigDecimal

/**
 * 第三报价的报价模板杂费明细值7(供应商)
 */
@property (nonatomic,strong) NSNumber * supplierTempCost3DetailValue7;//BigDecimal

/**
 * 第三报价的报价模板杂费明细值8(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost3DetailValue8;//BigDecimal

/**
 * 第三报价的报价模板杂费明细值9(供应商)
 */
@property (nonatomic,strong) NSNumber *  supplierTempCost3DetailValue9;//BigDecimal

/**
 * 第三报价的报价模板杂费明细值10(供应商)
 */
@property (nonatomic,strong) NSNumber * supplierTempCost3DetailValue10;//BigDecimal

/**
 * 第一报价的报价模板运费明细值1(采购商)
 */
@property (nonatomic,strong) NSNumber * purchaseTempShipPrice1DetailValue1;//BigDecimal

/**
 * 第一报价的报价模板运费明细值2(采购商)
 */
@property (nonatomic,strong) NSNumber *  purchaseTempShipPrice1DetailValue2;//BigDecimal

/**
 * 第一报价的报价模板运费明细值3(采购商)
 */
@property (nonatomic,strong) NSNumber * purchaseTempShipPrice1DetailValue3;//BigDecimal

/**
 * 第一报价的报价模板运费明细值4(采购商)
 */
@property (nonatomic,strong) NSNumber *  purchaseTempShipPrice1DetailValue4;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值1(采购商)
 */
@property (nonatomic,strong) NSNumber *  purchaseTempCost1DetailValue1;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值2(采购商)
 */
@property (nonatomic,strong) NSNumber * purchaseTempCost1DetailValue2;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值3(采购商)
 */
@property (nonatomic,strong) NSNumber *  purchaseTempCost1DetailValue3;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值4(采购商)
 */
@property (nonatomic,strong) NSNumber *  purchaseTempCost1DetailValue4;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值5(采购商)
 */
@property (nonatomic,strong) NSNumber *  purchaseTempCost1DetailValue5;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值6(采购商)
 */
@property (nonatomic,strong) NSNumber *  purchaseTempCost1DetailValue6;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值7(采购商)
 */
@property (nonatomic,strong) NSNumber *  purchaseTempCost1DetailValue7;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值8(采购商)
 */
@property (nonatomic,strong) NSNumber *  purchaseTempCost1DetailValue8;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值9(采购商)
 */
@property (nonatomic,strong) NSNumber *  purchaseTempCost1DetailValue9;//BigDecimal

/**
 * 第一报价的报价模板杂费明细值10(采购商)
 */
@property (nonatomic,strong) NSNumber *  purchaseTempCost1DetailValue10;//BigDecimal

/**
 * 报价单的合并状态
 * 0-无需合并；2-待合并；1-已合并
 */
@property (nonatomic,strong) NSNumber *mergeStatus;//Integer
//--------------- 20170524无注册流程 end ------------------

/**
 * 第二报价杂费
 */
@property (nonatomic,strong) NSNumber *cost2;//double

/**
 * 第二报价运费
 */
@property (nonatomic,strong) NSNumber *shipPrice2;//double

/**
 * 第二报价小计
 */
@property (nonatomic,strong) NSNumber *subtotalPrice2;//double

/**
 * 第二报价总计
 */
@property (nonatomic,strong) NSNumber *totalPrice2;//double

/**
 * 第三报价杂费
 */
@property (nonatomic,strong) NSNumber *cost3;//double

/**
 * 第三报价运费
 */
@property (nonatomic,strong) NSNumber *shipPrice3;//double

/**
 * 第三报价小计
 */
@property (nonatomic,strong) NSNumber *subtotalPrice3;//double

/**
 * 第三报价总计
 */
@property (nonatomic,strong) NSNumber *totalPrice3;//double

/**
* 成交报价序号
*/
@property (nonatomic,strong) NSNumber *dealIndex;//Integer

/**
 * 修改时间
 */
@property (nonatomic,copy) NSString *editTm;//Date

/**
 * 修改人
 */
@property (nonatomic,copy) NSString *editName;

/**
 * 修改人Id
 */
@property (nonatomic,copy) NSString *editId;

/**
 * 审核时间
 */
@property (nonatomic,copy) NSString *confirmTm;//Date

/**
 * 审核人
 */
@property (nonatomic,copy) NSString *confirmName;

/**
 * 审核人Id
 */
@property (nonatomic,copy) NSString *confirmId;

/**
 * 审核意见
 */
@property (nonatomic,copy) NSString *confirmMsg;

/**
 * 拒绝时间
 */
@property (nonatomic,copy) NSString *refuseTm;//Date

/**
 * 拒绝人
 */
@property (nonatomic,copy) NSString *refuseName;

/**
 * 拒绝人Id
 */
@property (nonatomic,copy) NSString *refuseId;

/**
 * 拒绝意见
 */
@property (nonatomic,copy) NSString *refuseMsg;

/**
 * 接盘时间
 */
@property (nonatomic,copy) NSString *acceptTm;//Date

/**
 * 接盘人
 */
@property (nonatomic,copy) NSString *acceptName;

/**
 * 接盘Id
 */
@property (nonatomic,copy) NSString *acceptId;

/**
 * 供应商备注
 */
@property (nonatomic,copy) NSString *remark;

/**
 * 采购商备注
 */
@property (nonatomic,copy) NSString *purchaseRemark;

/**
 * 供应商附加费备注
 */
@property (nonatomic,copy) NSString * supplierSurchargeRemark;

/**
 * 采购商附加费备注
 */
@property (nonatomic,copy) NSString * purchaseSurchargeRemark;

/**
 * 修改次数
 */
@property (nonatomic,strong) NSNumber *editNum;//Integer

/**
 * 数据安全验证码
 */
@property (nonatomic,copy) NSString *verifyCode;

/**
 * 采购商是否已读该报价
 */
@property (nonatomic,strong) NSNumber *isRead;//Integer

/**
 * 是否是供应商新报价
 * 0-否；1-是；
 */
@property (nonatomic,strong) NSNumber * isNewQuo;//Integer

/**
 * 供应商佣金
 * 0.01-0.99
 */
@property (nonatomic,strong) NSNumber *supplierCommision;//Double

/**
 * 供应商账期
 */
@property (nonatomic,strong) NSNumber *supplierAccountPeriod;//Integer
//------161018税率托管相关---------------

//------161130报价历史相关---------------
/**
 * 是否是日志记录
 */
@property (nonatomic,strong) NSNumber *isLog;//Integer

/**
 * 是否填写过核价(指定价)报价时的备注
 */
@property (nonatomic,strong) NSNumber * hasDesignatedRemark;//Integer

/**
 * 核价(指定价)报价时的备注
 */
@property (nonatomic,copy) NSString * designatedRemark;

/**
 * 是否是预授盘
 * 1-是；null 和 0 - 否；
 */
@property (nonatomic,strong) NSNumber *isPrepare;//Integer

/**
 * 日志记录序列
 */
@property (nonatomic,strong) NSNumber *logIndex;//Integer

/**
 * 关联报价单ID
 */
@property (nonatomic,copy) NSString * linkQuotationOrderId;

/**
 * 最初的报价ID
 * isLog为0的那条原始记录的ID
 */
@property (nonatomic,copy) NSString * initialQuotationOrderId;
//------161130报价历史相关---------------

/**
 * 文件别名（上传时的文件名称）
 */
@property (nonatomic,copy) NSString * fileName;

/**
 * 文件的真名
 */
@property (nonatomic,copy) NSString * fileRealName;

/**
 * 文件路径（全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径）
 */
@property (nonatomic,copy) NSString * filePath;

/**
 * OSS存储空间名称
 */
@property (nonatomic,copy) NSString * fileBucketName;

/**
 * 文件ID
 */
@property (nonatomic,copy) NSString * fileId;

/**
 * 查询供应商等级
 */
@property (nonatomic,strong) NSNumber *seb_qe__suStartLevel;//Double

/**
 * 查询供应商等级
 */
@property (nonatomic,strong) NSNumber *see_qe__suStartLevel;//Double

/**
 * 查询供应商员工数大于此值
 */
@property (nonatomic,copy) NSString *seb_qe__employeeNum;

/**
 * 查询供应商员工数小于此值
 */
@property (nonatomic,copy) NSString *see_qe__employeeNum;

/**
 * 查询供应商省份
 */
@property (nonatomic,copy) NSString *qe__province;

/**
 * 查询供应商市
 */
@property (nonatomic,copy) NSString *qe__city;

/**
 * 查询供应商资质认证
 */
@property (nonatomic,copy) NSString *qe__renzheng;

/**
 * 查询供应商是否开启透明工厂
 */
@property (nonatomic,strong) NSNumber *qe__hasTrFactory;//Integer

/**
 * 查询供应商进出口
 */
@property (nonatomic,strong) NSNumber *qe__hasIEPower;//Integer

/**
 * 查询符合多个报价单ID的报价单
 */
@property (nonatomic,strong) NSMutableArray *sei_quotationOrderId;//@property (nonatomic,copy) NSString *[] sei_quotationOrderId;

/**
 * 查询某个询盘单的企业Id
 */
@property (nonatomic,copy) NSString *im__manufacturerId;

/**
 * 查询某个报价单的企业Id
 */
@property (nonatomic,copy) NSString *qm__manufacturerId;

/**
 * 传输企业关注数据
 */
@property (nonatomic,strong) NSNumber *sec_a;//Integer

/**
 * 传输企业交易过数据
 */
@property (nonatomic,strong) NSNumber *sec_t;//Integer

/**
 * 传输企业黑名单数据
 */
@property (nonatomic,strong) NSNumber *sec_b;//Integer

/**
 * 查询某供应商自己和被授盘的报价实体
 */
@property (nonatomic,copy) NSString *sec_successManufacturerId;

/**
 * 查询标题或单号
 */
@property (nonatomic,copy) NSString *sec_titleOrTradeCode;

/**
 * 搜索超时时间大于
 */
@property (nonatomic,copy) NSString *seb_i__endTm;//Date

/**
 * 搜索超时时间小于
 */
@property (nonatomic,copy) NSString *see_i__endTm;//Date

/**
 * 搜索询盘类型
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> *sei_i__inquiryType;//InquiryType 枚举

/**
 * 搜索询盘单ID
 */
@property (nonatomic,copy) NSString *i__inquiryOrderId;

/**
 * 搜索是否是推荐的询盘
 */
@property (nonatomic,strong) NSNumber *se__i_recommendIndex;//Integer

/**
 * 搜索符合多个状态的报价单
 * (不考虑超时状态)
 */
@property (nonatomic,strong) NSMutableArray *sei_status;//private QuotationOrderStatus [] sei_status;

/**
 * 搜索符合多个状态的报价单
 * (考虑超时状态,超时的不显示)
 */
@property (nonatomic,strong) NSMutableArray *sec_orStatus;//private QuotationOrderStatus [] sec_orStatus;

/**
 * 临时保存订单统计值
 */
@property (nonatomic,strong) NSNumber *sec_statusCount;//Long

/**
 * 搜索多个报价企业在uc中的ID
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_qe__enterpriseId;

/**
 * 展示动态的标题
 */
@property (nonatomic,copy) NSString * sec_dtTitle;

/**
 * 展示动态的公司名
 */
@property (nonatomic,copy) NSString * sec_dtEpName;

/**
 * 展示动态的链接名
 */
@property (nonatomic,copy) NSString * sec_dtLinkName;

/**
 * 展示动态的链接名
 */
@property (nonatomic,copy) NSString * sec_dtTitleColor;

/**
 * 采购商是否测试账号
 */
@property (nonatomic,strong) NSNumber * ie__isTestAccount;//Integer

/**
 * 供应商是否测试账号
 */
@property (nonatomic,strong) NSNumber * qe__isTestAccount;//Integer

/**
 * 议价询盘采购已报价
 */
@property (nonatomic,strong) NSNumber * purchaseHasQued;//Integer

/**
 * 议价询盘供应商已报价
 */
@property (nonatomic,strong) NSNumber *supplierHasQued;//Integer

@end
