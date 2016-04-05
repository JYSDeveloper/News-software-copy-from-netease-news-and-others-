//
//  JYSBaseTableViewCell.h
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/4.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
@interface JYSBaseTableViewCell : UITableViewCell


@property(nonatomic,retain)UIImageView *titleImage;

@property(nonatomic,retain)UILabel *titleLable;

@property(nonatomic,retain)UILabel *digestLable;



-(void)getDataWithModel:(id)model;


@end
