//
//  JYSWebViewModel.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/29.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSWebViewModel.h"
#import "JYSWebViewImgModel.h"
@implementation JYSWebViewModel

/** 便利构造器*/

+(instancetype)webViewModelWithDic:(NSDictionary *)dic withType:(WebModelType)Type{
    
    
    switch (Type) {
        case firstType:
           return  [self firstWebViewModelWithDic:dic];
            break;
        case secondType:
            return [self secondWebViewModelWithDic:dic];
            break;
    }
    
}



+(instancetype)firstWebViewModelWithDic:(NSDictionary *)dic{
    
    
    JYSWebViewModel *model = [JYSWebViewModel new];
    
    model.title = dic[@"title"];
    model.ptime = dic[@"ptime"];
    model.body = dic[@"body"];
    NSArray *linkArr = dic[@"link"];
    if (linkArr.count) {
        model.href = dic[@"link"][0][@"href"];
    }
    NSArray *imgArr = dic[@"img"];
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:imgArr.count];
    
    for (NSDictionary *temDic in imgArr) {
        JYSWebViewImgModel *imgModel = [JYSWebViewImgModel webViewImgWithDic:temDic];
        [temp addObject:imgModel];
    }
    model.img = temp;
    return model;
}

+(instancetype)secondWebViewModelWithDic:(NSDictionary*)dic{
    
    JYSWebViewModel *model = [JYSWebViewModel new];
    model.title = [dic objectForKey:@"title"];
    model.ptime = [dic objectForKey:@"editTime"];
    model.body = [dic objectForKey:@"text"];
    NSArray *imgArr = [dic objectForKey:@"img"];
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:imgArr.count];
    for (NSDictionary *tempDic in imgArr) {
        JYSWebViewImgModel *imgModel = [JYSWebViewImgModel secondWebViewImgWithDic:tempDic];
        [temp addObject:imgModel];
    }
    
    model.img =temp;
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
    
}

@end
