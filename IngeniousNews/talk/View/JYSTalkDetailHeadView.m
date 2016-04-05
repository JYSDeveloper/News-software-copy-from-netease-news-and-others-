//
//  JYSTalkDetailHeadView.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/10.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSTalkDetailHeadView.h"
#import <UIImageView+WebCache.h>
@implementation JYSTalkDetailHeadView

-(instancetype)initWithFrame:(CGRect)frame Message:(JYSTalkModel *)message{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUIWithMessage:message height:^(CGFloat height) {
            self.frame = CGRectMake(0, 200, UISCREENWIDTH, height);
        }];
    }
    return self;
}

-(void)creatUIWithMessage:(JYSTalkModel*)message height:(heightBlock)height{
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:message.headpicurl] placeholderImage:nil];
    [self addSubview:self.imageView];
    
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, UISCREENWIDTH-70, 30)];
    self.nameLable.font = [UIFont systemFontOfSize:15];
    self.nameLable.text = [NSString stringWithFormat:@"%@\t|\t%@",message.name,message.classification];
    self.nameLable.textColor = [UIColor grayColor];
    [self addSubview:self.nameLable];
    
    //self.introduceLable = [[UILabel alloc]initWithFrame:CGRectMake(60, 45, UISCREENWIDTH-70, 0)];
    self.introduceLable = [[UILabel alloc]init];
    self.introduceLable.numberOfLines = 0;
    CGFloat lableHeight = [self heightForIntroduceLable:message.descriptions];
    self.introduceLable.font = [UIFont systemFontOfSize:18];
    self.introduceLable.frame = CGRectMake(60, 45, UISCREENWIDTH-70, lableHeight);
    self.introduceLable.text = message.descriptions;
    self.introduceLable.textColor = [UIColor grayColor];
    [self addSubview:self.introduceLable];
    
    height(lableHeight+50);
}
-(CGFloat)heightForIntroduceLable:(NSString*)message{
    
     CGRect rect = [message boundingRectWithSize:CGSizeMake(UISCREENWIDTH-70, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    
    return rect.size.height;
}

@end
