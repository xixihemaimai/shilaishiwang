//
//  WWDViewController.h
//  MyBleTest2
//
//  Created by maginawin on 14-8-11.
//  Copyright (c) 2014年 mycj.wwd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface WWDViewController : UIViewController<CBCentralManagerDelegate, CBPeripheralDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *write;
/**出货单号*/
@property (nonatomic,strong)NSString * outStr;

- (void)scanClick;
- (void)connectClick;
- (void)hideKeyboard;

-(void)wrapPrintData;
-(void) sendPrintData;
- (IBAction)connDevice:(id)sender;





@end
