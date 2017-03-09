//
//  ProjectDetailViewController.m
//  mining iQ
//
//  Created by Somnath on 10/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "ProjectDetailViewController.h"
#import "Singelton.h"
#import "DefineHeader.pch"

@interface ProjectDetailViewController () <UITableViewDelegate, UITableViewDataSource>
{
    CGSize constraintSize;
    NSMutableArray *contentArr;
    NSMutableArray *tableArr;
}

@end

@implementation ProjectDetailViewController
@synthesize strID_Carry;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tableArr = [[NSMutableArray alloc] initWithObjects:@"COMMENTARY",@"MY REMINDERS", @"MINE OWNERS", @"PROJECT BEGINEERS", @"PROJECT SUPPLIERS", nil];
    
    contentArr = [[NSMutableArray alloc] init];
    
//    NSString *str = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
//    
//    constraintSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 40, MAXFLOAT);
//    
//    CGRect messageRectLeft = [str boundingRectWithSize:constraintSize options:NSStringDrawingUsesFontLeading
//                              |NSStringDrawingUsesLineFragmentOrigin|NSLineBreakByWordWrapping|NSLineBreakByCharWrapping attributes:@{NSFontAttributeName:[UIFont fontWithName:@"OpenSans" size:12]} context:nil];
//    
//    self.headerView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 10 + 35 + 10 + 21 + 10 + messageRectLeft.size.height + 10 + 184 + 10 + 20);
//    
//    self.projectDescriptionLbl.text = str;
//    [self.projectDescriptionLbl sizeToFit];
    
    self.headerSubView.layer.cornerRadius = 4.0;
    self.headerSubView.clipsToBounds = YES;
    
    
    // =========== Adding spinner ==============
    
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

    _tbl_View.hidden=YES;
}

- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getAllProjectDetailsListing];
    
}


-(void)getAllProjectDetailsListing{
    
    
    spinnerView.hidden = NO;
    NSString *postUrlString=[NSString stringWithFormat:@"projectid=%@",strID_Carry];
    NSString *strLoginApi=[NSString stringWithFormat:@"%@%@",App_Domain_Url,ProjectDetails];
    
    [[Singelton getInstance] jsonParseWithPostMethod:^(NSDictionary* testResult){
        
        
        if ([[testResult valueForKey:@"success"] boolValue] == 1)
        {
            spinnerView.hidden = YES;
            contentArr = [[testResult objectForKey:@"details"] mutableCopy];
            NSArray *arr=[testResult objectForKey:@"details"];
            
            
            
            self.lbl_ProjectName.text=[[contentArr objectAtIndex:0] valueForKey:@"projectname"];
            
            NSString *myString =[[contentArr objectAtIndex:0] valueForKey:@"created"];
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSDate *yourDate = [dateFormatter dateFromString:myString];
            dateFormatter.dateFormat = @"MMM-yyyy";
            NSLog(@"%@",[dateFormatter stringFromDate:yourDate]);
            self.lbl_Date.text=[NSString stringWithFormat:@"%@ : %@",@"Date",[dateFormatter stringFromDate:yourDate]];
            

            self.lbl_LocationContinent.text=[[contentArr objectAtIndex:0] valueForKey:@"continentname"];
            self.lbl_Region.text=[[contentArr objectAtIndex:0] valueForKey:@"regionname"];
            self.lbl_Province.text=[[contentArr objectAtIndex:0] valueForKey:@"provincename"];
            
            if ([[[contentArr objectAtIndex:0] valueForKey:@"citiesname"]isEqual:[NSNull null]] || [[[contentArr objectAtIndex:0] valueForKey:@"citiesname"] isEqualToString:@""]) {
                self.lbl_City.text=@"N/A";
            } else {
                self.lbl_City.text=[[contentArr objectAtIndex:0] valueForKey:@"citiesname"];
            }
            
            self.lbl_ProjectArea.text=[[contentArr objectAtIndex:0] valueForKey:@"area"];
            self.lbl_CapitalValue.text=[[contentArr objectAtIndex:0] valueForKey:@"cap_value"];
            self.lbl_MineralName.text=[[contentArr objectAtIndex:0] valueForKey:@"mineralname"];
            
            
            // === ======== ============= =================
            NSString *str = [[contentArr objectAtIndex:0] valueForKey:@"projectdescription"];
            
            constraintSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 40, MAXFLOAT);
            
            CGRect messageRectLeft = [str boundingRectWithSize:constraintSize options:NSStringDrawingUsesFontLeading
                                      |NSStringDrawingUsesLineFragmentOrigin|NSLineBreakByWordWrapping|NSLineBreakByCharWrapping attributes:@{NSFontAttributeName:[UIFont fontWithName:@"OpenSans" size:12]} context:nil];
            
            self.headerView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 10 + 35 + 10 + 21 + 10 + messageRectLeft.size.height + 10 + 360 + 10 + 20);
            
            self.projectDescriptionLbl.text = str;
            [self.projectDescriptionLbl sizeToFit];

            // ============================== ============== ============
            
            
             _tbl_View.hidden=NO;
            [self.tbl_View reloadData];
            NSLog(@"url is : %lu",(unsigned long)contentArr.count);
            
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
    cell = (ProjectDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectDetailTableViewCell"];
    
    cell.backView.layer.cornerRadius = 4.0;
    cell.backView.clipsToBounds = YES;
    
    cell.contentLbl.text = [tableArr objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableArr.count;
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
