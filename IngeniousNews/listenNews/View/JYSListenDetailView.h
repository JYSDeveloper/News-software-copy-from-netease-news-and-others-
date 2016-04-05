//
//  JYSListenDetailView.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/3.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYSListenDetailModel.h"

@interface JYSListenDetailView : UIView


@property(nonatomic,retain)UILabel *titleLable;

@property(nonatomic,retain)UILabel *dateLable;

@property(nonatomic,retain)UILabel *excerptLable;

@property(nonatomic,retain)UIImageView *imageView;

@property(nonatomic,retain)UIScrollView *scrollView;

-(void)reloadData:(JYSListenDetailModel*)model;

@end
