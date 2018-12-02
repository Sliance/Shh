//
//  UserBaseInfoModel.m
//  PropertyProject
//
//  Created by zhangshu on 15/12/2.
//  Copyright © 2015年 zhangshu. All rights reserved.
//

#import "UserBaseInfoModel.h"

@implementation UserBaseInfoModel
- (NSString *)token {
    if (_token == nil || _token.length == 0) {
        _token = @"";
    }
    return _token;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            
             @"token"   : @"token",
             @"memberName"    : @"memberName",
             @"memberAvatarPath" : @"memberAvatarPath"
            , @"memberMobile" : @"memberMobile"
             ,@"openid":@"openid",@"roleId":@"roleId",
             @"latitude":@"latitude",
              @"longitude":@"longitude",
              @"city":@"city",
              @"area":@"area",
              @"thoroughfare":@"thoroughfare",
              @"address":@"address",
             @"memberId":@"memberId",
             };
}

- (NSDictionary *)getUserInfoDictionary {
    if (self.token == nil) {
        return @{};
    }
    NSDictionary *dic = @{

                          @"token" : self.token == nil?@"":self.token,
                          @"memberName" : self.memberName == nil?@"":self.memberName,@"memberAvatarPath" : self.memberAvatarPath == nil?@"":self.memberAvatarPath,
                         @"memberMobile" : self.memberMobile == nil?@"":self.memberMobile,
                          @"openid" : self.openid == nil?@"":self.openid,
                          @"roleId" : self.memberId == nil?@"":self.memberId,
                          @"latitude" : self.latitude == nil?@"":self.latitude,
                          @"longitude" : self.longitude == nil?@"":self.longitude,
                          @"city" : self.city == nil?@"":self.city,
                          @"area" : self.area == nil?@"":self.area,
                          @"thoroughfare" : self.thoroughfare == nil?@"":self.thoroughfare,
                          @"address" : self.address == nil?@"":self.address,
                          };
    return dic;
}

- (void)configUserInfoModelWithDic:(NSDictionary *) dic {

    self.token = dic[@"token"];
    self.memberName = dic[@"memberName"];
    self.memberAvatarPath = dic[@"memberAvatarPath"];
    self.memberMobile = dic[@"memberMobile"];
    self.openid = dic[@"opeid"];
    self.memberId = dic[@"memberId"];
    self.latitude = dic[@"latitude"];
    self.longitude = dic[@"longitude"];
    self.city = dic[@"city"];
    self.area = dic[@"area"];
    self.thoroughfare = dic[@"thoroughfare"];
    self.address = dic[@"address"];
}

- (void)updateUserInfoModelWithDic:(NSDictionary *) dic {

    self.token = dic[@"token"] ;
    self.memberName = dic[@"memberName"] ;
    self.memberAvatarPath = dic[@"memberAvatarPath"] ;
    self.memberMobile = dic[@"memberMobile"];
    self.openid = dic[@"openid"];
    self.memberId = dic[@"memberId"];
    self.latitude = dic[@"latitude"];
    self.longitude = dic[@"longitude"];
    self.city = dic[@"city"];
    self.area = dic[@"area"];
    self.thoroughfare = dic[@"thoroughfare"];
    self.address = dic[@"address"];
}

@end
