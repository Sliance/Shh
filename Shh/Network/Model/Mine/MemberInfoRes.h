//
//  MemberInfoRes.h
//  Shh
//
//  Created by zhangshu on 2018/12/6.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseModelReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberInfoRes : BaseModelReq
///
@property(nonatomic,copy)NSString *city;
///
@property(nonatomic,copy)NSString *jobTitle;
///
@property(nonatomic,copy)NSString *companyName;
///
@property(nonatomic,copy)NSString *memberName;
///
@property(nonatomic,copy)NSString *reNewPassword;
///
@property(nonatomic,copy)NSString *systemVersion;
///
@property(nonatomic,copy)NSString *industryType;
///
@property(nonatomic,copy)NSString *province;
///
@property(nonatomic,copy)NSString *parentInvitationMemberId;
///
@property(nonatomic,copy)NSString *invitationCode;
///
@property(nonatomic,copy)NSString *memberId;
///
@property(nonatomic,copy)NSString *wechatNo;
///
@property(nonatomic,copy)NSString *tencentNo;
///
@property(nonatomic,copy)NSString *memberAvatarPath;
///
@property(nonatomic,copy)NSString *memberTel;
///
@property(nonatomic,assign)BOOL joinMember;
///
@property(nonatomic,copy)NSString *brandName;
///
@property(nonatomic,copy)NSString *companyType;
///
@property(nonatomic,copy)NSString *companySize;
///
@property(nonatomic,copy)NSString *secretaryMemberId;
///
@property(nonatomic,copy)NSString *teamSize;
///
@property(nonatomic,copy)NSString *signIn;
///
@property(nonatomic,copy)NSString *wechatOpenId;
///
@property(nonatomic,copy)NSString *wechatUnionId;
///
@property(nonatomic,copy)NSString *memberAvatarId;
@end

NS_ASSUME_NONNULL_END
