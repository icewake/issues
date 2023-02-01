package main

import (
	"fmt"
	"os"
)

var tgs = []string{"甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"}
var dzs = []string{"子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"}

var tg_count int

func main() {
	var count int
	var key, value string

	for { //外层无线循环，只要满足“第二次出现甲子则退出
		//如果出现第二次 甲子 就退出
		for _, v := range tgs {
			key = v
			value = dizhi()
			if key == "甲" && value == "子" && count >= 2 {
				//if count == 60 {
				os.Exit(0)
			}
			count++
			fmt.Printf("[%v]==>%v%v\n", count, key, value)
		}
	}
}

func dizhi() string { //每调用一次，就返回一个
	index := (tg_count + 12) % 12
	if tg_count == 12 {
		tg_count = 0
	}
	tg_count++
	return dzs[index]
}
