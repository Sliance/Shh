//
//  RecommendListRes.h
//  Shh
//
//  Created by dnaer7 on 2018/10/23.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendListRes : NSObject
///
@property(nonatomic,strong)NSString *columnId;
///
@property(nonatomic,strong)NSString *siheserviceAppImageId;
///
@property(nonatomic,strong)NSString *siheserviceAppImagePath;
///
@property(nonatomic,strong)NSString *siheserviceAuditRemark;
///
@property(nonatomic,strong)NSString *siheserviceAuditStatus;
///
@property(nonatomic,strong)NSString *siheserviceDesc;
///
@property(nonatomic,strong)NSString *siheserviceId;
///
@property(nonatomic,strong)NSString *siheserviceIsRecommend;

///
@property(nonatomic,strong)NSString *siheservicePcImageId;
///
@property(nonatomic,strong)NSString *siheservicePcImagePath;
///
@property(nonatomic,strong)NSString *siheservicePublishMemberAvatarId;
///
@property(nonatomic,strong)NSString *siheservicePublishMemberAvatarPath;
///
@property(nonatomic,strong)NSString *siheserviceSort;
///
@property(nonatomic,strong)NSString *siheserviceTitle;



@end

NS_ASSUME_NONNULL_END
