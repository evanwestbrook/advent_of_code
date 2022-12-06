package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

func main() {
	fmt.Println("Day 2")

	//part1("./test_data.txt")
	part2("./test_data.txt")
}

func part2(filePath string) {
	fmt.Println("Part 2:")

	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	// Score each round and track cumulative score
	var tc int = 0
	for _, line := range lines {
		ps := strings.Split(line, " ")
		tc = tc + scoreRound(ps[0], ps[1])
	}

	fmt.Println(tc)
}

func part1(filePath string) {
	fmt.Println("Part 1:")

	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	// Score each round after translating move and track cumulative score
	moveTranslation := map[string]string{
		"X": "A",
		"Y": "B",
		"Z": "C",
	}
	var tc int = 0
	for _, line := range lines {
		ps := strings.Split(line, " ")
		tc = tc + scoreRound(ps[0], moveTranslation[ps[1]])
	}

	fmt.Println(tc)
}

func scoreRound(oppPlay string, yourPlay string) int {
	moveWins := map[string]string{
		"A": "C",
		"B": "A",
		"C": "B",
	}
	moveScores := map[string]int{
		"A": 1,
		"B": 2,
		"C": 3,
	}

	r := 0

	if oppPlay == yourPlay {
		r = 3
	} else if moveWins[yourPlay] == oppPlay {
		r = 6
	} else {
		r = 0
	}

	return r + moveScores[yourPlay]
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
