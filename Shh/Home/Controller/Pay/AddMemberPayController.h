//
//  AddMemberPayController.h
//  Shh
//
//  Created by zhangshu on 2018/12/11.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddMemberPayController : BaseViewController
@property(nonatomic,strong)NSString *courseId;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSString *orderId;
@end

NS_ASSUME_NONNULL_END
