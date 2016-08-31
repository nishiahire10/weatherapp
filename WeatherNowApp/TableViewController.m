//
//  TableViewController.m
//  WeatherNowApp
//
//  Created by apple on 26/08/16.
//  Copyright © 2016 felix-its. All rights reserved.
//

#import "TableViewController.h"
#import "weatherdetails.h"
#import "TableViewCell.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _weatherarray=[[NSMutableArray alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    NSURLSessionConfiguration * congifuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession * session=[NSURLSession sessionWithConfiguration:congifuration];
    
    
     NSURL *url=[[NSBundle mainBundle]URLForResource:@"weather" withExtension:@"json"];
    
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:url];
    
    
    request.HTTPMethod=@"GET";
    
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary * dat=[dic objectForKey:@"data"];
        
        NSArray * weather=[dat objectForKey:@"weather"];
        
        for(NSDictionary * temp in weather)
        {
            weatherdetails * w1  =[[weatherdetails alloc]init];
            w1.date=[temp objectForKey:@"date"];
            
            NSArray *innerArray = [temp objectForKey:@"weatherDesc"];
            NSDictionary *innerDic = [innerArray objectAtIndex:0];
            w1.weather = [innerDic objectForKey:@"value"];
            
            
            
            NSArray * innarr=[temp objectForKey:@"weatherIconUrl"];
            NSDictionary * inndic=[innarr objectAtIndex:0];
         w1.urloficon = [inndic objectForKey:@"value"];
            
            self.url = [NSURL URLWithString:w1.urloficon];
        NSData *imgData = [NSData dataWithContentsOfURL:_url];
            
            w1.image=[NSData dataWithData:imgData];

           // NSLog(@"%@",[inndic objectForKey:@"value"]);
            
            [_weatherarray addObject:w1];
            
            
            
            
        }
        NSLog(@"%@",[_weatherarray objectAtIndex:2]);
        [self.tableView reloadData];
        
    }];
     [task resume];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _weatherarray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //cell=[cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    // Configure the cell...
   weatherdetails *temp   =[_weatherarray objectAtIndex:indexPath.row];
    cell.datelbl.text = temp.date;
    cell.weatherlbl.text=temp.weather;
    
  //  NSData *imgData = [NSData dataWithContentsOfURL:_url];
    UIImage *imageLoad = [[UIImage alloc] initWithData:temp.image];
    cell.img.image = imageLoad;
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
