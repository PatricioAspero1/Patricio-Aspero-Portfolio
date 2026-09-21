#!/usr/bin/env python3

import os
import asyncio
import aiohttp
import discord

BOT_TOKEN = os.getenv("DISCORD_BOT_TOKEN", "")
ALLOWED_USER_ID = int(os.getenv("DISCORD_ALLOWED_USER_ID", "0"))
OLLAMA_API = os.getenv("OLLAMA_API", "http://127.0.0.1:11434/api/generate")
MODEL = os.getenv("OLLAMA_MODEL", "qwen2.5:14b")

if not BOT_TOKEN:
    raise RuntimeError("DISCORD_BOT_TOKEN is not configured.")

intents = discord.Intents.default()
intents.message_content = True
client = discord.Client(intents=intents)


async def query_ollama(prompt: str) -> str:
    payload = {
        "model": MODEL,
        "prompt": prompt,
        "stream": False,
        "options": {"num_ctx": 8192},
    }

    timeout = aiohttp.ClientTimeout(total=120)

    async with aiohttp.ClientSession(timeout=timeout) as session:
        try:
            async with session.post(OLLAMA_API, json=payload) as response:
                if response.status == 200:
                    data = await response.json()
                    return data.get("response", "I couldn't generate a response.")

                return f"Ollama returned HTTP {response.status}."
        except (aiohttp.ClientError, asyncio.TimeoutError):
            return "The local AI service is currently unavailable."


async def fetch_weather(city_name, latitude, longitude):
    params = {
        "latitude": latitude,
        "longitude": longitude,
        "current_weather": "true",
        "temperature_unit": "celsius",
        "windspeed_unit": "kmh",
        "timezone": "auto",
    }

    timeout = aiohttp.ClientTimeout(total=10)

    async with aiohttp.ClientSession(timeout=timeout) as session:
        try:
            async with session.get(
                "https://api.open-meteo.com/v1/forecast",
                params=params,
            ) as response:
                if response.status != 200:
                    return f"{city_name}: fetch failed"

                data = await response.json()
                current = data.get("current_weather", {})

                temp = current.get("temperature")
                wind = current.get("windspeed")
                code = current.get("weathercode")

                condition_map = {
                    0: "Clear",
                    1: "Mainly clear",
                    2: "Partly cloudy",
                    3: "Overcast",
                    45: "Fog",
                    51: "Light drizzle",
                    61: "Slight rain",
                    80: "Rain showers",
                }

                condition = condition_map.get(code, f"Code {code}")
                return (
                    f"{city_name}: {condition}, "
                    f"{temp} C, wind {wind} km/h"
                )

        except (aiohttp.ClientError, asyncio.TimeoutError):
            return f"{city_name}: fetch failed"


@client.event
async def on_ready():
    print(f"Logged in as {client.user}")


@client.event
async def on_message(message):
    if message.author == client.user:
        return

    # Restrict the bot to an explicitly configured Discord user.
    if ALLOWED_USER_ID and message.author.id != ALLOWED_USER_ID:
        return

    prompt = message.content.strip()
    if not prompt:
        return

    if prompt.lower().startswith("!weather"):
        # Example locations only. Configure your own in production.
        cities = {
            "city-one": (0.0, 0.0),
            "city-two": (0.0, 0.0),
        }

        parts = prompt.split(maxsplit=1)
        city = parts[1].strip().lower() if len(parts) > 1 else None

        if city and city not in cities:
            await message.reply(
                f"City not recognized. Available: {', '.join(cities.keys())}"
            )
            return

        selected = [city] if city else list(cities.keys())
        responses = []

        for item in selected:
            latitude, longitude = cities[item]
            responses.append(
                await fetch_weather(
                    item.replace("-", " ").title(),
                    latitude,
                    longitude,
                )
            )

        await message.reply("\n".join(responses))
        return

    # Future commands such as !health or !logs can be added here.

    async with message.channel.typing():
        response = await query_ollama(prompt)

        if len(response) <= 2000:
            await message.reply(response)
            return

        chunks = [
            response[index:index + 1990]
            for index in range(0, len(response), 1990)
        ]

        for chunk in chunks:
            await message.channel.send(chunk)


client.run(BOT_TOKEN)
