//
//  ViewController.m
//  SCollectionView
//
//  Created by mac on 2016/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //一个规范一般在赋值的时候，用_collectionView   而不是 用  self.collectionView
    [self.view addSubview:self.myCollectionView];
    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

//这样写，可以防止多次初始化
- (UICollectionView *)myCollectionView {
    
    if (!_myCollectionView) {
        //主要布局，瀑布流内显示的每一个单元格
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        _myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor yellowColor];
        
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
    }
    return _myCollectionView;
    
}

#pragma mark 协议方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
