//
//  NewProjectsViewController.m
//  mining iQ
//
//  Created by Anirban on 06/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "NewProjectsViewController.h"
#import "ProjectDetailViewController.h"
#import "Singelton.h"
#import "DefineHeader.pch"
@interface NewProjectsViewController ()<UITableViewDelegate, UITableViewDataSource>{

    NSString *start;
    NSString *limit;
    UIView *spinnerView;
    UIActivityIndicatorView *spinner;
    NSMutableArray *newProjectListArray;

}


@end

@implementation NewProjectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    start = @"0";
    limit = @"8";
    
    newProjectListArray = [[NSMutableArray alloc] init];
    
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
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self getAllProjectListing:start limitVal:limit];
}

-(void)getAllProjectListing:(NSString *)startVal limitVal:(NSString *)limitVal{


    spinnerView.hidden = NO;
    NSString *postUrlString=[NSString stringWithFormat:@"limit_start=%@&num_records=%@",startVal,limitVal];
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,NewProject];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
            newProjectListArray = [[testResult objectForKey:@"details"] mutableCopy];
            int tempStart = [start intValue] + 7;
            int tempLimit = [limit intValue] + 8;
            
            
            start = [NSString stringWithFormat:@"%d",tempStart];
            limit = [NSString stringWithFormat:@"%d",tempLimit];
            
            [self.tableView reloadData];
            NSLog(@"url is : %lu",(unsigned long)newProjectListArray.count);
            
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    } andString:strLoginApi andParam:postUrlString];
    
}

- (IBAction)addMoreContent:(id)sender {
    
    
    spinnerView.hidden = NO;
    NSString *postUrlString=[NSString stringWithFormat:@"limit_start=%@&num_records=%@",start,limit];
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,NewProject];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
          
            int tempStart = [start intValue] + 7;
            int tempLimit = [limit intValue] + 8;
            
            start = [NSString stringWithFormat:@"%d",tempStart];
            limit = [NSString stringWithFormat:@"%d",tempLimit];
            
            NSInteger pos = [newProjectListArray count];
           
            NSMutableArray *nextPaymentArr = [[NSMutableArray alloc] init];
            nextPaymentArr = [[testResult objectForKey:@"details"] mutableCopy];
            
            [newProjectListArray addObjectsFromArray:nextPaymentArr];
            
            [self.tableView beginUpdates];
            
            for (int k=0; k<nextPaymentArr.count; k++)
            {
                NSArray *insert0 = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:pos inSection:0]];
                
                [self.tableView insertRowsAtIndexPaths:insert0 withRowAnimation:UITableViewRowAnimationBottom];
                
                pos++;
            }
            [self.tableView endUpdates];

            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:newProjectListArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            NSLog(@"url is : %lu",(unsigned long)newProjectListArray.count);
            
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    } andString:strLoginApi andParam:postUrlString];

    
    
}


- (IBAction)backTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (NewProjectsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NewProjectsTableViewCell"];
    
    if (indexPath.row % 2 == 0)
    {
        cell.cellBackView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        cell.cellBackView.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1];
    }
    cell.projectNameLbl.text = [[newProjectListArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.projectDateLbl.text = [[newProjectListArray objectAtIndex:indexPath.row] objectForKey:@"created_date"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newProjectListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectDetailViewController *projdetVC= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProjectDetailViewController"];
    [self.navigationController pushViewController:projdetVC animated:YES];
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 80)];
//    UIButton *viewMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width - 110, 35, 100, 35)];
//
//    return  footerView;
//}

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
