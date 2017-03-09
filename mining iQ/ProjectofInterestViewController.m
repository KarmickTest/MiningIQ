//
//  ProjectofInterestViewController.m
//  mining iQ
//
//  Created by Karmick on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "ProjectofInterestViewController.h"
#import "ProjectofInterestCell.h"
#import "Singelton.h"
#import "DefineHeader.pch"
#import "Global_Header.h"


@interface ProjectofInterestViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ProjectofInterestCell *cell;
    NSMutableArray *projectOfinterArray;
    NSString *start;
    NSString *limit;
    UIView *spinnerView;
    UIActivityIndicatorView *spinner;
}

@end

@implementation ProjectofInterestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.Project_TableView.delegate=self;
    self.Project_TableView.dataSource=self;
   
    
    start = @"0";
    limit = @"8";

    projectOfinterArray = [[NSMutableArray alloc] init];
    
    spinnerView = [[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width)/2 - 40, ([UIScreen mainScreen].bounds.size.height)/2 - 40, 80, 80)];
    spinnerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
    spinnerView.layer.cornerRadius = 8.0f;
    spinnerView.clipsToBounds = YES;
    
    /////////// for loader view
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((spinnerView.frame.size.width - 25) / 2), round((spinnerView.frame.size.height - 25) / 2), 25, 25);
    spinner.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1];
    [spinner startAnimating];
    [spinnerView addSubview:spinner];
    [self.view addSubview:spinnerView];
    spinnerView.hidden = YES;

    [self getAllInterProjectListing:start limitVal:limit];
}
-(void)getAllInterProjectListing:(NSString *)startVal limitVal:(NSString *)limitVal{
    
    
    spinnerView.hidden = NO;
    NSString *userId= @"2311`";
    // NSString *userId= [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]
    NSString *postUrlString=[NSString stringWithFormat:@"userid=%@&limit_start=%@&num_records=%@",userId,startVal,limitVal];
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,projectsOfInterestofuser];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
            projectOfinterArray = [[testResult objectForKey:@"details"] mutableCopy];
            NSLog(@"testResult..%@",projectOfinterArray);
            
            
            if(projectOfinterArray.count < [limit intValue]){
                
                self.viewMrBtn.hidden = NO;
                
            }
            int tempStart = [start intValue] + 7;
            int tempLimit = [limit intValue] + 8;
            
            start = [NSString stringWithFormat:@"%d",tempStart];
            limit = [NSString stringWithFormat:@"%d",tempLimit];
            self.userNameLbl.text = [[projectOfinterArray objectAtIndex:0] objectForKey:@"username"];
            [self.Project_TableView reloadData];
            NSLog(@"url is : %lu",(unsigned long)projectOfinterArray.count);
            
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } andString:strLoginApi andParam:postUrlString];
    
}
- (IBAction)viewMoreClicked:(id)sender {
    
    
    spinnerView.hidden = NO;
    NSString *userId= @"2311`";
    // NSString *userId= [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]
    NSString *postUrlString=[NSString stringWithFormat:@"userid=%@&limit_start=%@&num_records=%@",userId,start,limit];
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,projectsOfInterestofuser];
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
            
            int tempStart = [start intValue] + 7;
            int tempLimit = [limit intValue] + 8;
            
            start = [NSString stringWithFormat:@"%d",tempStart];
            limit = [NSString stringWithFormat:@"%d",tempLimit];
            
            NSInteger pos = [projectOfinterArray count];
            
            NSMutableArray *nextPaymentArr = [[NSMutableArray alloc] init];
            nextPaymentArr = [[testResult objectForKey:@"details"] mutableCopy];
            
            [projectOfinterArray addObjectsFromArray:nextPaymentArr];
            
            [self.Project_TableView beginUpdates];
            
            for (int k=0; k<nextPaymentArr.count; k++)
            {
                NSArray *insert0 = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:pos inSection:0]];
                
                [self.Project_TableView insertRowsAtIndexPaths:insert0 withRowAnimation:UITableViewRowAnimationBottom];
                
                pos++;
            }
            [self.Project_TableView endUpdates];
            
            [self.Project_TableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:projectOfinterArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            NSLog(@"url is : %lu",(unsigned long)projectOfinterArray.count);
            
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    } andString:strLoginApi andParam:postUrlString];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.headerView = [self roundCornersOnView:self.headerView onTopLeft:YES topRight:YES bottomLeft:NO bottomRight:NO radius:4];
    
    self.footerView = [self roundCornersOnView:self.footerView onTopLeft:NO topRight:NO bottomLeft:YES bottomRight:YES radius:4];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return projectOfinterArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell=[tableView dequeueReusableCellWithIdentifier:@"ProjectofInterestCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.demoProjectLbl.text = [[projectOfinterArray objectAtIndex:indexPath.row] objectForKey:@"projectname"];
    
    cell.btnDelete.tag=indexPath.row;
    [cell.btnDelete addTarget:self action:@selector(DeleteItem:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.btnProjectDetails.tag=indexPath.row;
    [cell.btnProjectDetails addTarget:self action:@selector(ProjectInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(UIView *)roundCornersOnView:(UIView *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius {
    
    if (tl || tr || bl || br)
    {
        UIRectCorner corner = 0; //holds the corner
        //Determine which corner(s) should be changed
        if (tl) {
            corner = corner | UIRectCornerTopLeft;
        }
        if (tr) {
            corner = corner | UIRectCornerTopRight;
        }
        if (bl) {
            corner = corner | UIRectCornerBottomLeft;
        }
        if (br) {
            corner = corner | UIRectCornerBottomRight;
        }
        
        UIView *roundedView = view;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:roundedView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = roundedView.bounds;
        maskLayer.path = maskPath.CGPath;
        roundedView.layer.mask = maskLayer;
        
        //[self.Deposit_TableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        return roundedView;
    } else {
        return view;
    }
    
}

- (IBAction)Back_btn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)ProjectInfo:(UIButton *)sender
{
    ProjectDetailViewController *projdetVC= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProjectDetailViewController"];
    projdetVC.strID_Carry = [[projectOfinterArray objectAtIndex:sender.tag] objectForKey:@"projectid"];
    [self.navigationController pushViewController:projdetVC animated:YES];

}

-(void)DeleteItem:(UIButton *)sender
{
    int index = sender.tag;
    // index = 1234;
    
   // http://karmickdev.com/miningiq/Api/deleteprojectofinterest?userid=2311&projectid=366
    NSLog(@"%@",[[projectOfinterArray objectAtIndex:sender.tag] objectForKey:@"projectid"]);
    
    spinnerView.hidden = NO;
    NSString *userId= @"2311`";
    // NSString *userId= [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]
    NSString *postUrlString=[NSString stringWithFormat:@"userid=%@&projectid=%@",userId,[[projectOfinterArray objectAtIndex:sender.tag] objectForKey:@"projectid"]];
    
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,deleteProjectOfInterest];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
            
            
            UIAlertController * alert=[UIAlertController
                                       
                                       alertControllerWithTitle:@"Status" message:[testResult valueForKey:@"message"]preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                           //What we write here????????**
                                            
                                            
                                            start = @"0";
                                            limit = @"8";
                                            [self getAllInterProjectListing:start limitVal:limit];

                                            // call method whatever u need
                                        }];
//            UIAlertAction* noButton = [UIAlertAction
//                                       actionWithTitle:@"No, thanks"
//                                       style:UIAlertActionStyleDefault
//                                       handler:^(UIAlertAction * action)
//                                       {
//                                           //What we write here????????**
//                                           
//                                           
//                                           NSLog(@"you pressed No, thanks button");
//                                           // call method whatever u need
//                                           
//                                       }];
            
            [alert addAction:yesButton];
           // [alert addAction:noButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
            
            
            
//            projectOfinterArray = [[testResult objectForKey:@"details"] mutableCopy];
//            NSLog(@"testResult..%@",projectOfinterArray);
//            
//            
//            if(projectOfinterArray.count < [limit intValue]){
//                
//                self.viewMrBtn.hidden = NO;
//                
//            }
//            int tempStart = [start intValue] + 7;
//            int tempLimit = [limit intValue] + 8;
//            
//            start = [NSString stringWithFormat:@"%d",tempStart];
//            limit = [NSString stringWithFormat:@"%d",tempLimit];
//            self.userNameLbl.text = [[projectOfinterArray objectAtIndex:0] objectForKey:@"username"];
//            [self.Project_TableView reloadData];
//            NSLog(@"url is : %lu",(unsigned long)projectOfinterArray.count);
//            
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } andString:strLoginApi andParam:postUrlString];

    
    
    
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
