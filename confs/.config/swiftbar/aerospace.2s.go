///Users/dkchrnor/.local/share/mise/shims/go run $0 $@; exit
//<swiftbar.type>streamable</swiftbar.type>

package main

import (
	"bytes"
	"fmt"
	"log"
	"net"
	"os"
	"os/exec"
	"os/signal"
	"syscall"
)

const (
	// Address for the server to listen on.
	address   = "/tmp/aerospace-bar.sock"
	aerospace = "/opt/homebrew/bin/aerospace"
)

func main() {
	l := log.New(os.Stderr, "", 0)

	socket, err := net.Listen("unix", address)
	if err != nil {
		l.Fatal(err)
	}

	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	go func() {
		<-c
		os.Remove(address)
		os.Exit(1)
	}()

	printWorkspaceLine(l, c)

	for {
		// Accept an incoming connection.
		conn, err := socket.Accept()
		if err != nil {
			c <- os.Interrupt
		}

		// Handle the connection in a separate goroutine.
		go func(conn net.Conn) {
			defer conn.Close()

			printWorkspaceLine(l, c)

		}(conn)
	}

}

func printWorkspaceLine(l *log.Logger, c chan os.Signal) {
	// Get the active monitors from aerospace using sh.
	output, err := exec.Command("sh", "-c", fmt.Sprintf("%s list-monitors --format '%%{monitor-id}'", aerospace)).Output()

	l.Println(string(output))

	if err != nil {
		l.Println(err)
		c <- os.Interrupt
	}

	// Remove newlines from the output.

	monitorIds := bytes.Split(bytes.TrimSpace(output), []byte("\n"))

	workspaceLine := []byte("")

	for idx, monitorId := range monitorIds {
		// Get non-empty workspaces for the monitor.

		output, err := exec.Command("sh", "-c", fmt.Sprintf("%s list-workspaces --monitor %s --empty no", aerospace, monitorId)).Output()

		if err != nil {
			l.Println(err)
			c <- os.Interrupt
		}

		// Remove newlines from the output.
		workspaces := bytes.ReplaceAll(output, []byte("\n"), []byte(" "))
		workspaceLine = append(workspaceLine, workspaces...)

		if idx < len(monitorIds)-1 {
			workspaceLine = append(workspaceLine, []byte("| ")...)
		}

	}

	fmt.Println("~~~")
	fmt.Println(string(workspaceLine))

}
