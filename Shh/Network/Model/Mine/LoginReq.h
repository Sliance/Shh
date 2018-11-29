//
//  LoginReq.h
//  Shh
//
//  Created by zhangshu on 2018/11/28.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseModelReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginReq : BaseModelReq
///
@property(nonatomic,copy)NSString *memberTel;
///
@property(nonatomic,copy)NSString *memberPassword;
///
@property(nonatomic,copy)NSString *invitationCode;
///
@property(nonatomic,copy)NSString *memberName;
///
@property(nonatomic,copy)NSString *smsCaptchaCode;
///
@property(nonatomic,strong)NSString * newsPassword;
///
@property(nonatomic,copy)NSString *reNewPassword;


@end

NS_ASSUME_NONNULL_END
