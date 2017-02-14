//
//  ProjectSearchViewController.m
//  mining iQ
//
//  Created by Somnath on 08/02/17.
//  Copyright © 2017 Anirban. All rights reserved.
//

#import "ProjectSearchViewController.h"
#import "InformationViewController.h"


@interface ProjectSearchViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    BOOL keyboardReturned;
    NSMutableArray *contentArr;
    InformationViewController *RemindersView;
}

@end

@implementation ProjectSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    RemindersView=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"InformationViewController"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    NSMutableDictionary *projectName = [[NSMutableDictionary alloc] init];
    [projectName setValue:@"Project Name" forKey:@"headingName"];
    [projectName setValue:@"Project name" forKey:@"placeholderText"];
    [projectName setValue:@"" forKey:@"imageName"];
    
    NSMutableDictionary *countries = [[NSMutableDictionary alloc] init];
    [countries setValue:@"Countries" forKey:@"headingName"];
    [countries setValue:@"Countries" forKey:@"placeholderText"];
    [countries setValue:@"" forKey:@"imageName"];
    
    NSMutableDictionary *regions = [[NSMutableDictionary alloc] init];
    [regions setValue:@"Region" forKey:@"headingName"];
    [regions setValue:@"Select all" forKey:@"placeholderText"];
    [regions setValue:@"downArrow" forKey:@"imageName"];
    
    NSMutableDictionary *country = [[NSMutableDictionary alloc] init];
    [country setValue:@"Country" forKey:@"headingName"];
    [country setValue:@"Select all" forKey:@"placeholderText"];
    [country setValue:@"downArrow" forKey:@"imageName"];
    
    NSMutableDictionary *phase = [[NSMutableDictionary alloc] init];
    [phase setValue:@"Phase" forKey:@"headingName"];
    [phase setValue:@"Select all" forKey:@"placeholderText"];
    [phase setValue:@"downArrow" forKey:@"imageName"];
    
    NSMutableDictionary *completedProjectsAfter = [[NSMutableDictionary alloc] init];
    [completedProjectsAfter setValue:@"Select Projects that were completed after" forKey:@"headingName"];
    [completedProjectsAfter setValue:@"Select date" forKey:@"placeholderText"];
    [completedProjectsAfter setValue:@"calender" forKey:@"imageName"];
    
    NSMutableDictionary *completedProjectsBefore = [[NSMutableDictionary alloc] init];
    [completedProjectsBefore setValue:@"Select Projects that were completed before" forKey:@"headingName"];
    [completedProjectsBefore setValue:@"Select date" forKey:@"placeholderText"];
    [completedProjectsBefore setValue:@"calender" forKey:@"imageName"];
    
    NSMutableDictionary *projectValue = [[NSMutableDictionary alloc] init];
    [projectValue setValue:@"Project Value" forKey:@"headingName"];
    [projectValue setValue:@"Select all" forKey:@"placeholderText"];
    [projectValue setValue:@"downArrow" forKey:@"imageName"];
    
    NSMutableDictionary *plant = [[NSMutableDictionary alloc] init];
    [plant setValue:@"Plant" forKey:@"headingName"];
    [plant setValue:@"Select all" forKey:@"placeholderText"];
    [plant setValue:@"downArrow" forKey:@"imageName"];
    
    NSMutableDictionary *type = [[NSMutableDictionary alloc] init];
    [type setValue:@"Type" forKey:@"headingName"];
    [type setValue:@"Select all" forKey:@"placeholderText"];
    [type setValue:@"downArrow" forKey:@"imageName"];
    
    NSMutableDictionary *status = [[NSMutableDictionary alloc] init];
    [status setValue:@"Status" forKey:@"headingName"];
    [status setValue:@"Select all" forKey:@"placeholderText"];
    [status setValue:@"downArrow" forKey:@"imageName"];
    
    NSMutableDictionary *minaral = [[NSMutableDictionary alloc] init];
    [minaral setValue:@"Minaral" forKey:@"headingName"];
    [minaral setValue:@"Select all" forKey:@"placeholderText"];
    [minaral setValue:@"downArrow" forKey:@"imageName"];

    NSMutableDictionary *biMinaral = [[NSMutableDictionary alloc] init];
    [biMinaral setValue:@"Bi-Minaral" forKey:@"headingName"];
    [biMinaral setValue:@"Select all" forKey:@"placeholderText"];
    [biMinaral setValue:@"downArrow" forKey:@"imageName"];
    
    
    contentArr = [[NSMutableArray alloc] initWithObjects:projectName,countries,regions,country,phase,completedProjectsAfter,completedProjectsBefore,projectValue,plant,type,status,minaral,biMinaral, nil];
    
    self.searchBtn = [self roundBtnRadious:self.searchBtn radius:2];
    self.searchMineOwnersView = [self roundViewRadious:self.searchMineOwnersView radius:2];
    self.searchProjectEngineersView = [self roundViewRadious:self.searchProjectEngineersView radius:2];
    self.searchProjectSuppliersView = [self roundViewRadious:self.searchProjectSuppliersView radius:2];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    keyboardReturned = NO;
    
    self.headerContainerView = [self roundCornersOnView:self.headerContainerView onTopLeft:YES topRight:YES bottomLeft:NO bottomRight:NO radius:4];
    
    self.footerContainerView = [self roundCornersOnView:self.footerContainerView onTopLeft:NO topRight:NO bottomLeft:YES bottomRight:YES radius:4];
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

-(UIButton *)roundBtnRadious:(UIButton *)btn radius:(NSInteger)radius
{
    btn.layer.cornerRadius = radius;
    btn.clipsToBounds = YES;
    
    return btn;
}

-(UIView *)roundViewRadious:(UIView *)view radius:(NSInteger)radius
{
    view.layer.cornerRadius = radius;
    view.clipsToBounds = YES;
    
    return view;
}



- (IBAction)backTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:textField.tag inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    keyboardReturned = YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1)
    {
        textFieldCell = (TextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextFieldTableViewCell"];
        
        textFieldCell.headingNameLbl.text = [[contentArr objectAtIndex:indexPath.row] valueForKey:@"headingName"];
        textFieldCell.textField.placeholder = [[contentArr objectAtIndex:indexPath.row] valueForKey:@"placeholderText"];
        textFieldCell.textField.tag = indexPath.row;
        
        textFieldCell.containerView.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1].CGColor;
        textFieldCell.containerView.layer.borderWidth = 1.0f;
        
        textFieldCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return textFieldCell;
    }
    else if (indexPath.row == 7)
    {
        multipleDropDownCell = (MultiPleDropDownTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MultiPleDropDownTableViewCell"];
        
        multipleDropDownCell.headingNameLbl.text = [[contentArr objectAtIndex:indexPath.row] valueForKey:@"headingName"];
        multipleDropDownCell.contentLbl.text = [[contentArr objectAtIndex:indexPath.row] valueForKey:@"placeholderText"];
        
        multipleDropDownCell.containerView1.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1].CGColor;
        multipleDropDownCell.containerView1.layer.borderWidth = 1.0f;
        
        multipleDropDownCell.containerView2.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1].CGColor;
        multipleDropDownCell.containerView2.layer.borderWidth = 1.0f;
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        UITapGestureRecognizer *singleFingerTapPrice =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        multipleDropDownCell.containerView1.userInteractionEnabled = YES;
        multipleDropDownCell.containerView2.userInteractionEnabled = YES;
        [multipleDropDownCell.containerView1 addGestureRecognizer:singleFingerTap];
        [multipleDropDownCell.containerView2 addGestureRecognizer:singleFingerTapPrice];
        
        multipleDropDownCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return multipleDropDownCell;
    }
    else
    {
        dropDownCell = (DropDownTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DropDownTableViewCell"];
        
        dropDownCell.headingNameLbl.text = [[contentArr objectAtIndex:indexPath.row] valueForKey:@"headingName"];
        dropDownCell.contentLbl.text = [[contentArr objectAtIndex:indexPath.row] valueForKey:@"placeholderText"];
    
        dropDownCell.sideImageView.image = [UIImage imageNamed:[[contentArr objectAtIndex:indexPath.row] valueForKey:@"imageName"]];
        
        dropDownCell.containerView.layer.borderColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1].CGColor;
        dropDownCell.containerView.layer.borderWidth = 1.0f;
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        dropDownCell.containerView.userInteractionEnabled = YES;
        [dropDownCell.containerView addGestureRecognizer:singleFingerTap];
        
        dropDownCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return dropDownCell;
    }
        
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contentArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0 || indexPath.row == 1)
//    {
//        
//    }
//    else
//    {
//        [self.navigationController presentViewController:RemindersView animated:YES completion:NULL];
//    }
//}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self.navigationController presentViewController:RemindersView animated:YES completion:NULL];
}


- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSLog(@"%f", [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
    
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    if(keyboardReturned==YES )
    {
        NSLog(@"1st time...");
        
        [self.view layoutIfNeeded];
        self.tableViewBottomConstant.constant = keyboardHeight;
        [self.view layoutIfNeeded];
        keyboardReturned=NO;
    }
    else if (!keyboardReturned==YES )
    {
        NSLog(@"2nd time..");
        
        [self.view layoutIfNeeded];
        self.tableViewBottomConstant.constant = 0;
        [self.view layoutIfNeeded];
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
