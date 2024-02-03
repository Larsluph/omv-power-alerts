package discord

import (
	"bytes"
	"encoding/json"
	"io"
	"log"
	"net/http"
	"net/http/cookiejar"
	"os"
)

var cookieJar, _ = cookiejar.New(nil)
var client = &http.Client{
	Jar: cookieJar,
}

func SendWebhook(payload WebhookPayload) {
	var webhookURL = "https://discord.com/api/webhooks/" + os.Getenv("WEBHOOK_ID") + "/" + os.Getenv("WEBHOOK_TOKEN")

	reqBodyBytes, _ := json.Marshal(payload)
	req, _ := http.NewRequest(http.MethodPost, webhookURL, bytes.NewBuffer(reqBodyBytes))
	req.Header.Set("Content-Type", "application/json")

	resp, err := client.Do(req)
	if err != nil {
		log.Fatal(err)
	}
	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			log.Fatal(err)
		}
	}(resp.Body)
}
