//
//  Material.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/4/15.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//模具 2020.4.15 自己添加
@interface Material : NSObject

@property (nonatomic,copy) NSString *materialCode;
@property (nonatomic,copy) NSString *materialText;

@end

NS_ASSUME_NONNULL_END
