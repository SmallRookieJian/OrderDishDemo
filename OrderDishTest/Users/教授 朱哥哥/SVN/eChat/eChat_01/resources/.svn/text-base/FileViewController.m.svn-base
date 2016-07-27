//
//  FileViewController.m
//  eChat_01
//
//  Created by mac on 2016/3/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FileViewController.h"
#import "FileRequest.h"
#import "CollectionViewController.h"
#import "MyCollectionCell.h"
#import "UIImageView+WebCache.h"
#import "FileModel.h"

#import "AFNetworking.h"
#import "DownloadTool.h"
#import "ShowSourceViewController.h"

#define SCREEN_WIDTH ([UIScreen  mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/*
 
 在主界面需要的信息有
 name
 image_url
 
 */

@interface FileViewController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSArray *_arrPerFile;
    NSArray *_arrPubFile;
    UIScrollView *_scrollView;
    UISegmentedControl *_segment;
}


@end

@implementation FileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configurateSegmentControl];
    
//    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"download_button.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnDownloadClicked)];
    
    
    [FileRequest gainFileListWithReturnBlock:^(NSArray *arrRtPerFile, NSArray *arrRtPubFile) {
        
        _arrPerFile = arrRtPerFile;
        _arrPubFile = arrRtPubFile;
        
        //        NSLog(@"perfile______%d\npubfile_______%d",_arrPerFile.count,_arrPubFile.count);
        [self configurateScrollView];
    }];
}

- (void)btnDownloadClicked {
    
    NSLog(@"点了下载");
}

- (void)configurateSegmentControl {
    
    _segment = [[UISegmentedControl alloc] initWithItems:@[@"个人资源",@"公共资源"]];
    [_segment addTarget:self action:@selector(segSelectedChanged:) forControlEvents:UIControlEventValueChanged];
    _segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = _segment;
    
    
}

- (void)configurateScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 320, 480-64-60)];
    [self.view addSubview:_scrollView];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
//    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.contentSize = CGSizeMake(320 * 2, 480-64-60);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    for (int i = 0; i < 2; i++) {
        
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(320 * i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
//        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
//        [_scrollView addSubview:imgView];
        
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
        
        //指定布局方式为垂直
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        flow.minimumLineSpacing = 10;//最小行间距(当垂直布局时是行间距，当水平布局时可以理解为列间距)
        flow.minimumInteritemSpacing = 5;//两个单元格之间的最小间距
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) collectionViewLayout:flow];
        collectionView.bounces = NO;
        collectionView.tag = i;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        if (i == 0) {
            collectionView.backgroundColor = [UIColor cyanColor];
            [collectionView registerNib:[UINib nibWithNibName:@"MyCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell0"];
        }
        
        if (i == 1) {
            collectionView.backgroundColor = [UIColor yellowColor];
            [collectionView registerNib:[UINib nibWithNibName:@"MyCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
        }
        
        [_scrollView addSubview:collectionView];
        
    }
}

- (void)segSelectedChanged:(UISegmentedControl *)seg {
    
    _scrollView.contentOffset = CGPointMake(320 * seg.selectedSegmentIndex, 0);
    
}

#pragma mark scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _segment.selectedSegmentIndex = scrollView.contentOffset.x / 320;
}

#pragma mark collectionView 代理协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 0) {
        return _arrPerFile.count;
    }
    else {
        return _arrPubFile.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 0) {
        
        MyCollectionCell *cell0 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell0" forIndexPath:indexPath];
        //先从数组中把model中取出来
        FileModel *fileModel = _arrPerFile[indexPath.row];
        
        NSURL *url = [NSURL URLWithString:fileModel.image_url];
        
        cell0.downloadFinished = NO;
        [cell0.imgView sd_setImageWithURL:url];
        cell0.labelName.text = fileModel.name;
        
        return cell0;
        
    }
    else {
        
        MyCollectionCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        cell1.downloadFinished = NO;
        //先从数组中把model中取出来
        FileModel *fileModel = _arrPubFile[indexPath.row];
        
        NSURL *url = [NSURL URLWithString:fileModel.image_url];
        
        [cell1.imgView sd_setImageWithURL:url];
        cell1.labelName.text = fileModel.name;
        
        
        return cell1;
        
    }
}
//协议中的方法，用于返回单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 113);
}
//协议中的方法，用于返回整个CollectionView上、左、下、右距四边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上、左、下、右的边距
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //在这里先得到点中的Item
    MyCollectionCell *cell = (MyCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.downloadFinished == YES) {
        
        NSLog(@"下载完成");
        //到了这里就表示资源已经下载完成，在这里写人处理展示的代码
        
        
        ShowSourceViewController *vcShow = [[ShowSourceViewController alloc] init];
        [self.navigationController pushViewController:vcShow animated:YES];
        
        
        return;
        
    }
    
    
    
    FileModel *model = nil;
    
    if (collectionView.tag == 0) {
        NSLog(@"000页---%d------%d",indexPath.section,indexPath.row);
        NSLog(@"%@",_arrPerFile[indexPath.row]);
        model = _arrPerFile[indexPath.row];
        
        
    }
    else {
        NSLog(@"111页---%d------%d",indexPath.section,indexPath.row);
        NSLog(@"%@",_arrPubFile[indexPath.row]);
        
        model = _arrPubFile[indexPath.row];
        
        
    }
    
    
    [DownloadTool download:model block:^(BOOL isSuccess) {
        cell.downloadFinished = isSuccess;
    }];
    
    
}

//- (void)download

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
