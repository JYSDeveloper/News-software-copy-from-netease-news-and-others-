//
//  JYSLiveMessageModel.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/12.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSLiveMessageModel.h"
#import "JYSLiveMessageImage.h"
@implementation JYSLiveMessageModel
+(instancetype)liveMessageModelWithDic:(NSDictionary *)dic{
    
    JYSLiveMessageModel *model = [JYSLiveMessageModel new];
    model.ID = dic[@"id"];
    model.time = dic[@"time"];
    model.commentatorImgUrl = dic[@"commentator"][@"imgUrl"];
    model.commentatorName = dic[@"commentator"][@"name"];
    model.msgContent = dic[@"msg"][@"content"];
    model.images = [NSMutableArray new];
    model.section = dic[@"section"];
    NSArray *temp = dic[@"images"];
    if (temp) {
        for (NSDictionary *tempDic in temp) {
            JYSLiveMessageImage *image = [JYSLiveMessageImage liveMessageImageWithDic:tempDic];
            [model.images addObject:image];
        }
    }
   
    return model;
    
}
@end
