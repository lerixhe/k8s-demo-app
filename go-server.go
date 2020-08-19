package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	fmt.Println("Lerix's k8s demo server starting...")
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("Received request from " + r.RemoteAddr)
		hostname, _ := os.Hostname()
		w.Write([]byte("You've hit " + hostname + "\n"))
	})
	http.ListenAndServe(":8080", nil)
}
