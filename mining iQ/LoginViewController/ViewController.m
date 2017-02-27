//
//  ViewController.m
//  mining iQ
//
//  Created by Anirban on 03/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "ViewController.h"
#import "DashBoardViewController.h"
#import "Singelton.h"
#import "DefineHeader.pch"

@interface ViewController ()<UITextFieldDelegate, UIAlertViewDelegate>
{
    BOOL showPwdBool;
    UIView *backgroundView, *spinnerView;
    UIActivityIndicatorView *spinner;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    spinnerView = [[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width)/2 - 40, ([UIScreen mainScreen].bounds.size.height)/2 - 40, 80, 80)];
    spinnerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
    spinnerView.layer.cornerRadius = 8.0f;
    spinnerView.clipsToBounds = YES;
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((spinnerView.frame.size.width - 25) / 2), round((spinnerView.frame.size.height - 25) / 2), 25, 25);
    spinner.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1];
    
    [spinner startAnimating];
    
    [spinnerView addSubview:spinner];
    
    backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.2];
    [backgroundView addSubview:spinnerView];
    
    [self.view addSubview:backgroundView];
    backgroundView.hidden = YES;
    
    showPwdBool = true;
    
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
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    self.passwordTxt.rightView = paddingView2;
    self.passwordTxt.rightViewMode = UITextFieldViewModeAlways;
    
    self.loginBtn = [self roundRadious:self.loginBtn radius:2];
    self.registerBtn = [self roundRadious:self.registerBtn radius:2];
    self.forgotPwdBtn = [self roundRadious:self.forgotPwdBtn radius:2];
    
    self.userNameTxt = [self roundRadiousTxt:self.userNameTxt radius:2];
    self.passwordTxt = [self roundRadiousTxt:self.passwordTxt radius:2];
}

-(UIButton *)roundRadious:(UIButton *)button radius:(NSInteger)radius
{
    button.layer.cornerRadius = 2.0f;
    button.clipsToBounds = YES;
    
    return button;
}

- (IBAction)showPwdAction:(id)sender {
    
    if (showPwdBool == true)
    {
        [self.showPwdBtn setImage:[UIImage imageNamed:@"Invisible-25"] forState:UIControlStateNormal];
        self.passwordTxt.secureTextEntry = NO;
        showPwdBool = false;
    }
    else if (showPwdBool == false)
    {
        [self.showPwdBtn setImage:[UIImage imageNamed:@"Visible-25"] forState:UIControlStateNormal];
        self.passwordTxt.secureTextEntry = YES;
        showPwdBool = true;
    }
}


-(UITextField *)roundRadiousTxt:(UITextField *)textField radius:(NSInteger)radius
{
    textField.layer.cornerRadius = 2.0f;
    textField.clipsToBounds = YES;
    return textField;
}

- (IBAction)goToDashboard:(id)sender {
    
    if ([self Emailtest:self.userNameTxt.text] == true)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter a valid email id." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([self TarminateWhiteSpace:self.passwordTxt.text].length <= 5)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Password must be of six charecters." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        self.loginBtn.userInteractionEnabled = NO;
        [self sendLoginDataInPost];
    }
    
    
//    DashBoardViewController *dashBoard=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DashBoardViewController"];
//    [self.navigationController pushViewController:dashBoard animated:YES];
}

-(void)sendLoginDataInPost
{
    [self.userNameTxt resignFirstResponder];
    [self.passwordTxt resignFirstResponder];
    
    backgroundView.hidden = NO;
    
    NSString *postUrlString=[NSString stringWithFormat:@"email=%@&password=%@&deviceType=%@&deviceId=%@",self.userNameTxt.text,self.passwordTxt.text,@"iOS",[[NSUserDefaults standardUserDefaults] valueForKey:@"deviceToken"]];
    
    NSLog(@"url is : %@",postUrlString);
    
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,Login];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        backgroundView.hidden = YES;
        self.loginBtn.userInteractionEnabled = YES;
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            [[NSUserDefaults standardUserDefaults] setValue:[[testResult valueForKey:@"details"] valueForKey:@"user_id"] forKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            DashBoardViewController *dashBoard=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DashBoardViewController"];
            
            CATransition* transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 0.7f;
            transition.type =  @"rippleEffect";
            [self.navigationController.view.layer removeAllAnimations];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            
            [self.navigationController pushViewController:dashBoard animated:YES];
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        
    } andString:strLoginApi andParam:postUrlString];
}



-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return YES;
}

-(NSString *)TarminateWhiteSpace:(NSString *)Str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [Str stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}


-(BOOL)Emailtest:(NSString *)Email
{
    NSString *emailRegex = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    NSRange aRange;
    
    if([emailTest evaluateWithObject:Email]) {
        
        aRange = [Email rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [Email length])];
        
        NSInteger indexOfDot = aRange.location;
        
        //NSLog(@"aRange.location:%d - %d",aRange.location, indexOfDot);
        
        if(aRange.location != NSNotFound) {
            
            NSString *topLevelDomain = [Email substringFromIndex:indexOfDot];
            
            topLevelDomain = [topLevelDomain lowercaseString];
            
            //NSLog(@"topleveldomains:%@",topLevelDomain);
            
            NSSet *TLD;
            
            TLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            
            if(topLevelDomain != nil && ([TLD containsObject:topLevelDomain])) {
                
                //NSLog(@"TLD contains topLevelDomain:%@",topLevelDomain);
                
                return false;
                
            }
            
            /*else {
             
             NSLog(@"TLD DOEST NOT contains topLevelDomain:%@",topLevelDomain);
             
             }*/
            
        }
    }
    return true;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (IBAction)tapHighlight:(UIButton *)sender {
    
    if (sender.tag == 1)
    {
        [sender setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:11.0f/255.0f green:145.0f/255.0f blue:68.0f/255.0f alpha:1]] forState:UIControlStateHighlighted];
    }
    else if (sender.tag == 2)
    {
        [sender setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0.0f/255.0f green:145.0f/255.0f blue:239.0f/255.0f alpha:1]] forState:UIControlStateHighlighted];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
