//
//  DatabaseTool.m
//  LingDotSNote
//
//  Created by Tom-Li on 2019/11/15.
//  Copyright © 2019 Dong&Ling. All rights reserved.
//

#import "DatabaseTool.h"
#import "FMDB.h"

#import "NSData+Encryption.h"

//static NSString *FileName = @"note_";
static NSString *EncryptiohKey = @"YouAndMe";

@interface DatabaseTool()

@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) NSString *dirPath;

@end

@implementation DatabaseTool

+ (instancetype)share {
    static dispatch_once_t onceToken;
    static DatabaseTool *databaseTool = nil;
    dispatch_once(&onceToken, ^{
        databaseTool = [[DatabaseTool alloc]init];
        [databaseTool initDatabase];
        
    });
    return databaseTool;
}

- (void)initDatabase {
    
    [self createDirectorOfNote];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"temp.db"];
    NSLog(@"%@", path);
    self.db = [FMDatabase databaseWithPath:path];
    
    [self createTable];
}

- (void)createDirectorOfNote {
    self.fileManager = [NSFileManager defaultManager];
    self.dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"NoteFile"];
    
    NSError *dirCreateError = nil;
    [self.fileManager createDirectoryAtPath:self.dirPath withIntermediateDirectories:NO attributes:nil error:&dirCreateError];
    
}

- (void)createTable {
    [self.db open];
    NSString *sql = @"create table t_note_image (id integer primary key autoincrement, image_name_0 text, image_name_1 text, image_name_2 text, image_name_3 text, image_name_4 text, image_name_5 text, image_name_6 text, image_name_7 text, create_time date, update_time date);"
    "create table t_note (id integer primary key autoincrement, content text, date date, weather text, note_states integer, create_time date, update_time date, note_image_id integer, foreign key(note_image_id) references t_note_image(id));";
    
    self.success = [self.db executeStatements:sql];
    NSLog(@"done");
}

- (void)insertNoteData:(NSString *)content andImage:(nullable NSArray<UIImage *> *)imageArray andResultBlock:(void (^)(BOOL, NSString *))resultBlock {
    NSString *fileName = [self timestamp];
    NSData *encryData = [[content dataUsingEncoding:NSUTF8StringEncoding] encryptOfAES256WithKey:EncryptiohKey];

    NSString *filePath = [_dirPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt", fileName]];
    NSString *directorPath = [_dirPath stringByAppendingPathComponent:[NSString stringWithFormat:@"image_%@", fileName]];
    
    NSMutableArray *imageNameArray = [NSMutableArray array];
    BOOL dirctoryCreateFlag = NO;
    // 插入图片
    if ([imageArray count] > 0) {
        NSError *imgError;
        dirctoryCreateFlag = [_fileManager createDirectoryAtPath:directorPath withIntermediateDirectories:NO attributes:nil error:&imgError];
        if (dirctoryCreateFlag) {
            for (UIImage *tempImage in imageArray) {
                NSNumber *imageNameNumber = @(arc4random_uniform(100000));
                [imageNameArray addObject:imageNameNumber];
                
                BOOL imageFileCreateFlag = [_fileManager createFileAtPath:[NSString stringWithFormat:@"%@/%ld.png", directorPath, imageNameNumber.longValue] contents:UIImagePNGRepresentation(tempImage) attributes:nil];
                if (!imageFileCreateFlag) {
                    resultBlock(NO, @"存放图片失败");
                    return;
                }
            }
            
        } else {
            // 新建图片文件夹失败
            resultBlock(NO, @"存放图片文件夹建立失败");
            return;
        }
        
    }

    // 插入日记文本
    BOOL fileCreateFlag = [self.fileManager createFileAtPath:filePath contents:encryData attributes:nil];
    
    if (!fileCreateFlag) {
        resultBlock(NO, @"存放日记文本失败");
        return;
    }
    // 待文本和图片都能存放成功后,再存到数据库中
    if ([imageArray count] > 0) {
        NSMutableString *columnName = [NSMutableString string];
        NSMutableString *columnValue = [NSMutableString string];
        NSMutableString *sql = [NSMutableString stringWithFormat:@"insert into t_note_image ("];
        
        for (int i = 0; i < imageArray.count; i++) {
            [columnName appendFormat:@"image_name_%d, ", i];
            [columnValue appendString:@"?,"];
        }
        [sql appendString:columnName.copy];
        [sql appendString:@" create_time) values ("];
        [sql appendString:columnValue.copy];
        [sql appendString:[NSString stringWithFormat:@"?)"]];
        
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval time = [date timeIntervalSince1970];
        NSString *createTime = [NSString stringWithFormat:@"%.0f", time];
        [imageNameArray addObject:createTime];
        BOOL success = [_db executeUpdate:sql.copy withArgumentsInArray:imageNameArray];
        if (!success) {
            NSLog(@"error = %@", [_db lastErrorMessage]);
        } else {
            FMResultSet *result = [_db executeQueryWithFormat:@"select * from t_note_image where create_time = %@", createTime];
            NSString *recordId;
            while ([result next]) {
                recordId = [result stringForColumn:@"id"];
            }
            NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
            [dateFormate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            NSString *dateStr = [dateFormate stringFromDate:date];
            BOOL insertContentFlag = [_db executeUpdate:@"insert into t_note(content, date, create_time, note_image_id) values (?, ?, ?, ?);", fileName, dateStr, createTime, recordId];
            if (!insertContentFlag) {
                NSLog(@"error = %@", [_db lastErrorMessage]);
                resultBlock(NO, @"插入文件失败");
            }
            
            resultBlock(YES, @"");
        }
        
    }
    
    
    
}

- (NSArray *)readNoteData {
    FMResultSet *resultSet = [_db executeQuery:@"select t_note.* from t_note;"];
    NSMutableArray *noteArray = [NSMutableArray array];

    while (resultSet.next) {
        NSDictionary *dic = @{@"content": [resultSet stringForColumn:@"content"] == nil ? @"": [resultSet stringForColumn:@"content"]};
        [noteArray addObject:dic];
    }
    return noteArray.copy;
}

- (NSString *)timestamp {
    NSDate *currentDate = [NSDate date];
    NSString *timestampStr = [NSString stringWithFormat:@"%ld", (long)[currentDate timeIntervalSince1970] * 1000];
    return timestampStr;
}
@end
//, @"date": [resultSet dateForColumn:@"date"], @"weather": [resultSet stringForColumn:@"weather"], @"note_states": @([resultSet intForColumn:@"private_state"]), @"create_time": [resultSet dateForColumn:@"create_time"]
