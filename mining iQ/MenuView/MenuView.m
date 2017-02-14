//
//  MenuView.m
//  DarAlkitab
//
//  Created by Sayanta Bhowmick on 08/04/16.
//
//

#import "MenuView.h"
#import "MenuHeaderCell.h"
#import "MenuListCell.h"

#define FULLHEIGHT [UIScreen mainScreen].bounds.size.height
#define FULLWIDTH  [UIScreen mainScreen].bounds.size.width
#define MENUHEADERHEIGHT 64.0f
#define ANIMATION_DURATION	0.3f

@implementation MenuView
{
    NSMutableArray *arrMenuList;
   
}
@synthesize tblVw_Menu,DelegateMenu;

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    //Do any aditional work after this
    
    [self addMenu];
    return self;
}

-(void)addMenu{
   
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"myAccount",@"menuImage",@"My Account",@"menuName", nil];
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"projectSearches",@"menuImage",@"Project Search",@"menuName", nil];
    NSMutableDictionary *dict3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"currency",@"menuImage",@"Currency Converter",@"menuName", nil];
    NSMutableDictionary *dict4 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"myreminders",@"menuImage",@"My Reminders",@"menuName", nil];
    NSMutableDictionary *dict5 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"support",@"menuImage",@"Client Support",@"menuName", nil];
    NSMutableDictionary *dict6 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"project",@"menuImage",@"Project Phases",@"menuName", nil];
    NSMutableDictionary *dict7 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"newProjects",@"menuImage",@"New Projects",@"menuName", nil];
    NSMutableDictionary *dict8 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"recentlyupdated",@"menuImage",@"Recently Updated",@"menuName", nil];
    NSMutableDictionary *dict9 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"newsFeeds",@"menuImage",@"News Feed",@"menuName", nil];
    NSMutableDictionary *dict10 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"logout",@"menuImage",@"Logout",@"menuName", nil];
    
    arrMenuList = [[NSMutableArray alloc] initWithObjects:dict1,dict2,dict3,dict4,dict5,dict6,dict7,dict8,dict9,dict10, nil];
 
    UIView *vw_TableView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width*0.7, FULLHEIGHT)];
    vw_TableView.backgroundColor = [UIColor whiteColor];
    
    tblVw_Menu=[[UITableView alloc] initWithFrame:CGRectMake(0.0f,0.0f, self.frame.size.width*0.7, self.frame.size.height)];
    [tblVw_Menu setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tblVw_Menu setBackgroundColor:[UIColor clearColor]];
    tblVw_Menu.showsHorizontalScrollIndicator=NO;
    tblVw_Menu.showsVerticalScrollIndicator=NO;
    [self addSubview:vw_TableView];
    [vw_TableView addSubview:tblVw_Menu];
    
    tblVw_Menu.delegate=self;
    tblVw_Menu.dataSource=self;
    [tblVw_Menu reloadData];
}

#pragma mark - UITableView datasource and delegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==[arrMenuList indexOfObject:[arrMenuList firstObject]])
    {
        return 80.0f;
    }
    else
    {
        return 50.0f;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrMenuList.count;//[arrMenucontent count]+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    MenuListCell *cellList;
    MenuHeaderCell *cellHeader;
    
    if(indexPath.row==[arrMenuList indexOfObject:[arrMenuList firstObject]]){
        cellHeader = [tableView dequeueReusableCellWithIdentifier:@"MenuHeaderCell"];
        cellHeader = (MenuHeaderCell*)[[[NSBundle mainBundle]loadNibNamed:@"MenuHeaderCell" owner:self options:0]objectAtIndex:0];
        [cellHeader setSelectionStyle:UITableViewCellSelectionStyleNone];
        cellHeader.lbl_UserName.text = [[arrMenuList objectAtIndex:indexPath.row] valueForKey:@"menuName"];//@"ANDREA JAMESON";
        cellHeader.lbl_UserName.adjustsFontSizeToFitWidth = YES;
        //cellHeader.imgVw_MenuHeader.image = [UIImage imageNamed:[[arrMenuList objectAtIndex:indexPath.row] valueForKey:@"menuImage"]];
        cellHeader.imgVw_MenuHeader.layer.cornerRadius = cellHeader.imgVw_MenuHeader.frame.size.width/2;
        cellHeader.imgVw_MenuHeader.layer.borderColor = [UIColor whiteColor].CGColor;
        cellHeader.imgVw_MenuHeader.layer.borderWidth = 2.0f;
        cellHeader.imgVw_MenuHeader.layer.cornerRadius = 25.0f;
        cellHeader.imgVw_MenuHeader.layer.masksToBounds = YES;
        cellHeader.backgroundColor=[UIColor clearColor];
        return cellHeader;
    }
   
        cellList = [tableView dequeueReusableCellWithIdentifier:@"MenuListCell"];
        cellList = (MenuListCell*)[[[NSBundle mainBundle]loadNibNamed:@"MenuListCell" owner:self options:0]objectAtIndex:0];
        [cellList setSelectionStyle:UITableViewCellSelectionStyleNone];
        cellList.lbl_MenuList.text = [[arrMenuList objectAtIndex:indexPath.row] valueForKey:@"menuName"];//[arrMenucontent objectAtIndex:indexPath.row-1];
    cellList.lbl_MenuList.font = [UIFont fontWithName:@"OpenSans-Semibold" size:12];
    cellList.lbl_MenuList.textColor=[UIColor blackColor];
        cellList.imageView.image = [UIImage imageNamed:[[arrMenuList objectAtIndex:indexPath.row] valueForKey:@"menuImage"]];//[UIImage imageNamed:[arrMenuListImage objectAtIndex:indexPath.row-1]];
//        cellList.backgroundColor=[UIColor clearColor];
        return cellList;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([DelegateMenu respondsToSelector:@selector(TaponcellWithIndex:WithTitle:)])
    {
        //[DelegateMenu TaponcellWithIndex:indexPath.row WithTitle:[arrMenucontent objectAtIndex:indexPath.row-1]];
        [DelegateMenu TaponcellWithIndex:indexPath.row WithTitle:[arrMenuList objectAtIndex:indexPath.row]];
    }
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 80)];
//    return headerView;
//}



@end
