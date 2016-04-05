//
//  JYSChannelViewController.m
//  哔哔点啥
//
//  Created by 姜雨生 on 16/3/12.
//  Copyright © 2016年 姜雨生. All rights reserved.
//

#import "JYSChannelViewController.h"
#import "JYSLableCollectionViewCell.h"
#import "JYSSqliteFmdbTool.h"
@interface JYSChannelViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,retain)NSMutableArray *notUsedChannelArr;
@property(nonatomic,retain)UICollectionView *collectionView;
@property(nonatomic,assign)BOOL change;
@end

@implementation JYSChannelViewController
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
    if ([[JYSSqliteFmdbTool selectedChannels] isEqual:self.userChannelArr]) {
    }else{
    [JYSSqliteFmdbTool delectedAll];
    [JYSSqliteFmdbTool addChannelsWithArr:self.userChannelArr];
    }
    
}
-(NSMutableArray *)notUsedChannelArr{
    
    if (_notUsedChannelArr == nil) {
        _notUsedChannelArr = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsURLs.plist" ofType:nil]] mutableCopy];
        [_notUsedChannelArr removeObjectsInArray:_userChannelArr];
        
    }
    return _notUsedChannelArr;
}

-(void)creatUI{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //每个cell的大小
    flowLayout.itemSize = CGSizeMake((UISCREENWIDTH-80)/4, 40);
    //分区距离上下左右空白
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    //两行之间的行距
    flowLayout.minimumLineSpacing = 5;
    //两个单元格之间的距离
    flowLayout.minimumInteritemSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[JYSLableCollectionViewCell class] forCellWithReuseIdentifier:@"collectionItems"];
    self.collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    [self.view addSubview:self.collectionView];
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
    [_collectionView addGestureRecognizer:longGesture];
    
}
- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.userChannelArr.count;
    }
    else{
    return self.notUsedChannelArr.count;
    }
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JYSLableCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionItems" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.title.text = self.userChannelArr[indexPath.row][@"title"];
    }
    else{
    cell.title.text = self.notUsedChannelArr[indexPath.row][@"title"];
    }
    cell.title.backgroundColor = [UIColor redColor];
    cell.title.layer.masksToBounds = YES;
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self creatUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    if (sourceIndexPath.section != destinationIndexPath.section) {
        if (sourceIndexPath.section == 0) {
            NSDictionary *change = self.userChannelArr[sourceIndexPath.item];
            [self.userChannelArr removeObject:change];
            [self.notUsedChannelArr insertObject:change atIndex:destinationIndexPath.item];
        }
        else{
            NSDictionary *change = self.notUsedChannelArr[sourceIndexPath.item];
            [self.notUsedChannelArr removeObject:change];
            [self.userChannelArr insertObject:change atIndex:destinationIndexPath.item];
        }
        
    }
    else{
        if (sourceIndexPath.section == 0) {
            [self.userChannelArr exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        }
        else{
            [self.notUsedChannelArr exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        }
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSDictionary *change = self.userChannelArr[indexPath.item];
        [self.userChannelArr removeObject:change];
        [self.notUsedChannelArr addObject:change];
    }
    else{
        NSDictionary *change = self.notUsedChannelArr[indexPath.item];
        [self.notUsedChannelArr removeObject:change];
        [self.userChannelArr addObject:change];

    }

    
    [self.collectionView reloadData];
    
}


@end
