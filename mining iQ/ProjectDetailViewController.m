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

#import "ProjectDetailTableViewCell.h"
#import "ProjectDetailCommentaryCell.h"
#import "ProjectDetailsMineownerCell.h"
#import "ProjectDetailsRemindersCell.h"
#import "ProjectDetailProjectsuppliersCell.h"
#import "ProjectDetailProjectengineersCell.h"

@interface ProjectDetailViewController () <UITableViewDelegate, UITableViewDataSource>
{
    CGSize constraintSize;
    NSMutableArray *contentArr;
    NSMutableArray *tableArr;
    NSMutableDictionary *expansionDic;
}

@end

@implementation ProjectDetailViewController
@synthesize strID_Carry;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tableArr = [[NSMutableArray alloc] initWithObjects:@"COMMENTARY",@"MY REMINDERS", @"MINE OWNERS", @"PROJECT BEGINEERS", @"PROJECT SUPPLIERS", nil];
    
    expansionDic = [[NSMutableDictionary alloc] init];
    
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

    _tbl_View.hidden=NO;
    
    
    
    mArr_test=[[NSMutableArray alloc]init];
    [mArr_test addObject:[self.dic_Carry valueForKey:@"projectscope"]];
    [mArr_test addObject:[self.dic_Carry valueForKey:@"commentary"]];
    [mArr_test addObject:[self.dic_Carry valueForKey:@"reminders"]];
    [mArr_test addObject:[self.dic_Carry valueForKey:@"mineowners"]];
    [mArr_test addObject:[self.dic_Carry valueForKey:@"projectsuppliers"]];
    [mArr_test addObject:[self.dic_Carry valueForKey:@"projectengineers"]];
    
    
   // Arr_key = [[self.dic_Carry allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    Arr_key=[[NSArray alloc]initWithObjects:@"projectscope",@"commentary",@"reminders",@"mineowners",@"projectsuppliers",@"projectengineers", nil];
   // Arr_key = [self.dic_Carry allKeys];
    
//    self.isShowingList = [[NSMutableArray alloc]init];
//    
//    for (int i = 0; i < [Arr_key count]; i++) {
//        [self.isShowingList addObject:[NSNumber numberWithBool:NO]];
//    }
    
}

- (IBAction)backTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   // [self getAllProjectDetailsListing];
    
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

# pragma mark Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [Arr_key count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return [Arr_key objectAtIndex:section];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [UIView.alloc initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 28)];
    
    UILabel *lblTitle =[UILabel.alloc initWithFrame:CGRectMake(6, 10, viewHeader.frame.size.width-12, 25)];
    
    [lblTitle setFont:[UIFont fontWithName:@"HelveticaNeue" size:13]];//Font style
    [lblTitle setTextColor:[UIColor blackColor]];
    [lblTitle setTextAlignment:NSTextAlignmentLeft];
    [lblTitle setBackgroundColor:[UIColor redColor]];
    lblTitle.text=[Arr_key objectAtIndex:section];
    lblTitle.userInteractionEnabled=YES;
    lblTitle.tag = section;
    
    viewHeader.backgroundColor=[UIColor lightGrayColor];
    
    [viewHeader addSubview:lblTitle];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerClicked:)];
    tapGesture.cancelsTouchesInView = NO;
    [lblTitle addGestureRecognizer:tapGesture];

    
    
    return viewHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 44.0f;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    cell.backView.layer.cornerRadius = 4.0;
//    cell.backView.clipsToBounds = YES;
//    
//    cell.contentLbl.text = [tableArr objectAtIndex:indexPath.row];
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // @"projectscope",@"",@"",@"",@"",@"projectengineers",
    
    
    NSString *sectionTitle = [Arr_key objectAtIndex:indexPath.section];
    NSError *error;
    NSData *data=[[self.dic_Carry valueForKey:sectionTitle] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *sectionDetails = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"%@",sectionDetails);
    
    
    if ([sectionTitle isEqualToString:@"projectscope"])
    {
        ProjectDetailTableViewCell *cell = (ProjectDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectDetailTableViewCell"];
        
        
        cell.lbl_scope_projectName.text=[self.dic_Carry valueForKey:@"projectname"];
        
        NSString *myString =[self.dic_Carry valueForKey:@"created"];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *yourDate = [dateFormatter dateFromString:myString];
        dateFormatter.dateFormat = @"MMM-yyyy";
        NSLog(@"%@",[dateFormatter stringFromDate:yourDate]);
        cell.lbl_scope_date.text=[NSString stringWithFormat:@"%@ : %@",@"Date",[dateFormatter stringFromDate:yourDate]];
        
        
        NSString *str = [sectionDetails valueForKey:@"projectdescription"];
        
        constraintSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width - 40, MAXFLOAT);
        
        CGRect messageRectLeft = [str boundingRectWithSize:constraintSize options:NSStringDrawingUsesFontLeading
                                  |NSStringDrawingUsesLineFragmentOrigin|NSLineBreakByWordWrapping|NSLineBreakByCharWrapping attributes:@{NSFontAttributeName:[UIFont fontWithName:@"OpenSans" size:12]} context:nil];
        
        cell.lbl_scope_description.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 10 + 35 + 10 + 21 + 10 + messageRectLeft.size.height + 10 + 360 + 10 + 20);
        
        cell.lbl_scope_description.text = str;
        [cell.lbl_scope_description sizeToFit];

        
        

      //  cell.lbl_scope_description.text=NULL_TO_NIL([sectionDetails valueForKey:@"projectdescription"]);
        
        cell.lbl_scope_Continent.text=NULL_TO_NIL([sectionDetails valueForKey:@"continentname"]);
        cell.lbl_scope_Region.text=NULL_TO_NIL([sectionDetails valueForKey:@"regionname"]);
        cell.lbl_scope_country.text=NULL_TO_NIL([sectionDetails valueForKey:@"countryname"]);
        cell.lbl_scope_Province.text=NULL_TO_NIL([sectionDetails valueForKey:@"provincename"]);
        cell.lbl_scope_City.text=NULL_TO_NIL([sectionDetails valueForKey:@"citiesname"]);
        cell.lbl_scope_Projectarea.text=NULL_TO_NIL([sectionDetails valueForKey:@"area"]);
        cell.lbl_scope_NearestTown.text=NULL_TO_NIL([sectionDetails valueForKey:@"area"]);
        cell.lbl_scope_CapitalValue.text=NULL_TO_NIL([sectionDetails valueForKey:@"cap_value"]);
        cell.lbl_scope_ExplorationValue.text=@"";
        cell.lbl_scope_Mineral.text=NULL_TO_NIL([sectionDetails valueForKey:@"mineralname"]);
        cell.lbl_scope_BiMineralPlant.text=@"";
        cell.lbl_scope_MiningType.text=@"";
        
        
        return cell;

    }
    else if([sectionTitle isEqualToString:@"commentary"])
    {
        ProjectDetailCommentaryCell *cell = (ProjectDetailCommentaryCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectDetailCommentaryCell"];
        
        
        
        return cell;
    }
    else if ([sectionTitle isEqualToString:@"reminders"])
    {
        ProjectDetailsRemindersCell *cell = (ProjectDetailsRemindersCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectDetailsRemindersCell"];
        
        
        
        return cell;
    }
    else if ([sectionTitle isEqualToString:@"mineowners"])
    {
        ProjectDetailsMineownerCell *cell = (ProjectDetailsMineownerCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectDetailsMineownerCell"];
        
        
        
        return cell;
    }
    else if ([sectionTitle isEqualToString:@"projectsuppliers"])
    {
        ProjectDetailProjectsuppliersCell *cell = (ProjectDetailProjectsuppliersCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectDetailProjectsuppliersCell"];
        
        
        
        return cell;
        
    }
    else
    {
        ProjectDetailProjectengineersCell *cell = (ProjectDetailProjectengineersCell *)[tableView dequeueReusableCellWithIdentifier:@"ProjectDetailProjectengineersCell"];
        
        
        
        return cell;
    }
    
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionTitle = [Arr_key objectAtIndex:indexPath.section];
    if ([sectionTitle isEqualToString:@"projectscope"])
    {
        
       return 441.0f;
    }
    else
    {
        
       return 44.0f;
    }

    return 0.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  //  return tableArr.count;
    
//    if (isShowingList)
//    {
//        isShowingList=NO;
//        NSString *sectionTitle = [Arr_key objectAtIndex:section];
//        
//        NSError *error;
//        NSData *data=[[self.dic_Carry valueForKey:self.str_sectionName] dataUsingEncoding:NSUTF8StringEncoding];
//        
//        NSArray *sectionDetails = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error:nil];
//        
//        
//        if ([self.str_sectionName isEqualToString:@"projectscope"])
//        {
//            
//            return 1;
//        }
//        else
//        {
//            
//            return [sectionDetails count];
//        }
//
//    } else
//    {
//        return 0;
//    }
    
    
    NSString *sectionTitle = [Arr_key objectAtIndex:section];
    
    NSError *error;
    NSData *data=[[self.dic_Carry valueForKey:sectionTitle] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *sectionDetails = [NSJSONSerialization JSONObjectWithData: data options:NSJSONReadingMutableContainers error:nil];

    
    if([[expansionDic valueForKey:[NSString stringWithFormat:@"%ld",section]] isEqualToString:@"YES"])
    {
        if(section==0)
        {
             return 1;
        }
        else
        {
            return [sectionDetails count];
        }
    }
    else
        return 0;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        ///it's the first row of any section so it would be your custom section header
//        
//        ///put in your code to toggle your boolean value here
//        mybooleans[indexPath.section] = !mybooleans[indexPath.section];
//        
//        ///reload this section
//        [self.tbl_View reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
//    }
    
    NSLog(@"i am hit");
}




-(void)headerClicked:(UIGestureRecognizer *)sender
{
    
    if(![[expansionDic valueForKey:[NSString stringWithFormat:@"%ld",sender.view.tag]] isEqualToString:@"YES"])
    {
        //[sender setBackgroundImage:[UIImage imageNamed:@"top_bar"] forState:UIControlStateNormal];
//        sender.superview.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bar"]];
        
        [expansionDic setValue:@"YES" forKey:[NSString stringWithFormat:@"%ld",sender.view.tag]];
        
    }
    else
    {
        [expansionDic setValue:@"NO" forKey:[NSString stringWithFormat:@"%ld",sender.view.tag]];
        
    }
    
    [self.tbl_View reloadSections:[NSIndexSet indexSetWithIndex:sender.view.tag] withRowAnimation:UITableViewRowAnimationFade];
    
    
//    if (!isShowingList) {
//        isShowingList=YES;
//       
//        UILabel *lbl = (UILabel*)sender.view;
//        NSLog(@"header name : %@",lbl.text);
//        self.str_sectionName=lbl.text;
////         [self.tbl_View reloadData];
//        
//        [self.tbl_View reloadSections:[NSIndexSet indexSetWithIndex:lbl.tag] withRowAnimation:UITableViewRowAnimationFade];
//        
//    }else{
//        
//        isShowingList=NO;
//        
//        UILabel *lbl = (UILabel*)sender.view;
//        NSLog(@"header name : %@",lbl.text);
//        
//        [self.tbl_View reloadSections:[NSIndexSet indexSetWithIndex:lbl.tag] withRowAnimation:UITableViewRowAnimationFade];
//        
//   //     [self.tbl_View reloadData];
//    }
    
    
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
