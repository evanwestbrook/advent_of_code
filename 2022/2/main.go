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

	part1("./input_data.txt")
}

func part1(filePath string) {
	fmt.Println("Part 1:")

	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	// Score each round and track cumulative score
	var tc int = 0
	for _, line := range lines {
		tc = tc + scoreRound(line)
	}

	fmt.Println(tc)
}

func scoreRound(play string) int {
	moveWins := map[string]string{
		"A": "C",
		"B": "A",
		"C": "B",
	}
	moveTranslation := map[string]string{
		"X": "A",
		"Y": "B",
		"Z": "C",
	}
	moveScores := map[string]int{
		"A": 1,
		"B": 2,
		"C": 3,
	}
	r := 0
	ps := strings.Split(play, " ")

	if ps[0] == moveTranslation[ps[1]] {
		r = 3
	} else if moveWins[moveTranslation[ps[1]]] == ps[0] {
		r = 6
	} else {
		r = 0
	}

	return r + moveScores[moveTranslation[ps[1]]]
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
