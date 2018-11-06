//
//  CourseMemberModel.h
//  Shh
//
//  Created by dnaer7 on 2018/11/6.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseMemberModel : NSObject
///
@property(nonatomic,strong)NSString *memberAvatarPath;
///
@property(nonatomic,strong)NSString *memberDesc;
///
@property(nonatomic,strong)NSString *memberId;
///
@property(nonatomic,strong)NSString *memberName;
///
@property(nonatomic,strong)NSString *userId;
@end

NS_ASSUME_NONNULL_END
