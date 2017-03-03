//
//  MyRemindersViewController.m
//  mining iQ
//
//  Created by Admin on 08/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "MyRemindersViewController.h"
#import "MyRemindersCell.h"
#import "NewProjectsViewController.h"
#import "Singelton.h"
#import "DefineHeader.pch"
#import "addReminderViewController.h"

@interface MyRemindersViewController (){

    NSString *start;
    NSString *limit;
    UIView *spinnerView;
    UIActivityIndicatorView *spinner;
    NSMutableArray *newReminderListArray;

}

@end

@implementation MyRemindersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    start = @"0";
    limit = @"20";
    
    newReminderListArray = [[NSMutableArray alloc] init];
    
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
     [self getAllReminderListing:start limitVal:limit];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.topHeaderView = [self roundCornersOnView:self.topHeaderView onTopLeft:YES topRight:YES bottomLeft:NO bottomRight:NO radius:4];
    
    self.footerView = [self roundCornersOnView:self.footerView onTopLeft:NO topRight:NO bottomLeft:YES bottomRight:YES radius:4];
   
}
- (IBAction)addNewReminder:(id)sender {
    
 
    addReminderViewController *projdetVC= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"addReminderViewController"];
    [self.navigationController pushViewController:projdetVC animated:YES];

    
}


-(void)getAllReminderListing:(NSString *)startVal limitVal:(NSString *)limitVal{
    
    
    spinnerView.hidden = NO;
    NSString *userId= @"244";
   // NSString *userId= [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]
    NSString *postUrlString=[NSString stringWithFormat:@"userid=%@&limit_start=%@&num_records=%@",userId,startVal,limitVal];
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,getMyyReminders];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        NSLog(@"testResult..%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]);
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
            newReminderListArray = [[testResult objectForKey:@"details"] mutableCopy];
            if(newReminderListArray.count < [limit intValue]){
            
                self.viewMrBtn.hidden = YES;
            
            }
            int tempStart = [start intValue] + 19;
            int tempLimit = [limit intValue] + 20;
            
            
            start = [NSString stringWithFormat:@"%d",tempStart];
            limit = [NSString stringWithFormat:@"%d",tempLimit];
//            
           [self.myReminderTbl reloadData];
            NSLog(@"url is : %lu",(unsigned long)newReminderListArray.count);
            
            
            
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } andString:strLoginApi andParam:postUrlString];
    
}

- (IBAction)btnOpenMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

# pragma mark tableview Delegates and Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return newReminderListArray.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    MyRemindersCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MyRemindersCell"];
    cell.projectLbl.text = [[newReminderListArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.dateLbl.text = [[newReminderListArray objectAtIndex:indexPath.row] objectForKey:@"created"];
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(removeReminder:) forControlEvents:UIControlEventTouchUpInside];
    cell.markAsCompletedbtn.tag = indexPath.row;
    [cell.markAsCompletedbtn addTarget:self action:@selector(markAsCompleted:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",(long)indexPath.row);
    
    if(indexPath.row == 1){
        
        NewProjectsViewController *dashBoard=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewProjectsViewController"];
        [self.navigationController pushViewController:dashBoard animated:YES];
        
    }
    else if (indexPath.row == 4){
        
//        MyRemindersViewController *RemindersView=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MyRemindersViewController"];
//        [self.navigationController pushViewController:RemindersView animated:YES];
        
        
    }
}
-(void)markAsCompleted:(UIButton *) sender {
    
    NSLog(@"Tag : %ld", (long)sender.tag);
    
    spinnerView.hidden = NO;
    NSString *userId= @"244";
    // NSString *userId= [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]
    
    //[[newReminderListArray objectAtIndex:sender.tag] objectForKey:@"id"]
    NSString *postUrlString=[NSString stringWithFormat:@"userid=%@&reminderid=%@",userId,[[newReminderListArray objectAtIndex:sender.tag] objectForKey:@"id"]];
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,markascompletedReminder];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        NSLog(@"testResult..%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]);
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
            [self.myReminderTbl beginUpdates];
            
            NSArray *insertIndexPaths = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:sender.tag inSection:0],nil];
            [self.myReminderTbl deleteRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];[self.myReminderTbl endUpdates];
            
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } andString:strLoginApi andParam:postUrlString];
    
}
- (void) removeReminder:(UIButton *) sender {
    
    NSLog(@"Tag : %ld", (long)sender.tag);
    
    spinnerView.hidden = NO;
    NSString *userId= @"244";
    // NSString *userId= [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]
    
    //[[newReminderListArray objectAtIndex:sender.tag] objectForKey:@"id"]
    NSString *postUrlString=[NSString stringWithFormat:@"userid=%@&reminderid=%@",userId,[[newReminderListArray objectAtIndex:sender.tag] objectForKey:@"id"]];
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,deleteReminder];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        NSLog(@"testResult..%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]);
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
           [self.myReminderTbl beginUpdates];
            
            NSArray *insertIndexPaths = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:sender.tag inSection:0],nil];
            [self.myReminderTbl deleteRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];[self.myReminderTbl endUpdates];

        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } andString:strLoginApi andParam:postUrlString];
    
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
