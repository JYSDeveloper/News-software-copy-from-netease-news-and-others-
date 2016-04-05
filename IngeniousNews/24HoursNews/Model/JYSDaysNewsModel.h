//
//  JYSDaysNewsModel.h
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/27.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSDaysNewsModel : NSObject

/**普通新闻数据 */
@property(nonatomic,copy)NSString *postid;
@property(nonatomic,copy)NSString *url_3w;
@property(nonatomic,retain)NSNumber *votecount;
@property(nonatomic,retain)NSNumber *replyCount;
@property(nonatomic,copy)NSString *ltitle;
@property(nonatomic,copy)NSString *digest;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *docid;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *TAGS;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,retain)NSNumber *priority;
@property(nonatomic,copy)NSString *Imodify;
@property(nonatomic,copy)NSString *boardid;
@property(nonatomic,copy)NSString *imgsrc;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSString *ptime;
@property(nonatomic,copy)NSString *TAG;



/**专题界面特殊标识参数*/
@property(nonatomic,copy)NSString *skipID;
@property(nonatomic,copy)NSString *skipType;
@property(nonatomic,copy)NSString *specialID;

+(instancetype)daysNewsModelWithDic:(NSDictionary*)dic;


@end
