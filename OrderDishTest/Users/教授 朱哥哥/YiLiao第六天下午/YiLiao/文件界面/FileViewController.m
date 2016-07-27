//
//  FileViewController.m
//  YiLiao
//
//  Created by MrCheng on 16/3/16.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "FileViewController.h"
#import "FileManager.h"





#define NavHeight  64


@interface FileViewController ()

@end

@implementation FileViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.topSegmentControl.hidden = NO;

    [self.leftCollection reloadData];

}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.topSegmentControl.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.




    [self.navigationController.navigationBar addSubview:self.topSegmentControl];

/*
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(100, 100, 100, 100);
    view.backgroundColor     = [UIColor redColor];
    [self.commeScrollView addSubview:view];
*/


    [self.view addSubview:self.commeScrollView];


    [self.commeScrollView addSubview:self.leftCollection];

    __weak FileViewController *fileViewController = self;

    [NetworkTool requestFileList:^(BOOL isSuccess, FileListModel *model) {
//如果成功 瀑布流刷新数据
//不需要判断是哪个瀑布流接收数据
        fileViewController.fileListModel = model;
        [fileViewController.leftCollection reloadData];

    }];


}


-(UISegmentedControl *)topSegmentControl
{
    if (!_topSegmentControl) {
        _topSegmentControl = [[UISegmentedControl alloc]init];
//        如何利用公式去计算 如何把控件放到中间位置
        _topSegmentControl.frame = CGRectMake(100, 0, 200, 30);

        [_topSegmentControl insertSegmentWithTitle:@"公共资源" atIndex:0 animated:YES];
        [_topSegmentControl insertSegmentWithTitle:@"个人资源" atIndex:1 animated:YES];
//设置默认位置
        _topSegmentControl.selectedSegmentIndex = 0;
        [_topSegmentControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _topSegmentControl;
}



-(UIScrollView *)commeScrollView
{
    if (!_commeScrollView) {

        _commeScrollView = [[UIScrollView alloc]init];
        _commeScrollView.frame = CGRectMake(0,NavHeight , MyWidth, MyHight);
        _commeScrollView.backgroundColor = [UIColor yellowColor];
        _commeScrollView.delegate = self;
        _commeScrollView.contentSize = CGSizeMake(MyWidth*2, MyHight);
        _commeScrollView.pagingEnabled = YES;
    }

    return _commeScrollView;
}

-(UICollectionView *)leftCollection
{
    if (!_leftCollection) {

        _leftCollection = [[UICollectionView  alloc]initWithFrame:CGRectMake(0, 0, MyWidth, MyHight) collectionViewLayout:[self getFlowLayout]];

        _leftCollection.delegate = self;
        _leftCollection.dataSource = self;

        _leftCollection.backgroundColor = [UIColor redColor];
        [_leftCollection registerClass:[FileCell class] forCellWithReuseIdentifier:@"LeftCell"];

    }
    
    return _leftCollection;
}



-(void)segmentChanged:(UISegmentedControl *)send
{


    NSLog(@"---%ld",send.selectedSegmentIndex);
    //分段选择器选择后改变滚动视图的显示位置
    CGPoint newPoint = CGPointMake(send.selectedSegmentIndex*MyWidth, 0);
    [self.commeScrollView setContentOffset:newPoint animated:YES];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//滑动后需要实现 1 改变分段选择器的tag  2需要刷新数据
    if (scrollView == self.commeScrollView) {
    int tag =scrollView.contentOffset.x/MyWidth;
    self.topSegmentControl.selectedSegmentIndex = tag;
    }


}



-(UICollectionViewFlowLayout *)getFlowLayout
{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置单元格大小
    layout.itemSize = CGSizeMake(100, 130);
//    每一行的分隔线 （——）
    layout.minimumLineSpacing =5;
//每一列的分隔线 （|）
    layout.minimumInteritemSpacing = 5;
//    设置上下左右的边距
    layout.sectionInset = UIEdgeInsetsMake(100, 5, 100, 5);

    return layout;

}




-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//需要添加判断 是哪个资源
    if (collectionView == self.leftCollection) {
        //公共资源个数
        return self.fileListModel.pub_file.count;
    }

    return 0;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//需要先找到cell对象  然后再进行一次强制转换
    FileCell *cell = (FileCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"LeftCell" forIndexPath:indexPath];
//需要给cell传递一个model

//    应该是在请求回来数据后再给它
//   请求到数据后 reloadData


//TODO:  nil  指的是一个指向空内容的指针
//空指针 野指针 指向了一个不存在的内存 会造成崩溃

       FileInfoModel *fileInfo = nil;
    if (collectionView == self.leftCollection) {

        fileInfo = [self.fileListModel.pub_file objectAtIndex:indexPath.row];
        cell.fileInfo  = fileInfo;

        return cell;
    }


    return nil;
}


#pragma mark -
#pragma mark colletionDelegte

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FileInfoModel *infoModel = nil;


    infoModel = [self.fileListModel.pub_file objectAtIndex:indexPath.row];
    NSLog(@"%@",infoModel.tname);


    if (infoModel.downLoadType == FileModelUnDownLoad) {
        //  下载
        [[FileManager sharManager] downLoadFile:infoModel];
    }else if(infoModel.downLoadType == FileModelDownLoading){
        NSLog(@"正在下载"); //也可以增加暂停
    }else if(infoModel.downLoadType == FileModelDownLoaded)
    {
//        增加push操作
//        需要把model对象传过去
        FileInfoViewController *controller = [[FileInfoViewController alloc]init];
        controller.infoModel = infoModel;
        [self.navigationController pushViewController:controller animated:YES];
    }


}














@end
