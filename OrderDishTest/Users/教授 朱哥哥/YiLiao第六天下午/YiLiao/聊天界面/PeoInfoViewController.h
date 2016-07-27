//
//  PeoInfoViewController.h
//  YiLiao
//
//  Created by MrCheng on 16/3/18.
//  Copyright © 2016年 zhiYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeoInfoViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    __weak IBOutlet UIImageView *_headerImgView;

    __weak IBOutlet UILabel *_nameLabel;

    __weak IBOutlet UITextField *_nickNameField;
    
    
    __weak IBOutlet UITextField *_emailField;
    
    __weak IBOutlet UIButton *_confirmBtn;
    
}

@property (nonatomic,retain)ZYPeople *p;
@property (nonatomic,assign)BOOL isSelf;








@end
