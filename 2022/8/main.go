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

	checkVisibility(3, 3, treeGrid)

	/*var totalVisible int

	totalVisible = calcEdgeVisible(treeGrid)

	fmt.Println(totalVisible)*/
}

func checkVisibility(x_coord int, y_coord int, treeGrid [][]string) {
	fmt.Println(topVisible(x_coord, y_coord, treeGrid))
	fmt.Println(bottomVisible(x_coord, y_coord, treeGrid))
	fmt.Println(leftVisible(x_coord, y_coord, treeGrid))
	fmt.Println(rightVisible(x_coord, y_coord, treeGrid))
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
