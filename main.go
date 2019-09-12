package main

import (
    "os"
	"fmt"
	"log"
	"net/http"
)

// HandlerFunc1 handles basic calls
func HandlerFunc1(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "\nRelease 1.013 - %s", os.Getenv("STRICTLY_CROSSOVER"))
}

func main() {
	http.HandleFunc("/", HandlerFunc1)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
