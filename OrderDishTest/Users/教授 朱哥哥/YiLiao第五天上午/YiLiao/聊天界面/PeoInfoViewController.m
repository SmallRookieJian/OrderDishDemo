//
//  PeoInfoViewController.m
//  YiLiao
//
//  Created by MrCheng on 16/3/18.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import "PeoInfoViewController.h"

@interface PeoInfoViewController ()

@end

@implementation PeoInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_isSelf)
    {
        //自己
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"上传头像" style:UIBarButtonItemStylePlain target:self action:@selector(uploadHeaderImgBtn)];
        self.navigationItem.rightBarButtonItem = rightBtn;
    }
    else
    {
        //别人
        _confirmBtn.hidden = YES;
        _nickNameField.enabled = NO;
        _emailField.enabled = NO;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/st%@",HOST,self.p.headerUrl];
    [_headerImgView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"head.png"]];
    _nameLabel.text = self.p.name;
    _nickNameField.text = self.p.nickName;
    _emailField.text = self.p.email;

}
//上传头像
- (void)uploadHeaderImgBtn
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //判断相册是否可用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    _headerImgView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    //将头像上传到服务器
    [NetworkTool uploadHeaderImage:image block:^(BOOL isSuccess) {
        if (isSuccess)
        {
            [APP_WIN showHUDWithText:@"上传成功" Type:ShowPhotoYes Enabled:YES];
        }
    }];
}


- (IBAction)confirmChangeInfo:(id)sender
{
    [NetworkTool changeSelfInfoWithNickName:_nickNameField.text WithEmail:_emailField.text block:^(BOOL isSuccess) {
        if (isSuccess) {
            [APP_WIN showHUDWithText:@"修改成功" Type:ShowPhotoYes Enabled:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}






@end
