package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

func main() {
	fmt.Println("Day 5")

	part1("./test_data.txt")
}

func part1(filePath string) {
	fmt.Println("Part 1")


	crateData := make(map[int][]string)
	moveData := make(map[int][][]int)

	buildData(filePath, crateData, moveData)

	fmt.Println(crateData)
	fmt.Println(moveData)
}

func buildData (filePath string, crateData map[int][]string, moveData map[int][][]int) {
	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	crateDataMode := true

	for i, line := range lines {
		if strings.Contains(line, "1") { // The column numbers are the first indicators that we are done with crates
			crateDataMode = false
		}
		if crateDataMode {
			buildCrateData(line, crateData)
		} else {
			if strings.Contains(line, "move") {
				moveData[i] = append(moveData[i], buildMoveData(line))
				buildMoveData(line)
			}
		}
	}
}

func buildMoveData(line string) []int{
	/*
	  Build move data using the pattern that commands always go:
	    move --> from --> to
		So we can always assume the same indices for where these commands go
	*/
	var moveData []int

	row := strings.Split(line, " ")

	moveData = append(moveData, convertString(row[1]))
	moveData = append(moveData, convertString(row[3]))
	moveData = append(moveData, convertString(row[5]))

	return moveData
}

func convertString(st string) int {
	// Convert string to integer
	cv, err := strconv.Atoi(st)
	if err != nil {
		log.Fatalf("strconv: %s", err)
	}

	return cv
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
