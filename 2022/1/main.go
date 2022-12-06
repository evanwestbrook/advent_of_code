package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	fmt.Println("Day 1")

	part1("./input_1_data.txt")
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
