//
//  SignUpService.h
//  Shh
//
//  Created by zhangshu on 2018/12/27.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseModelReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignUpService : BaseModelReq
///
@property(nonatomic,copy)NSString *siheserviceFormContent;
///
@property(nonatomic,copy)NSString *siheserviceFormName;
///
@property(nonatomic,copy)NSString *siheserviceFormPhone;
///
@property(nonatomic,copy)NSString *siheserviceId;
@end

NS_ASSUME_NONNULL_END
