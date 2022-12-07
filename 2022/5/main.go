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
	part2("./test_data.txt")
}

func part1(filePath string) {
	fmt.Println("Part 1")

	crateData, moveData := buildData(filePath)

	var finalCrates map[int][]string

	finalCrates = processMoves(false, crateData, moveData)
	printTopCrates(finalCrates)
}

func part2(filePath string) {
	fmt.Println("Part 2")

	crateData, moveData := buildData(filePath)

	var finalCrates map[int][]string

	finalCrates = processMoves(true, crateData, moveData)
	printTopCrates(finalCrates)
}

func bulkMoveCrate(crateData map[int][]string, moveData []int) map[int][]string{
	numCrates := moveData[0]
	from := moveData[1]
	to := moveData[2]

	// Updates crates during a given action in a move
	movingCrates := crateData[from][0:numCrates]

	// Create new column for the from index not containing the crates to move
	newFromCol := crateData[from][numCrates:]

	// Create new column using the crate to move and the existing column
	var newToCol []string
	for _, crate := range movingCrates {
		newToCol = append(newToCol, crate)
	}

	for _, crate := range crateData[to] {
		newToCol = append(newToCol, crate)
	}

	newCrateData := make(map[int][]string)

	for key, value := range crateData {
		if key == from {
			newCrateData[key] = newFromCol
		} else if key == to {
			newCrateData[key] = newToCol
		} else {
			newCrateData[key] = value
		}
	}

	return newCrateData
}

func printTopCrates(crateData map[int][]string) {
	message := ""

	// Loop over length of crate stacks since maps aren't ordered and we need the answer in the correct order
	for i := 0; i < len(crateData); i++ {
		message = message + crateData[i + 1][0]
	}

	fmt.Println(message)
}

func processMoves(bulk_move bool, crateData map[int][]string, moveData [][]int) map[int][]string {

	updatedCrates := crateData

	for _, move := range moveData {
		if bulk_move {
			updatedCrates = bulkMoveCrate(updatedCrates, move)
		} else {
			updatedCrates = moveCrate(updatedCrates, move)
		}
	}

	return updatedCrates
}

func moveCrate(crateData map[int][]string, move []int) map[int][]string{
	// Processes all crates moves for a given move
	newCrates := crateData

	// For the # of crates moved in this move
	for i := 0; i < move[0]; i++ {
		newCrates = updateCrates(newCrates, move[1], move[2])
	}

	return newCrates
}

func updateCrates(crateData map[int][]string, from int, to int) map[int][]string{
	// Updates crates during a given action in a move
	movingCrate := crateData[from][0]

	// Create new column for the from index not containing the crate to move
	newFromCol := crateData[from][1:]

	// Create new column using the crate to move and the existing column
	var newToCol []string
	newToCol = append(newToCol, movingCrate)
	for _, crate := range crateData[to] {
		newToCol = append(newToCol, crate)
	}

	newCrateData := make(map[int][]string)

	for key, value := range crateData {
		if key == from {
			newCrateData[key] = newFromCol
		} else if key == to {
			newCrateData[key] = newToCol
		} else {
			newCrateData[key] = value
		}
	}

	return newCrateData
}

func buildData (filePath string) (map[int][]string, [][]int){
	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	var moveData [][]int
	crateData := make(map[int][]string)
	crateDataMode := true

	for _, line := range lines {
		if strings.Contains(line, "1") { // The column numbers are the first indicators that we are done with crates
			crateDataMode = false
		}
		if crateDataMode {
			buildCrateData(line, crateData)
		} else {
			if strings.Contains(line, "move") {
				moveData = append(moveData, buildMoveData(line))
				buildMoveData(line)
			}
		}
	}

	return crateData, moveData
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
	stackId := 1
	for _, stack := range row {
		if valCounter == 4 {
			if stack != " " {
				crateData[stackId] = append(crateData[stackId], stack)
			}
			valCounter = 0
			stackId = stackId + 1
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
