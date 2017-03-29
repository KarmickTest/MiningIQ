//
//  ProjectListingUnderPhaseViewController.m
//  mining iQ
//
//  Created by Somnath on 23/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "ProjectListingUnderPhaseViewController.h"
#import "Singelton.h"
#import "DefineHeader.pch"
#import "ProjectDetailViewController.h"


@interface ProjectListingUnderPhaseViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UIView *spinnerView;
    UIActivityIndicatorView *spinner;
    NSMutableArray *subProjectsArr;
    NSString *start;
    NSString *limit;
}

@end

@implementation ProjectListingUnderPhaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    start = @"0";
    limit = @"10";
    
    /////////// for loader view
    
    spinnerView = [[UIView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width)/2 - 40, ([UIScreen mainScreen].bounds.size.height)/2 - 40, 80, 80)];
    spinnerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.9];
    spinnerView.layer.cornerRadius = 8.0f;
    spinnerView.clipsToBounds = YES;
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(round((spinnerView.frame.size.width - 25) / 2), round((spinnerView.frame.size.height - 25) / 2), 25, 25);
    spinner.color = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1];
    
    [spinner startAnimating];
    
    [spinnerView addSubview:spinner];
    
    [self.view addSubview:spinnerView];
    spinnerView.hidden = YES;
    
    //////////
    
    subProjectsArr = [[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self getttingSubProjects:start limitVal:limit];
}


-(void)getttingSubProjects:(NSString *)startVal limitVal:(NSString *)limitVal
{
    spinnerView.hidden = NO;
    
    NSString *postUrlString=[NSString stringWithFormat:@"phaseid=%@&limit_start=%@&num_records=10",self.phaseId,startVal];
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,ProjectUnderPhase];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
            
            subProjectsArr = [[testResult objectForKey:@"details"] mutableCopy];
            
            int tempStart = [start intValue] + 10;
            int tempLimit = [limit intValue] + 10;
            
            
            start = [NSString stringWithFormat:@"%d",tempStart];
            limit = [NSString stringWithFormat:@"%d",tempLimit];
            
            self.subProjectsTableView.delegate = self;
            self.subProjectsTableView.dataSource = self;
            
            [self.subProjectsTableView reloadData];
            NSLog(@"url is : %lu",(unsigned long)subProjectsArr.count);
            
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    } andString:strLoginApi andParam:postUrlString];
}
    
- (IBAction)viewMoreTapped:(id)sender {
    
    spinnerView.hidden = NO;
    NSString *postUrlString=[NSString stringWithFormat:@"phaseid=%@&limit_start=%@&num_records=10",self.phaseId,start];
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,ProjectUnderPhase];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
            
            int tempStart = [start intValue] + 10;
            int tempLimit = [limit intValue] + 10;
            
            start = [NSString stringWithFormat:@"%d",tempStart];
            limit = [NSString stringWithFormat:@"%d",tempLimit];
            
            NSInteger pos = [subProjectsArr count];
            
            NSMutableArray *nextSubProjectsArr = [[NSMutableArray alloc] init];
            nextSubProjectsArr = [[testResult objectForKey:@"details"] mutableCopy];
            
            [subProjectsArr addObjectsFromArray:nextSubProjectsArr];
            
            [self.subProjectsTableView beginUpdates];
            
            for (int k=0; k<nextSubProjectsArr.count; k++)
            {
                NSArray *insert0 = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:pos inSection:0]];
                
                [self.subProjectsTableView insertRowsAtIndexPaths:insert0 withRowAnimation:UITableViewRowAnimationBottom];
                
                pos++;
            }
            [self.subProjectsTableView endUpdates];
            
            [self.subProjectsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:nextSubProjectsArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            NSLog(@"url is : %lu",(unsigned long)nextSubProjectsArr.count);
            
        }
        else if ([[testResult valueForKey:@"success"] boolValue] == 0)
        {
            spinnerView.hidden = YES;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something went wrong... please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    } andString:strLoginApi andParam:postUrlString];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (ProjectListingUnderPhaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectListingUnderPhaseTableViewCell"];
    
    if (indexPath.row % 2 == 0)
    {
        cell.backView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        cell.backView.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1];
    }
    
    cell.projectNameLbl.text = [[subProjectsArr objectAtIndex:indexPath.row] valueForKey:@"projectname"];
    cell.dateLbl.text = [[subProjectsArr objectAtIndex:indexPath.row] valueForKey:@"created"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return subProjectsArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectDetailViewController *projdetVC= [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProjectDetailViewController"];
    projdetVC.strID_Carry = [[subProjectsArr objectAtIndex:indexPath.row] valueForKey:@"projectid"];
    // projdetVC.dic_Carry=@"";
    [self.navigationController pushViewController:projdetVC animated:YES];
}



- (IBAction)backTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
