//
//  JYSListenDetailView.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/3.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSListenDetailView.h"
#import <UIImageView+WebCache.h>
@implementation JYSListenDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    [self addSubview:self.scrollView];
    
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, UISCREENWIDTH-20, 60)];
    self.titleLable.font = [UIFont systemFontOfSize:25];
    self.titleLable.numberOfLines = 0;
    [self.scrollView addSubview:self.titleLable];
    
    self.dateLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, UISCREENWIDTH-20, 30)];
    self.dateLable.font = [UIFont systemFontOfSize:15];
    self.dateLable.textColor = [UIColor colorWithWhite:0.746 alpha:1.000];
    [self.scrollView addSubview:self.dateLable];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 60+30, UISCREENWIDTH-20, 200)];
    [self.scrollView addSubview:self.imageView];
    
    self.excerptLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 60+30+200+20, UISCREENWIDTH-20, 0)];
    [self.scrollView addSubview:self.excerptLable];
    
    
}

-(void)reloadData:(JYSListenDetailModel*)model{
    
    self.titleLable.text = model.post_title;
    
    NSString *dateAndFromText = [NSString stringWithFormat:@"日期:%@\t\t来自:%@",model.post_date,model.post_lai];
    self.dateLable.text = dateAndFromText;
    
    NSData *jsonData = [model.smeta dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *imageUrl = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl[@"thumb"]] placeholderImage:nil];
    
    self.excerptLable.text = model.post_excerpt;
    self.excerptLable.numberOfLines = 0;
    self.excerptLable.font= [UIFont systemFontOfSize:20];
    CGRect frame = self.excerptLable.frame;
    frame.size.height = [self getH:model.post_excerpt];
    self.excerptLable.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(0, self.excerptLable.frame.size.height + 420);
    
}
-(CGFloat)getH:(NSString*)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(UISCREENWIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    return rect.size.height;
}


@end
