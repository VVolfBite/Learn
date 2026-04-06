package main

import (
	"fmt"
)

func non(n int) {
	fmt.Println(n)
}
func main() {

	res := func() {
		defer non(1)
		defer non(2)
		panic("panic")
		defer non(3)
	}
	res()
}
