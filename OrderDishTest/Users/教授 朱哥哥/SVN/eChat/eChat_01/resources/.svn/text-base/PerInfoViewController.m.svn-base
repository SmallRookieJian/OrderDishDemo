//
//  PerInfoViewController.m
//  eChat_01
//
//  Created by mac on 2016/3/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PerInfoViewController.h"
#import "UserInfoRequest.h"
#import "UIImageView+WebCache.h"
#import "Request.h"

@interface PerInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    
    __weak IBOutlet UIImageView *_imgVIewHeader;
    __weak IBOutlet UILabel *_labelName;
    
    __weak IBOutlet UITextField *_tfNickname;
    
    __weak IBOutlet UITextField *_tfEmail;
    
}
@end

@implementation PerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self myInitInterface];
    
}

- (void)myInitInterface {
    
    _labelName.text = self.model.name;
    _tfNickname.text = self.model.nickname;
    _tfEmail.text = self.model.email;
    
    if ([self.model.headerURL isEqualToString:@"null"]) {
        _imgVIewHeader.image = [UIImage imageNamed:@"head.png"];
    }
    else {
        NSLog(@"我要加载头像了");
        [_imgVIewHeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/ycs%@",_model.headerURL]]];
    }
    
    _imgVIewHeader.layer.cornerRadius = 45;
    _imgVIewHeader.layer.masksToBounds = YES;
    
    //右导航按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上传头像" style:UIBarButtonItemStylePlain target:self action:@selector(btnRightBarClicked)];
    
}

- (void)btnRightBarClicked {
    
    NSLog(@"%@",self.model.headerURL);
    
    if (![self.model.headerURL isEqualToString:@"null"]) {
        //当传到这一页的model的headerURL的值不为空的时候才执行上传头像的操作
        [Request uploadHeaderImage:_imgVIewHeader.image block:^(BOOL isSuccess) {
            
            if (isSuccess) {
                
                [APP_WIN showHUDWithText:@"上传成功" Type:ShowPhotoYes  Enabled:YES];
                
            }
            
        }];
        
    }
    else {
        NSLog(@"请选择要上传的头像");
    }
    
    
    
    
    
}
- (IBAction)btnConfirmClicked:(id)sender {
    
    NSString *nickname = _tfNickname.text;
    NSString *email = _tfEmail.text;
    
    [UserInfoRequest modifyPersonalInfoWithNickname:nickname WithEmail:email WithBlock:^(NSString *info) {
        
        [self configurateAlertControllerWithTitle:@"温馨提示" WithAlertControllerStyle:UIAlertControllerStyleAlert WithMessage:info WithActionTitle:@"OK"];
        
        
        
    }];
    
}

- (void)configurateAlertControllerWithTitle:(NSString *)title WithAlertControllerStyle:(UIAlertControllerStyle)style WithMessage:(NSString *)message WithActionTitle:(NSString *)actionTitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    if (style == UIAlertControllerStyleAlert) {
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:defaultAction];
    }
    if (style == UIAlertControllerStyleActionSheet) {
        
        
        
        UIAlertAction *actionCarmer = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点了相机");
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                //前后摄像头是否可用
//                [UIImagePickerController isCameraDeviceAvailable:]
                //相机闪关灯是否OK
                
                NSLog(@"相机可用");
                
                
            }
            
            
            
        }];
        UIAlertAction *actionAlbum = [UIAlertAction actionWithTitle:@"本地图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
                NSLog(@"本地图片可用");
                //创建ImagePickerController  对象
                UIImagePickerController *imgPickedController = [[UIImagePickerController alloc] init];
                
                
                imgPickedController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imgPickedController.delegate = self;
                imgPickedController.allowsEditing = YES;
                
                
                //在这里切换到图片挑选控制器界面
                [self presentViewController:imgPickedController animated:YES completion:nil];
                
#warning 之这里就不能用导航切换页面
                //        [self.navigationController pushViewController:imgPickedController animated:YES];
                
            }
        }];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:actionCarmer];
        [alert addAction:actionAlbum];
        [alert addAction:actionCancel];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)btnModifyHeaderImage:(id)sender {
    
    
    [self configurateAlertControllerWithTitle:@"选择图片来源" WithAlertControllerStyle:UIAlertControllerStyleActionSheet WithMessage:nil WithActionTitle:nil];
    
}


#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
//    NSLog(@"imageInfo________\n%@",info);
    UIImage *image = info[UIImagePickerControllerEditedImage];
    _imgVIewHeader.image = image;
    self.model.headerURL = @"YES";
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
