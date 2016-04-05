//
//  JYSNewsModel.h
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSNewsModel : NSObject

/** 新闻ID*/
@property(nonatomic,copy)NSString *postid;
/** webView界面*/
@property(nonatomic,copy)NSString *url_3w;
/** 关注数*/
@property(nonatomic,retain)NSNumber *votecount;
/** 跟帖数*/
@property(nonatomic,retain)NSNumber *replyCount;
/** 新闻长标题*/
@property(nonatomic,copy)NSString *ltitle;
/** 新闻简介*/
@property(nonatomic,copy)NSString *digest;
/** 不详*/
@property(nonatomic,copy)NSString *url;
/** postid*/
@property(nonatomic,copy)NSString *docid;
/** 新闻标题*/
@property(nonatomic,copy)NSString *title;
/** 不详*/
@property(nonatomic,copy)NSString *TAGS;
/** 新闻来源*/
@property(nonatomic,copy)NSString *source;
/** 新闻时间*/
@property(nonatomic,copy)NSString *Imodify;
/** 不详*/
@property(nonatomic,retain)NSNumber *priority;
/** 评论信息标识(新闻类型标识)*/
@property(nonatomic,copy)NSString *boardid;
/** 新闻图片*/
@property(nonatomic,copy)NSString *imgsrc;
/** 不详*/
@property(nonatomic,copy)NSString *subtitle;
/** 新闻发生时间*/
@property(nonatomic,copy)NSString *ptime;
/** 不详*/
@property(nonatomic,copy)NSString *TAG;

/** 专题新闻特有属性*/

/** 专题类型*/
@property(nonatomic,copy)NSString *skipType;
/** 专题标识符*/
@property(nonatomic,copy)NSString *specialID;
/** 专题标识符*/
@property(nonatomic,copy)NSString *skipID;
/** 多图数组*/
@property(nonatomic,retain)NSArray *imgextra;
/** 不详*/
@property(nonatomic,assign)BOOL hasCover;
/** 不详*/
@property(nonatomic,retain)NSArray *ads;
/** --*/
@property(nonatomic,retain)NSNumber *imgType;
/** --*/
@property(nonatomic,retain)NSString *photosetID;

+(instancetype)newsModelWithDic:(NSDictionary*)dic;

@end
