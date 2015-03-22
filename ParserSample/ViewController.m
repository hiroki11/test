//
//  ViewController.m
//  ParserSample
//
//  Created by 村松宏紀 on 2015/03/22.
//  Copyright (c) 2015年 村松宏紀. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     dataSource = [NSMutableArray array];
    
    //URLを指定してXMLパーサーを作る
    [self setXMLParser];

}

//URLを指定してXMLパーサーを作る
- (void)setXMLParser
{
    //XMLを読み込む
    NSURL *myURL = [NSURL URLWithString:@"http://localhost/CountryLanguage.xml"];
    //XMLパーサを初期化
    NSXMLParser *myParser = [[NSXMLParser alloc] initWithContentsOfURL:myURL];
    //デリゲート指定
    myParser.delegate = self;
    // 解析を開始する
    [myParser parse];
}

//解析開始時の処理
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //解析中タグの初期化
    nowTagStr = @"";
}

// テキストビューに、タグ名
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    // 開始タグが「game」だったら
    if ([elementName isEqualToString:@"item"]) {
        
        // 解析中タグに設定
        nowTagStr = [NSString stringWithString:elementName];
        
        // テキストバッファの初期化
        txtBuffer = @"";
    }
}

// テキストバッファに国言語を追加する
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //解析中のタグが「item」だったら
    if ([nowTagStr isEqualToString:@"item"]) {
        
        //テキストバッファに文字を追加する
        txtBuffer = [txtBuffer stringByAppendingString:string];
    }
}

// datasorceに国言語を追加する
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    //終了タグが「item」だったら
    if ([elementName isEqualToString:@"item"]) {
        
        // datasorceに国言語を追加する
        [dataSource addObject:txtBuffer];
    }
}

/**
 * テーブルのセルの数を返す
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataSource count];
}

/**
 * 指定されたインデックスパスのセルを作成する
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // セルが作成されていないか?
    if (!cell) { // yes
        // セルを作成
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // セルにテキストを設定
    cell.textLabel.text = [dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

/**
 * セルが選択されたとき
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"「%@」が選択されました", [dataSource objectAtIndex:indexPath.row]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
