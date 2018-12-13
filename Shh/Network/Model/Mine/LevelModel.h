//
//  LevelModel.h
//  Shh
//
//  Created by zhangshu on 2018/12/13.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LevelModel : NSObject
///
@property(nonatomic,assign)NSInteger completeInformation;
///
@property(nonatomic,copy)NSString *levelCode;
///
@property(nonatomic,copy)NSString *levelId;
///
@property(nonatomic,copy)NSString *systemVersion;
@end

NS_ASSUME_NONNULL_END
