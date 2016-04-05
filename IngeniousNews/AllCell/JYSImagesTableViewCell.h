//
//  JYSImagesTableViewCell.h
//  IngeniousNews
//
//  Created by 姜雨生 on 16/2/29.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSTools.h"
#import "JYSNewsModel.h"
#import "JYSBaseTableViewCell.h"
@interface JYSImagesTableViewCell : JYSBaseTableViewCell

/** 三个图片*/
@property(nonatomic,retain)UIImageView *imageCenter;
@property(nonatomic,retain)UIImageView *imageRight;


/** 跟帖数*/
@property(nonatomic,retain)UILabel *replyCountLable;


@end
