package main

import (
	"bufio"
	"fmt"
	"log"
	"math"
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

	fmt.Println("Starting")
	fmt.Println(tailPositions)
	fmt.Println(rope)

	for i, move := range lines {
		fmt.Println("Move: ", i)
		moveRope(&rope, getMove(move), &tailPositions)
		fmt.Println(rope)
	}

	fmt.Println(tailPositions)
}

func stringifyTailPosition(r *Rope) string {
	return strconv.Itoa(r.tailPosition[0]) + "," + strconv.Itoa(r.tailPosition[1])
}

func moveRope(r *Rope, m Move, tp *TailPositions) {
	if m.direction == "R" {
		moveRight(r, m.steps, tp)
	} else if m.direction == "U" {
		moveUp(r, m.steps, tp)
	} else if m.direction == "L" {
		moveLeft(r, m.steps, tp)
	} else if m.direction == "D" {
		moveDown(r, m.steps, tp)
	}
}

func moveDown(r *Rope, steps int, tp *TailPositions) {
	for i := 0; i < steps; i++ {
		// Move Head
		r.headPosition[1] = r.headPosition[1] - 1
		moveTail(r)
		updateTailPositions(r, tp)
	}
}

func moveLeft(r *Rope, steps int, tp *TailPositions) {
	for i := 0; i < steps; i++ {
		// Move Head
		r.headPosition[0] = r.headPosition[0] - 1
		moveTail(r)
		updateTailPositions(r, tp)
	}
}

func moveUp(r *Rope, steps int, tp *TailPositions) {
	for i := 0; i < steps; i++ {
		// Move Head
		r.headPosition[1] = r.headPosition[1] + 1
		moveTail(r)
		updateTailPositions(r, tp)
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

func moveTail(r *Rope) {
	// Horizontal right
	if r.headPosition[0] > r.tailPosition[0] && r.headPosition[1] == r.tailPosition[1] {
		if r.headPosition[0] - r.tailPosition[0] > 1 {
			r.tailPosition[0] = r.tailPosition[0] + 1
		}
  }

	// Horizontal left
	if r.headPosition[0] < r.tailPosition[0] && r.headPosition[1] == r.tailPosition[1] {
		if r.headPosition[0] - r.tailPosition[0] < 1 {
			r.tailPosition[0] = r.tailPosition[0] - 1
		}
  }

	// Vertical up
	if r.headPosition[0] == r.tailPosition[0] && r.headPosition[1] > r.tailPosition[1] {
		if r.headPosition[1] - r.tailPosition[1] > 1 {
			r.tailPosition[1] = r.tailPosition[1] + 1
		}
  }

	// Vertical left
	if r.headPosition[0] == r.tailPosition[0] && r.headPosition[1] < r.tailPosition[1] {
		if r.headPosition[1] - r.tailPosition[1] < 1 {
			r.tailPosition[1] = r.tailPosition[1] - 1
		}
  }

	// Diagonal
	if r.headPosition[0] != r.tailPosition[0] && r.headPosition[1] != r.tailPosition[1] {
		// If the xMove or yMove diff is > 1, that's the direction the tail will be pulled
		// Ex: if xMove == 1 and yMove > 1, the head was diagonally above the tail up and to the right
		//     this would set tail y value to x y value
		//     and tail x value to x value minus the difference
		xMove := r.headPosition[0] - r.tailPosition[0]
		yMove := r.headPosition[1] - r.tailPosition[1]

		if math.Abs(float64(xMove)) > 1 {
			r.tailPosition[1] = r.headPosition[1]
			if xMove > 0 { // moving up
				r.tailPosition[0] = r.headPosition[0] - 1
			} else {
				r.tailPosition[0] = r.headPosition[0] + 1
			}
		} else if math.Abs(float64(yMove)) > 1 {
			r.tailPosition[0] = r.headPosition[0]
			if yMove > 0 { // moving up
				r.tailPosition[1] = r.headPosition[1] - 1
			} else {
				r.tailPosition[1] = r.headPosition[1] + 1
			}
		}
	}
}

func updateTailPositions(r *Rope, tp *TailPositions){
	newTp := stringifyTailPosition(r)

	if !slice_contains(*tp, newTp) {
		*tp = append(*tp, stringifyTailPosition(r))
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
