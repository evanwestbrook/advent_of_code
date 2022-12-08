package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

func main() {
	fmt.Println("Day 8")

	part1("./test_data.txt")
}

func part1(filePath string) {
	fmt.Println("Part 1")
	// Read file
	lines, err := parseFile(filePath)
	if err != nil {
		log.Fatalf("readLines: %s", err)
	}

	treeGrid := prepData(lines)
	fmt.Println(treeGrid)
	xBoundary, yBoundary := getEdgeBoundary(treeGrid)

	fmt.Println(checkVisibility(1, 2, xBoundary, yBoundary, treeGrid))

	/*var totalVisible int

	totalVisible = calcEdgeVisible(treeGrid)

	fmt.Println(totalVisible)*/
}

func getEdgeBoundary(treeGrid [][]string) (int, int){
	xBoundary := len(treeGrid[0]) / 2 // Assume always odd widths and round up
	yBoundary := len(treeGrid) / 2 // Assume always odd heights and round up

	return xBoundary, yBoundary
}

func checkVisibility(x_coord int, y_coord int, xBoundary int, yBoundary int, treeGrid [][]string) bool {

	fmt.Println(treeGrid[y_coord][x_coord])
	fmt.Println(x_coord, y_coord, xBoundary, yBoundary)
	if y_coord < yBoundary {
		fmt.Println("checked top")
		if !topVisible(x_coord, y_coord, treeGrid) {
			return false
		}
	}

	if y_coord > yBoundary {
		fmt.Println("checked bottom")
		if !bottomVisible(x_coord, y_coord, treeGrid) {
			return false
		}
	}

	if x_coord < xBoundary {
		fmt.Println("checked left")
		if !leftVisible(x_coord, y_coord, treeGrid) {
			return false
		}
	}

	if x_coord > xBoundary {
		fmt.Println("checked right")
		if !rightVisible(x_coord, y_coord, treeGrid) {
			return false
		}
	}

	return true
}

func rightVisible(x_coord int, y_coord int, treeGrid [][]string) bool {
	currXCoord := x_coord

	for i := 0; i < len(treeGrid[0]) - x_coord - 1; i++ {
		compTreeHeight := treeGrid[y_coord][currXCoord + 1]
		if compTreeHeight >= treeGrid[y_coord][x_coord] {
			return false
		} else {
			currXCoord = currXCoord + 1
		}
	}

	return true
}

func leftVisible(x_coord int, y_coord int, treeGrid [][]string) bool {
	currXCoord := x_coord

	for i := 0; i < x_coord; i++ {
		compTreeHeight := treeGrid[y_coord][currXCoord - 1]
		if compTreeHeight >= treeGrid[y_coord][x_coord] {
			return false
		} else {
			currXCoord = currXCoord - 1
		}
	}

	return true
}

func bottomVisible(x_coord int, y_coord int, treeGrid [][]string) bool {
	currYCoord := y_coord

	for i := 0; i < len(treeGrid) - y_coord - 1; i++ {
		compTreeHeight := treeGrid[currYCoord + 1][x_coord]
		if compTreeHeight >= treeGrid[y_coord][x_coord] {
			return false
		} else {
			currYCoord = currYCoord + 1
		}
	}

	return true
}

func topVisible(x_coord int, y_coord int, treeGrid [][]string) bool {
	currYCoord := y_coord

	for i := 0; i < y_coord; i++ {
		compTreeHeight := treeGrid[currYCoord - 1][x_coord]
		if compTreeHeight >= treeGrid[y_coord][x_coord] {
			return false
		} else {
			currYCoord = currYCoord - 1
		}
	}

	return true
}

func calcEdgeVisible(treeGrid [][]string) int {
	width := len(treeGrid[0])
	height := len(treeGrid)

	return width * 2 + height * 2 - 4
}

func prepData(lines []string) [][]string{
	var treeGrid [][]string
	for _, line := range lines {
		treeGrid = append(treeGrid, strings.Split(line,""))
	}

	return treeGrid
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
