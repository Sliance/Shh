//
//  ApplyForReq.h
//  Shh
//
//  Created by zhangshu on 2018/11/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseModelReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplyForReq : BaseModelReq
///
@property(nonatomic,copy)NSString *memberName;
///
@property(nonatomic,copy)NSString *brandName;
///
@property(nonatomic,copy)NSString *businessLicenseId;
///
@property(nonatomic,copy)NSString *businessLicensePath;
///
@property(nonatomic,copy)NSString *companyLogoId;
///
@property(nonatomic,copy)NSString *companyLogoPath;
///
@property(nonatomic,copy)NSString *companyName;
///
@property(nonatomic,copy)NSString *companyNameAbbr;
///
@property(nonatomic,copy)NSString *companySize;
///
@property(nonatomic,copy)NSString *teamSize;
///
@property(nonatomic,copy)NSString *contact;
///
@property(nonatomic,copy)NSString *industry;
///
@property(nonatomic,copy)NSString *location;
///
@property(nonatomic,copy)NSString *phoneNumber;
///
@property(nonatomic,copy)NSString *telephoneNumber;
///
@property(nonatomic,copy)NSString *typeid;
///秘书
@property(nonatomic,copy)NSString *secretaryName;
///
@property(nonatomic,copy)NSString *province;
///
@property(nonatomic,copy)NSString *city;
///
@property(nonatomic,copy)NSString *jobTitle;
///
@property(nonatomic,copy)NSString *wechatNo;
///
@property(nonatomic,copy)NSString *industryType;
///
@property(nonatomic,copy)NSString *memberAvatarPath;
///
@property(nonatomic,copy)NSString *memberAvatarId;
///
@property(nonatomic,copy)NSString *invitationCode;
///
@property(nonatomic,copy)NSString *tencentNo;
///
@property(nonatomic,copy)NSString *secretaryMemberId;
///
@property(nonatomic,copy)NSString *wechatOpenId;
///
@property(nonatomic,copy)NSString *wechatUnionId;
///
@property(nonatomic,copy)NSString *companyType;
///
@property(nonatomic,copy)NSString *parentInvitationMemberId;
@end

NS_ASSUME_NONNULL_END
