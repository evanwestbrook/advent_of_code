package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"sort"
	"strconv"
)

func main() {
	fmt.Println("Day 1")

	part1("./input_1_data.txt")
	part2("./input_1_data.txt")
}

func part2(filePath string) {
	fmt.Println("Part 2:")
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	var ec []int
	var cc int = 0

	for i, line := range lines {
		if line == "" {
			ec = append(ec, cc)
			cc = 0
		} else if i == len(lines) - 1{
			lv, err := strconv.Atoi(line)
			if err != nil {
				log.Fatalf("strconv: %s", err)
			}
			cc = cc + lv
			ec = append(ec, cc)
			cc = 0
		} else {
			lv, err := strconv.Atoi(line)
			if err != nil {
				log.Fatalf("strconv: %s", err)
			}
			cc = cc + lv
		}
	}

	sort.Sort(sort.IntSlice(ec))
	sort.Slice(ec, func(i, j int) bool {
		return ec[i] > ec[j]
  })

	fmt.Println(sum(ec[:3]))
}

func part1(filePath string) {
	fmt.Println("Part 1:")
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	var maxCalories int = 0
	var currentCalories int = 0

	for _, line := range lines {
		if line == "" {
			if currentCalories > maxCalories {
				maxCalories = currentCalories
			}
			currentCalories = 0
		} else {
			lv, err := strconv.Atoi(line)
			if err != nil {
				log.Fatalf("strconv: %s", err)
			}
			currentCalories = currentCalories + lv
		}
	}

	fmt.Println(maxCalories)
}

func parseFile(filePath string) ([]string, error) {
	f, err := os.Open(filePath)

	if err != nil {
		return nil, err
	}

	var lines []string
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}

	return lines, scanner.Err()
}

func sum(array[] int) int {
	result := 0
	for _, v := range array {
		result += v
	}

	return result
}
