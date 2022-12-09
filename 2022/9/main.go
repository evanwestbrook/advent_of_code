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
	fmt.Println("Day 9")
	part1("./test.txt")
}

type Move struct {
	direction string
	steps int
}

type Rope struct {
	headPosition []int
	tailPosition []int
}

type TailPositions []string

func part1(filePath string) {
	fmt.Println("Part 1")
	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	// Initialize Rope
	rope := Rope{headPosition: []int{0,0}, tailPosition: []int{0,0}}

	// Initialize storage of unique tail positions
	tailPositions := TailPositions{stringifyTailPosition(&rope)}

	fmt.Println("Before")
	fmt.Println(tailPositions)
	fmt.Println(rope)

	// For each line
	moveRope(&rope, getMove(lines[0]), &tailPositions)
	// check and update tail position
	fmt.Println("After")
	fmt.Println(tailPositions)
	fmt.Println(rope)
}

func stringifyTailPosition(r *Rope) string {
	return strconv.Itoa(r.tailPosition[0]) + "," + strconv.Itoa(r.tailPosition[1])
}

func moveRope(r *Rope, m Move, tp *TailPositions) {
	if m.direction == "R" {
		moveRight(r, m.steps, tp)
	}

}

func moveRight(r *Rope, steps int, tp *TailPositions) {
	for i := 0; i < steps; i++ {
		// Move Head
		r.headPosition[0] = r.headPosition[0] + 1
		moveTail(r)
		updateTailPositions(r, tp)

	}
}

func updateTailPositions(r *Rope, tp *TailPositions){
	newTp := stringifyTailPosition(r)

	if !slice_contains(*tp, newTp) {
		*tp = append(*tp, stringifyTailPosition(r))
	}
}

func moveTail(r *Rope) {
	if r.headPosition[0] - r.tailPosition[0] > 1 {
		r.tailPosition[0] = r.tailPosition[0] + 1
	}
}

func slice_contains(s []string, str string) bool {
	for _, v := range s {
		if v == str {
			return true
		}
	}

	return false
}


func getMove(line string) Move{
	splitLine := strings.Split(line," ")
	dir := splitLine[0]
	steps, _ := strconv.Atoi(splitLine[1])

	return Move{dir, steps}
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
