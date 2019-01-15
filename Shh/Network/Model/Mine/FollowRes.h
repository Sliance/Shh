//
//  FollowRes.h
//  Shh
//
//  Created by 张舒 on 2018/12/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FollowRes : NSObject
///
@property(nonatomic,copy)NSString *memberAvatarPath;
///
@property(nonatomic,copy)NSString *memberDesc;
///
@property(nonatomic,copy)NSString *memberName;
///
@property(nonatomic,copy)NSString *beFollowMemberId;
///
@property(nonatomic,copy)NSString *followCount;
///
@property(nonatomic,copy)NSString *courseAndArticleCount;
///
@property(nonatomic,copy)NSString *memberAvatarId;
@property(nonatomic,strong)NSString *followCategory;
@property(nonatomic,strong)NSString *brandName;
@property(nonatomic,strong)NSString *telephoneNumber;
@property(nonatomic,strong)NSString *companyNameAbbr;
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *companyLogoPath;
@property(nonatomic,strong)NSString *typeid;
@property(nonatomic,strong)NSString *beFollowCount;
@property(nonatomic,strong)NSString * companySettledId;
@end

NS_ASSUME_NONNULL_END
