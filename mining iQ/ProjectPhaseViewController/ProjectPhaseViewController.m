//
//  ProjectPhaseViewController.m
//  mining iQ
//
//  Created by Admin on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "ProjectPhaseViewController.h"
#import "Singelton.h"
#import "DefineHeader.pch"
#import "ProjectListingUnderPhaseViewController.h"

@interface ProjectPhaseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *projectPhaseArr;
    UIView *backgroundView, *spinnerView;
    UIActivityIndicatorView *spinner;
}

@end

@implementation ProjectPhaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

    [self getttingProjectPhase];
}

-(void)getttingProjectPhase
{
    spinnerView.hidden = NO;
    
    NSString *strCategoryApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,ProjectPhase];
    
    projectPhaseArr = [[NSMutableArray alloc] init];
    
    [[Singelton getInstance] jsonparse:^(NSDictionary* testResult){
    
//        NSLog(@"Category====%@",testResult);
    
        spinnerView.hidden = YES;
        
        if ([[testResult valueForKey:@"success"] boolValue]==1)
        {
            projectPhaseArr = [testResult valueForKey:@"details"];
                
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            [self.tableView reloadData];
        }
        else
        {
            
        }
    } andString:strCategoryApi];
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = (ProjectPhaseCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectPhaseCell"];
    
    if (indexPath.row % 2 == 0)
    {
        cell.cellBackView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        cell.cellBackView.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1];
    }
    
    cell.phaseNameLbl.text = [[projectPhaseArr objectAtIndex:indexPath.row] valueForKey:@"phase_name"];
    cell.phaseCountLbl.text = [NSString stringWithFormat:@"%@",[[projectPhaseArr objectAtIndex:indexPath.row] valueForKey:@"total_projects"]];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return projectPhaseArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectListingUnderPhaseViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProjectListingUnderPhaseViewController"];
    
    vc.phaseId = [[projectPhaseArr objectAtIndex:indexPath.row] valueForKey:@"phase_id"];
    [self.navigationController pushViewController:vc animated:YES];
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
