package main

import (
	"bufio"
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
)

const (
	defaultGatewayURL = "http://localhost:8080"
	colorReset        = "\033[0m"
	colorGreen        = "\033[32m"
	colorYellow       = "\033[33m"
	colorRed          = "\033[31m"
	colorCyan         = "\033[36m"
)

type CommandResponse struct {
	Success   bool        `json:"success"`
	Message   string      `json:"message"`
	Data      interface{} `json:"data,omitempty"`
	CommandID string      `json:"command_id"`
	Timestamp string      `json:"timestamp"`
}

func main() {
	gatewayURL := os.Getenv("GATEWAY_URL")
	if gatewayURL == "" {
		gatewayURL = defaultGatewayURL
	}

	fmt.Println(colorCyan + "=== Realworld Simulation - Terminal Client ===" + colorReset)
	fmt.Println("Connected to:", gatewayURL)
	fmt.Println("Type 'help' for available commands, 'quit' to exit")
	fmt.Println()

	reader := bufio.NewReader(os.Stdin)

	for {
		fmt.Print(colorGreen + "> " + colorReset)
		text, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println(colorRed+"Error reading input:"+colorReset, err)
			continue
		}

		text = strings.TrimSpace(text)
		if text == "" {
			continue
		}

		if text == "quit" || text == "exit" {
			fmt.Println("Goodbye!")
			break
		}

		// Send command to gateway
		resp, err := sendCommand(gatewayURL, text)
		if err != nil {
			fmt.Println(colorRed+"Error:"+colorReset, err)
			continue
		}

		// Display response
		displayResponse(resp)
	}
}

func sendCommand(gatewayURL, text string) (*CommandResponse, error) {
	payload := map[string]string{
		"text": text,
	}

	jsonData, err := json.Marshal(payload)
	if err != nil {
		return nil, err
	}

	resp, err := http.Post(gatewayURL+"/cmd/text", "application/json", bytes.NewBuffer(jsonData))
	if err != nil {
		return nil, fmt.Errorf("failed to connect to gateway: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		body, _ := io.ReadAll(resp.Body)
		return nil, fmt.Errorf("server returned %d: %s", resp.StatusCode, string(body))
	}

	var cmdResp CommandResponse
	if err := json.NewDecoder(resp.Body).Decode(&cmdResp); err != nil {
		return nil, fmt.Errorf("failed to decode response: %w", err)
	}

	return &cmdResp, nil
}

func displayResponse(resp *CommandResponse) {
	if resp.Success {
		fmt.Println(colorGreen+"✓"+colorReset, resp.Message)
	} else {
		fmt.Println(colorRed+"✗"+colorReset, resp.Message)
	}

	if resp.Data != nil {
		// Pretty print data if available
		data, err := json.MarshalIndent(resp.Data, "", "  ")
		if err == nil {
			fmt.Println(colorYellow + string(data) + colorReset)
		}
	}

	fmt.Println()
}
