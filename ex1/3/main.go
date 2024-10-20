package main

import (
	"fmt"
)

func bubbleSort(arr []int) {
	for i := 0; i < len(arr)-1; i++ {
		for j := 0; j < len(arr)-i-1; j++ {
			if arr[j] > arr[j+1] {
				arr[j], arr[j+1] = arr[j+1], arr[j]
				fmt.Println(arr)
			}
		}
	}
}

func main() {
	var n int
	fmt.Print("Введите количество элементов массива: ")
	_, err := fmt.Scan(&n)
	if err != nil || n <= 0 {
		fmt.Println("Ошибка: необходимо ввести положительное целое число")
		return
	}

	arr := make([]int, n)

	fmt.Println("Введите элементы массива через пробел:")
	for i := 0; i < n; i++ {
		_, err := fmt.Scan(&arr[i])
		if err != nil {
			fmt.Println("Ошибка ввода. Убедитесь, что вы вводите целые числа.")
			return
		}
	}

	fmt.Println("-------------------------------\nИсходный массив: ", arr)
	fmt.Println("Процесс сортировки")
	bubbleSort(arr)
	fmt.Println("-------------------------------\nОтсортированный массив: ", arr)
}
