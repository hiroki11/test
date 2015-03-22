//
//  ViewController.h
//  ParserSample
//
//  Created by 村松宏紀 on 2015/03/22.
//  Copyright (c) 2015年 村松宏紀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController<NSXMLParserDelegate>{
    NSString *nowTagStr;
    NSString *txtBuffer;
    NSMutableArray *dataSource;
}

@end

