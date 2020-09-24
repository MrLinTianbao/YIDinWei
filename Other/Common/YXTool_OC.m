//
//  YXTool_OC.m
//  YueXinWenHua
//
//  Created by TiBo's Mac on 2020/5/27.
//  Copyright © 2020 TiBo's Mac. All rights reserved.
//

#import "YXTool_OC.h"

@implementation YXTool_OC

+(NSString *)tohex:(int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    return str;
}

//MARK: 编码
+(NSString *)esp:(NSString *)src{
    int i;
  
    
    NSString* tmp = @"";
 
    
    for (i=0; i<[src length]; i++) {
        unichar c  = [src characterAtIndex:(NSUInteger)i];
        
        
        if(isdigit(c)||isupper(c)|islower(c)){
            tmp = [NSString stringWithFormat:@"%@%c",tmp,c];
        }else if((int)c <256){
            tmp = [NSString stringWithFormat:@"%@%@",tmp,@"%"];
            if((int)c <16){
                tmp =[NSString stringWithFormat:@"%@%@",tmp,@"0"];
            }
            
            tmp = [NSString stringWithFormat:@"%@%@",tmp,[YXTool_OC tohex:(int)c]];
            
        }else{
            tmp = [NSString stringWithFormat:@"%@%@",tmp,@"%u"];
            tmp = [NSString stringWithFormat:@"%@%@",tmp,[YXTool_OC tohex:c]];
            
        }
        
    
    }
    
    
    return tmp;
}

+(Byte)getInt:(char)c{
    if(c>='0'&&c<='9'){
        return c-'0';
    }else if((c>='a'&&c<='f')){
        return 10+(c-'a');
    }else if((c>='A'&&c<='F')){
        return 10+(c-'A');
    }

    
    return c;
}

+(int)getIntStr:(NSString *)src andLen:(int)len{
    if(len==2){
        Byte c1 = [YXTool_OC getInt:[src characterAtIndex:(NSUInteger)0]];
        Byte c2 = [YXTool_OC getInt:[src characterAtIndex:(NSUInteger)1]];
        return ((c1&0x0f)<<4)|(c2&0x0f);
    }else{
       
        Byte c1 = [YXTool_OC getInt:[src characterAtIndex:(NSUInteger)0]];
        
        Byte c2 = [YXTool_OC getInt:[src characterAtIndex:(NSUInteger)1]];
        Byte c3 = [YXTool_OC getInt:[src characterAtIndex:(NSUInteger)2]];
        Byte c4 = [YXTool_OC getInt:[src characterAtIndex:(NSUInteger)3]];
        return( ((c1&0x0f)<<12)
               |((c2&0x0f)<<8)
               |((c3&0x0f)<<4)
               |(c4&0x0f));
    }
 
}

//MARK: 解码
+(NSString*)unesp:(NSString*)src{
    int lastPos = 0;
    int pos=0;
    unichar ch;
    NSString * tmp = @"";
    while(lastPos<src.length){
        NSRange range;
        
        range = [src rangeOfString:@"%" options:NSLiteralSearch range:NSMakeRange(lastPos, src.length-lastPos)];
        if (range.location != NSNotFound) {
            pos = (int)range.location;
        }else{
            pos = -1;
        }
        
        if(pos == lastPos){
            
            if([src characterAtIndex:(NSUInteger)(pos+1)]=='u'){
                NSString* ts = [src substringWithRange:NSMakeRange(pos+2,4)];
                
                int d = [YXTool_OC getIntStr:ts andLen:4];
                ch = (unichar)d;
                NSLog(@"%@%C",[YXTool_OC tohex:d],ch);
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%C",ch]];
             
                lastPos = pos+6;
                
            }else{
                NSString* ts = [src substringWithRange:NSMakeRange(pos+1,2)];
                int d = [YXTool_OC getIntStr:ts andLen:2];
                ch = (unichar)d;
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%C",ch]];
                lastPos = pos+3;
            }
            
        }else{
            if(pos ==-1){
                NSString* ts = [src substringWithRange:NSMakeRange(lastPos,src.length-lastPos)];
                
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%@",ts]];
                lastPos = (int)src.length;
            }else{
                NSString* ts = [src substringWithRange:NSMakeRange(lastPos,pos-lastPos)];
               
                tmp = [tmp stringByAppendingString:[NSString stringWithFormat:@"%@",ts]];
                lastPos  = pos;
            }
        }
    }
    
    return tmp;
}


@end

