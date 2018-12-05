//
//  ImageModel.h
//  Etram
//
//  Created by dnaer7 on 2018/10/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageModel : NSObject
///
@property(nonatomic,copy)NSString *fileId;
///
@property(nonatomic,copy)NSString *fileOriginalPath;
///
@property(nonatomic,copy)NSString *imageId;
///
@property(nonatomic,copy)NSString *imagePath;
@end

NS_ASSUME_NONNULL_END
