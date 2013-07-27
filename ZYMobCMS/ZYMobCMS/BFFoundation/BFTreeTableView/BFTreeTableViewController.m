//
//  BFTreeTableViewController.m
//  OPinion
//
//  Created by ZYVincent on 12-7-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFTreeTableViewController.h"
#import "BFFirstLevelCell.h"
#import "BFSecondLevelCell.h"
#import "BFElement.h"
#import "BFTreeBaseCell.h"
#import "BFDebugUitil.h"

@interface BFTreeTableViewController ()

@end

@implementation BFTreeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        sourceArray = [[NSMutableArray alloc]init];
        BFLogObject(sourceArray);
        CGSize size = CGSizeMake(10,20);
        BFLogSize(size);
                
        for (int i=0; i<5; i++) {
            BFElement *element = [[BFElement alloc]init];
            element.content = [NSString stringWithFormat:@"item-%d",i];
            element.levelFlag = BFElementFirstLevel;
            element.subCount = 0;
            [sourceArray addObject:element];
            [element release];
        }
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [sourceArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BFElement *element = [sourceArray objectAtIndex:indexPath.row];
    
    BFMLog(sourceArray);

    if (element.levelFlag == BFElementFirstLevel) {
        static NSString *FirstCellIdentifier = @"firstCell";
        BFFirstLevelCell *cell = (BFFirstLevelCell *)[tableView dequeueReusableCellWithIdentifier:FirstCellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            
            cell = [[[BFFirstLevelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstCellIdentifier]autorelease];
        }
    [cell setLabelContent:element.content];
    return cell;
        
    }
    
    if (element.levelFlag == BFElementSecondLevel) {
        static NSString *SecondCellIdentifier = @"secondCell";
        BFSecondLevelCell *cell = (BFSecondLevelCell *)[tableView dequeueReusableCellWithIdentifier:SecondCellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            
            cell = [[[BFSecondLevelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SecondCellIdentifier]autorelease];
        }
        [cell setLabelContent:element.content];
        return cell;
    }
    return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

//在将要选中得时候改变数据源
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BFTreeBaseCell *selectCell = (BFTreeBaseCell *)cell;

    if ([cell isKindOfClass:[BFTreeBaseCell class]]) {
        if (selectCell.isExpend) {
            BFElement *element = [sourceArray objectAtIndex:indexPath.row];
            NSInteger subCount = element.subCount;
            for (int i = indexPath.row+1; i < indexPath.row + subCount+1; i++) {
                [sourceArray removeObjectAtIndex:i];
            }
            selectCell.isExpend = NO;
            
        }else {          
            NSInteger subCount = 5;
            for (int i=0; i<subCount; i++) {
                BFElement *newEle = [[BFElement alloc]init];
                newEle.content = [NSString stringWithFormat:@"secondLevel-%d",i];
                newEle.levelFlag = BFElementSecondLevel;
                newEle.subCount = 0;
                [sourceArray insertObject:newEle atIndex:indexPath.row+i+1];
                [newEle release];
            }
            BFElement *selectElement = [sourceArray objectAtIndex:indexPath.row];
            selectElement.subCount = subCount;
            selectCell.isExpend = YES;
            
           
        }
    }
    [tableView reloadData];
    return indexPath;
}


@end
