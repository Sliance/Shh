//
//  UserBaseInfoModel.h
//  PropertyProject
//
//  Created by zhangshu on 15/12/2.
//  Copyright © 2015年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSBaseModel.h"

@interface UserBaseInfoModel : DSBaseModel


@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *memberName;
@property(nonatomic,strong)NSString *memberAvatarPath;
@property(nonatomic,strong)NSString *memberMobile;
@property(nonatomic,strong)NSString *openid;
@property(nonatomic,assign)BOOL isShow;

///
@property(nonatomic,strong)NSString *memberId;
///纬度
@property(nonatomic,strong)NSString *latitude;
///经度
@property(nonatomic,strong)NSString *longitude;

///市
@property(nonatomic,strong)NSString *city;
///区
@property(nonatomic,strong)NSString *area;
///街道
@property(nonatomic,strong)NSString *thoroughfare;
///详细标志地址
@property(nonatomic,strong)NSString *address;

- (NSDictionary *)getUserInfoDictionary;
- (void)configUserInfoModelWithDic:(NSDictionary *) dic;
- (void)updateUserInfoModelWithDic:(NSDictionary *) dic;

@end
