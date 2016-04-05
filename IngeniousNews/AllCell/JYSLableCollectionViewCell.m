//
//  JYSLableCollectionViewCell.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/3/1.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSLableCollectionViewCell.h"
#import "JYSTools.h"
@implementation JYSLableCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView{
    
    self.title = [JYSTools replyCountLableWithFrame:self.contentView.bounds];
    self.title.textColor = [UIColor blackColor];
    self.title.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.title];
}



@end
