package main

import (
	"errors"
	"github.com/joho/godotenv"
	"omv-power-alerts/discord"
	"os"
)

func main() {
	if len(os.Args) != 3 {
		panic(errors.New("Invalid syntax\nSyntax: ./omv_power_alerts ALERT_NAME ENV_PATH"))
	}

	alertName := os.Args[1]
	config := os.Args[2]

	if err := godotenv.Load(config); err != nil {
		panic(errors.New("error loading env file"))
	}

	switch alertName {
	case "poweron":
		discord.SendWebhook(discord.GeneratePowerOnEmbed())
	case "poweroff":
		discord.SendWebhook(discord.GeneratePowerOffEmbed())
	case "sleep":
		discord.SendWebhook(discord.GenerateSleepEmbed())
	case "reboot":
		discord.SendWebhook(discord.GenerateRebootEmbed())
	default:
		discord.SendWebhook(discord.GenerateUnknownEmbed(alertName))
	}
}
