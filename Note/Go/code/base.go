package main

import (
	"errors"
	"fmt"
)

var (
	ErrNotEven = errors.New("input is not even number")
)

// DivideByTwo 当输入是偶数时返回除以2的结果，否则报错
func DivideByTwo(a int) (int, error) {
	if a%2 != 0 {
		return 0, ErrNotEven
	}
	return a / 2, nil
}

func main() {
	// 测试偶数
	result, err := DivideByTwo(10)
	if err != nil {
		fmt.Printf("Error: %v\n", err)
	} else {
		fmt.Printf("10 / 2 = %d\n", result)
	}

	// 测试奇数
	result, err = DivideByTwo(7)
	if err != nil {
		fmt.Printf("Error: %v\n", err)
	} else {
		fmt.Printf("7 / 2 = %d\n", result)
	}

	// 测试负数偶数
	result, err = DivideByTwo(-4)
	if err != nil {
		fmt.Printf("Error: %v\n", err)
	} else {
		fmt.Printf("-4 / 2 = %d\n", result)
	}
}