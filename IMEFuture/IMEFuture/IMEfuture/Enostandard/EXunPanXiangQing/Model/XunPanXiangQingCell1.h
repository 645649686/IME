//
//  XunPanXiangQingCell1.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InquiryOrderItem.h"

@interface XunPanXiangQingCell1 : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *sec_thumbnailUrl;

@property (weak, nonatomic) IBOutlet UIButton *sec_thumbnailUrlBtn;

- (void)initDate:(InquiryOrderItem *)model with:(NSIndexPath *)indexPath isPurchaser:(BOOL)yes;

@end
