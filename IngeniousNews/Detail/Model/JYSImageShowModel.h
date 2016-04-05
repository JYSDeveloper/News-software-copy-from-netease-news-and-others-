//
//  JYSImageShowModel.h
//  IngeniousNews
//
//  Created by 姜雨生 on 16/3/1.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYSImageShowModel : NSObject

@property(nonatomic,copy)NSString *imgurl;

@property(nonatomic,copy)NSString *note;

+(instancetype)imageShowModelWithDic:(NSDictionary*)dic;



@end
