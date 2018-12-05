//
//  HomeServiceApi.m
//  Shh
//
//  Created by 燕来秋mac9 on 2018/10/18.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HomeServiceApi.h"

@implementation HomeServiceApi
+ (instancetype)share {
    static HomeServiceApi *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[HomeServiceApi alloc] init];
        }
    });
    return global;
}

///banner获取
-(void)getBannerWithParam:(BannersReq *) req response:(responseModel) responseModel{
    
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:banner_list Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [BannerRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {

    }];
}

///免费课程
-(void)getFreeListWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:free_course_list Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                     NSArray *result = [FreeListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///今日干活（1045266497792114689）
-(void)getTodayListWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:Today_list Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [TodayListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///精品微课（1045258743325130753）
-(void)getFineClassWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:fine_course_list Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [FreeListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}

///推介服务
-(void)getRecommendListWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:recommend_list Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [ServiceListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///猜你喜欢
-(void)getGuessListWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:guess_list Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [GuessListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///首页底部展示
-(void)gethHomeBottomWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:home_bottom_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [ServiceListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}

///获取更多分类
-(void)getMoreSortWithParam:(BaseModelReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:more_sort_list Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                   
                    responseModel(dicResponse[@"data"]);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}

///获取单条课程
-(void)getsingleWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:single_course Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                   DetailCourseRes *model = [DetailCourseRes mj_objectWithKeyValues:dicResponse[@"data"]];
                    responseModel(model);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///获取评论列表
-(void)getCommentListWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:more_comment_list Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [CommentListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///获取单条课程目录
-(void)SingleCourseDirectoryWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:single_course_directory Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    SingleCourseDrectoryRes *model = [SingleCourseDrectoryRes mj_objectWithKeyValues:dicResponse[@"data"]];
                    responseModel(model);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///获取单条文章详情
-(void)getSingleArticleWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:single_article Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    DetailArticleRes *model = [DetailArticleRes mj_objectWithKeyValues:dicResponse[@"data"]];
                    responseModel(model);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///获取服务详情
-(void)getServiceDetailWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:service_detail_url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    DetailServiceRes *model = [DetailServiceRes mj_objectWithKeyValues:dicResponse[@"data"]];
                    responseModel(model);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///新增评论
-(void)addCommentWithParam:(CommentReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:add_comment_list Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///获取热门搜索
-(void)getHotSearchWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:hot_search_list Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [HotSearchListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///获取搜索列表
-(void)getSearchListWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:search_course Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    NSArray *result = [FreeListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///课程购买
-(void)buyCourseWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:buy_course_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                   
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///关注
-(void)followWithParam:(FollowReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:follow_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///点赞
-(void)likeWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:like_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}///收藏
-(void)bookWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:book_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///微信支付
-(void)getWxPayWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:wx_pay_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    OrderPayRes*model = [OrderPayRes mj_objectWithKeyValues:dicResponse[@"data"]];
                    responseModel(model);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///支付宝支付
-(void)getAlipayWithParam:(FreeListReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:alipay_pay_url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                if (responseModel) {
                    OrderPayRes*model = [OrderPayRes mj_objectWithKeyValues:dicResponse[@"data"]];
                    responseModel(model);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
@end
