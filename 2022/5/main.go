package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

func main() {
	fmt.Println("Day 5")

	part1("./test_data.txt")
}

func part1(filePath string) {
	fmt.Println("Part 1")
	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	crateData := make(map[int][]string)

	crateDataMode := true

	for _, line := range lines {
		if strings.Contains(line, "1") {
			crateDataMode = false
		}
		if crateDataMode {
			buildCrateData(line, crateData)
		}
	}

	fmt.Println(crateData)
}

func buildCrateData(line string, crateData map[int][]string) {
	// Each stack contains 3 strings ([, A, ])
	// Each stack is separated by 1 space
	// Stack value = "[", val, "]", "", "[", val, "]", "", "[", val, "]"
	//                0    1   2    3    4    5    6   7    8    9    10
	// Stack value will be every 4rd value
	row := strings.Split(line,"")

	valCounter := 3 // Start at 3 so that index 1 will be picked up
	for i, stack := range row {
		if valCounter == 4 {
			crateData[i] = append(crateData[i], stack)
			valCounter = 0
		}

		valCounter = valCounter + 1
	}
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
