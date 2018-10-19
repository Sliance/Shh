//
//  BannerRes.h
//  Shh
//
//  Created by dnaer7 on 2018/10/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerRes : NSObject
///banner编号
@property(nonatomic,copy)NSString *bannerId;
///banner标题
@property(nonatomic,copy)NSString *bannerTitle;
///banner类型
@property(nonatomic,copy)NSString *bannerType;
///banner类型对应编号
@property(nonatomic,copy)NSString *bannerTypeId;
///banner图片编号
@property(nonatomic,copy)NSString *bannerImageId;
///banner图片路径
@property(nonatomic,copy)NSString *bannerImagePath;
///banner跳转路径
@property(nonatomic,copy)NSString *bannerUrl;
///banner排序
@property(nonatomic,copy)NSString *bannerSort;
///banner位置
@property(nonatomic,copy)NSString *bannerLocation;
///版本号
@property(nonatomic,copy)NSString *systemVersion;

@end

NS_ASSUME_NONNULL_END
