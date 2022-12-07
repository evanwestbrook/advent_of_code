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
	fmt.Println("Day 4")

	part1("./test_data.txt")
}

func part1(filePath string) {
	fmt.Println("Part 1")
	// Read file
	pairs, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	// For each pair, convert into integer and determine if one range fully contain the other
	totalFullyContains :=0

	for _, pair := range pairs {
		pairAssignments := parsePair(pair)
		if fullyContains(pairAssignments) {
			totalFullyContains = totalFullyContains + 1
		}
	}

	fmt.Println(totalFullyContains)
}

func fullyContains(pairAssignments [][]int) bool {
	// Determine if either assignment fully contains the other
	assignmentOne := pairAssignments[0]
	assignmentTwo := pairAssignments[1]

	// If assignment one is within assignment two
	if assignmentOne[0] >= assignmentTwo[0] && assignmentOne[1] <= assignmentTwo[1] {
		return true
	} else if assignmentOne[0] <= assignmentTwo[0] && assignmentOne[1] >= assignmentTwo[1] { // If assignment one is within assignment two
		return true
	}

	return false
}

func parsePair(pair string) [][]int{
	// Converts pair's assigments into map of ints
	var parsedPair [][]int

	assignments := strings.Split(pair,",")

	for _, assignment := range assignments {
		assignmentVals := strings.Split(assignment,"-")
		convertedAssignment := convertAssignment(assignmentVals)
		parsedPair = append(parsedPair, convertedAssignment)
	}
	return parsedPair
}

func convertAssignment(assignment []string) []int{
	// Converts string based assignment into map of integers
	var convertedAssignment []int

	for _, v := range assignment {
		convertedVal, err := strconv.Atoi(v)
		if err != nil {
			log.Fatalf("strconv: %s", err)
		}
		convertedAssignment = append(convertedAssignment, convertedVal)
	}

	return convertedAssignment
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
