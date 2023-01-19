//
//  YMLeetCode.c
//  tata_oc
//
//  Created by yongming on 2022/1/7.
//  Copyright © 2022 yongming. All rights reserved.
//

#include "YMLeetCode.h"

int fmax(x, y) {
    return (x > y) ? x : y;
}

int lengthOfLongestSubstring(char * s) {
    char* pHead = s;
    char* pWorker = pHead + 1;
    int nLast = 0;
    int n = 1;
    while(*pHead != '\0') {
        // 检测前端区间是否重复
        int catched = 0;
        for (char* p = pHead; p != pWorker; p ++) {
            if (*p == *pWorker) {
                catched = 1;
                break;
            }
        }

        if (catched == 1 || *pWorker == '\0') {
            pHead = pWorker;
            nLast = fmax(nLast, n);
            n = 1;
        } else {
            n ++;
        }

        if (*pWorker == '\0') {
            break;
        } else {
            pWorker ++;
        }
    }
    
    return nLast;
}


