//
//  JYSListenModel.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/2.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSListenModel : NSObject

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *tuiid;
@property(nonatomic,copy)NSString *post_author;
@property(nonatomic,copy)NSString *post_news;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *post_keywords;
@property(nonatomic,copy)NSString *post_date;
@property(nonatomic,copy)NSString *post_times;
@property(nonatomic,copy)NSString *post_content;
@property(nonatomic,copy)NSString *post_title;
@property(nonatomic,copy)NSString *post_lai;
@property(nonatomic,copy)NSString *post_mp;
@property(nonatomic,copy)NSString *post_time;
@property(nonatomic,copy)NSString *post_size;
@property(nonatomic,copy)NSString *post_except;
@property(nonatomic,copy)NSString *post_status;
@property(nonatomic,copy)NSString *comment_status;
@property(nonatomic,copy)NSString *post_modified;
@property(nonatomic,copy)NSString *smeta;
@property(nonatomic,copy)NSString *post_hits;
@property(nonatomic,copy)NSString *toutiao;
@property(nonatomic,copy)NSString *listeningrate;
@property(nonatomic,copy)NSString *praisenums;
@property(nonatomic,copy)NSString *parisenum;


+(instancetype)listenModelWithDic:(NSDictionary*)dic;


@end
