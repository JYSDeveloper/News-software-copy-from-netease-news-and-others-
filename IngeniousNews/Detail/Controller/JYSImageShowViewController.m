//
//  JYSImageShowViewController.m
//  IngeniousNews
//
//  Created by 姜雨生 on 16/3/1.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSImageShowViewController.h"
#import "MHNetWorkTask.h"
#import "JYSImageShowModel.h"
#import <UIImageView+WebCache.h>
#import "JYSTools.h"
@interface JYSImageShowViewController ()<UIScrollViewDelegate>

@property(nonatomic,retain)NSMutableArray *imagesArr;

@property(nonatomic,retain)UILabel *titleLable;
@property(nonatomic,retain)UILabel *noteLable;
@property(nonatomic,retain)UILabel *imageCountLable;

@property(nonatomic,retain)UIScrollView *images;

@property(nonatomic,retain)UIView *imageIntro;

@end

@implementation JYSImageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInfo];
    self.view.backgroundColor = [UIColor blackColor];
    
}
-(void)creatUI{
    
    JYSImageShowModel *model = [JYSImageShowModel new];
    self.images = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT)];
    self.images.center = self.view.center;
    self.images.contentSize = CGSizeMake(self.imagesArr.count*UISCREENWIDTH, 0);
    self.images.pagingEnabled = YES;
    self.images.showsHorizontalScrollIndicator = NO;
    self.images.delegate = self;
    
    self.imageIntro = [[UIView alloc]initWithFrame:CGRectMake(0, UISCREENHEIGHT*0.7, UISCREENWIDTH, UISCREENHEIGHT*0.3)];
    self.imageIntro.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.500];

    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, UISCREENWIDTH-100, 30)];
    self.titleLable.textColor = [UIColor whiteColor];
    self.titleLable.font = [UIFont systemFontOfSize:17];
    self.titleLable.text = self.model.title;
    [self.imageIntro addSubview:self.titleLable];
    
    self.noteLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, UISCREENWIDTH-20, 140)];
    self.noteLable.textColor = [UIColor whiteColor];
    self.noteLable.font = [UIFont systemFontOfSize:15];
    self.noteLable.numberOfLines = 0;
    model = [self.imagesArr firstObject];
    self.noteLable.text = model.note;
    [self.imageIntro addSubview:self.noteLable];
    
    self.imageCountLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREENWIDTH-80, 10, 80, 30)];
    self.imageCountLable.font = [UIFont systemFontOfSize:20];
    self.imageCountLable.text = [NSString stringWithFormat:@"1 / %ld",(unsigned long)self.imagesArr.count];
    self.imageCountLable.textColor = [UIColor whiteColor];
    [self.imageIntro addSubview:self.imageCountLable];

    for (int i = 0; i<self.imagesArr.count; i++) {
        model = self.imagesArr[i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*i, 0, UISCREENWIDTH, UISCREENHEIGHT)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGFloat imageH = (image.size.height/image.size.width*UISCREENWIDTH)>UISCREENHEIGHT?UISCREENHEIGHT:(image.size.height/image.size.width*UISCREENWIDTH);
            
            CGFloat imageY;
            if (imageH > UISCREENHEIGHT) {
                imageY = 0;
            }
            else{
                imageY = (UISCREENHEIGHT-imageH) / 2;
            }
            imageView.frame = CGRectMake(UISCREENWIDTH*i, imageY+5, UISCREENWIDTH,imageH);
        }];
        
        [self.images addSubview:imageView];
    }
    
    [self.view addSubview:self.images];
    
    [self.view addSubview:self.imageIntro];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSUInteger count = scrollView.contentOffset.x / UISCREENWIDTH;
    JYSImageShowModel *model = self.imagesArr[count];
    self.noteLable.text = model.note;
    self.imageCountLable.text = [NSString stringWithFormat:@"%lu / %ld",count+1,self.imagesArr.count];
    
}

-(void)dataInfo{
    
    self.imagesArr = [NSMutableArray new];
    NSRange range = [self.model.photosetID rangeOfString:@"|"];
    NSString *temp = [self.model.photosetID substringFromIndex:range.location+1];
    NSString *number = [self.model.photosetID substringWithRange:NSMakeRange(range.location-4, 4)];
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",number,temp];
    [MHNetWorkTask getWithURL:url withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        
        result = [result objectForKey:@"photos"];
        for (NSDictionary *dic in result) {
            JYSImageShowModel *model = [JYSImageShowModel imageShowModelWithDic:dic];
            [self.imagesArr addObject:model];
        }
        [self creatUI];
    } withFail:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
