//
//  HomeTableViewController.m
//  NetworkingApp
//
//  Created by Jamie May on 21/07/2014.
//  Copyright (c) 2014 James May. All rights reserved.
//

#import "HomeTableViewController.h"

@interface HomeTableViewController ()

@end

@implementation HomeTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Check to see if current user is registered, if not go to log in //
    self.currentUser = [PFUser currentUser];
    if (self.currentUser) {
        NSLog(@"Current user: %@ ", self.currentUser.username);
        
    } else {
        [self performSegueWithIdentifier:@"showLogIn" sender:self];
    };

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    PFRelation *networkRelation = [[PFUser currentUser] objectForKey:@"JoinedNetworks"];
    
    // Query parse to get latest network joined
    PFQuery *query = [networkRelation query];
    [query orderByDescending:@"createdAt"];
    query.limit = 1000;
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (error) {
            NSLog (@"Error %@ %@", error, [error userInfo]);
        } else {
            self.latestNetwork = object;
            NSLog(@" %@",self.latestNetwork);
            
            // Query parse to get array of users
            PFRelation *userRelation = [self.latestNetwork objectForKey:@"JoinedUsers"];
            PFQuery *query2 = [userRelation query];
            query2.limit = 1000;
            [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (error) {
                    NSLog (@"Error %@ %@", error, [error userInfo]);
                } else {
                    self.joinedUsers = objects;
                    NSLog(@" %@",self.joinedUsers);
                    [self.tableView reloadData];
                }
                
            }];
        }
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Number of rows is the count of the number of users at event
    return [self.joinedUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PFUser *user = [self.joinedUsers objectAtIndex:indexPath.row];
    
    // Set cell name to user name
    cell.textLabel.text = [user valueForKey:@"Name"];
    // Set cell subtitle to position and company
    cell.detailTextLabel.text = [NSString stringWithFormat:@" %@ , %@",[user valueForKey:@"Position"],[user valueForKey:@"Company"]];
    // Set cell pic to user profile pic
    
    PFFile *imageFile = [user valueForKey:@"ProfilePic"];
    NSData *imageData = [imageFile getData];
    UIImage *pic = [UIImage imageWithData:imageData];
    
    cell.imageView.image = pic;
    
    return cell;
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

# pragma mark - Segue Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showQRCodeScanner"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
}

@end
