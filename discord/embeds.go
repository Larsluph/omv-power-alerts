package discord

import (
	"time"
)

func GeneratePowerOnEmbed() WebhookPayload {
	return WebhookPayload{
		Content: "",
		Embeds: []Embed{{
			Title:    "Power ON Event triggered",
			Color:    0x13B10B,
			Datetime: time.Now().Format(time.RFC3339),
		}},
	}
}

func GeneratePowerOffEmbed() WebhookPayload {
	return WebhookPayload{
		Content: "",
		Embeds: []Embed{{
			Title:    "Power OFF Event triggered",
			Color:    0xBA0808,
			Datetime: time.Now().Format(time.RFC3339),
		}},
	}
}

func GenerateSleepEmbed() WebhookPayload {
	return WebhookPayload{
		Content: "",
		Embeds: []Embed{{
			Title:    "Sleep Event triggered",
			Color:    0xCBA20C,
			Datetime: time.Now().Format(time.RFC3339),
		}},
	}
}

func GenerateRebootEmbed() WebhookPayload {
	return WebhookPayload{
		Content: "",
		Embeds: []Embed{{
			Title:    "Reboot Event triggered",
			Color:    0x0C4CCB,
			Datetime: time.Now().Format(time.RFC3339),
		}},
	}
}

func GenerateUnknownEmbed(alertName string) WebhookPayload {
	return WebhookPayload{
		Content: "",
		Embeds: []Embed{{
			Title:       "Unknown Event triggered",
			Description: alertName,
			Datetime:    time.Now().Format(time.RFC3339),
		}},
	}
}
