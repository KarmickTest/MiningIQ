//
//  ViewController.m
//  mining iQ
//
//  Created by Anirban on 03/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "ViewController.h"
#import "DashBoardViewController.h"
@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [self.userNameTxt setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.userNameTxt.leftView = paddingView;
    self.userNameTxt.leftViewMode = UITextFieldViewModeAlways;
    self.userNameTxt.delegate=self;
    
    [self.passwordTxt setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.passwordTxt.leftView = paddingView1;
    self.passwordTxt.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTxt.delegate=self;
}
- (IBAction)goToDashboard:(id)sender {
    DashBoardViewController *dashBoard=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DashBoardViewController"];
    [self.navigationController pushViewController:dashBoard animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
