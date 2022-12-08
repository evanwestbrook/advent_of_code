package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

func main() {
	fmt.Println("Day 6")
	part1("./test1_data.txt")
}

func part1(filePath string) {
	fmt.Println("Part 1")
	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	fmt.Println(findPacketMarker(lines[0]))
}

func findPacketMarker(datastream string) int {
	chars := strings.Split(datastream,"")

	// Analyze search markers until a valid one is found
	for i := range chars {
		searchMarker := createMarker(i, 4, chars)
		if validSearchMarker(searchMarker) {
			return i + 4
		}
	}

	return 0
}

func createMarker(index int, markerSize int, dataStream []string) []string{
	// Creates a marker given the starting point and marker size
	var searchMarker []string

	for i := 0; i < markerSize; i++ {
		searchMarker = append(searchMarker, dataStream[index + i])
	}

	return searchMarker
}

func validSearchMarker(searchMarker []string) bool {
	// If a search marker contains any duplicates it is not a valid search marker
	for _, char := range searchMarker {
		if slice_contains_count(searchMarker, char) > 1 {
			return false
		}
	}

	return true
}

func slice_contains_count(s []string, str string) int {
	// Count the # of times a given character appears in a search marker
	count := 0
	for _, v := range s {
		if v == str {
			count = count + 1
		}
	}

	return count
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
