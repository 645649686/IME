//
//  ShutDownCauseVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/21.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShutDownCauseVo : NSObject

/**
 * 工厂编号
 */
@property (nonatomic,copy) NSString * siteCode;

/**
 * 停机原因代码
 */
@property (nonatomic,copy) NSString * shutDownCauseCode;

/**
 *  停机原因描述
 */
@property (nonatomic,copy) NSString * shutDownCauseText;

/**
 * 锁定标志
 */
@property (nonatomic,strong) NSNumber * lockFlag;//Integer


@property (nonatomic, copy) NSString * operationCode;

@end
