#!/usr/bin/env python3
"""Waybar module: weather (Open-Meteo) + AQI, located via GeoIP (ipwho.is)."""

import json
import os
import time
import urllib.request

CACHE_DIR = os.path.expanduser("~/.cache/waybar")
LOC_CACHE = os.path.join(CACHE_DIR, "loc.json")
WX_CACHE = os.path.join(CACHE_DIR, "weather.json")
LOC_TTL = 24 * 3600

# Weather Icons glyphs: (codepoint, ink height em, ink bottom above baseline em).
# Size/rise are normalized so every condition's icon matches the 13px digit
# height (9.32px) and sits on the text baseline, without growing the bar.
ICONS = {
    "sunny":        ("\U0000e30d", 0.4451, 0.0826),
    "night_clear":  ("\U0000e32b", 0.2974, 0.1595),
    "partly":       ("\U0000e302", 0.4385, 0.1538),
    "night_partly": ("\U0000e37b", 0.3303, 0.1256),
    "cloudy":       ("\U0000e312", 0.3051, 0.1538),
    "fog":          ("\U0000e313", 0.3677, 0.0887),
    "rain":         ("\U0000e318", 0.4195, 0.0359),
    "day_rain":     ("\U0000e308", 0.5615, 0.0318),
    "snow":         ("\U0000e31a", 0.4185, 0.0369),
    "day_snow":     ("\U0000e30a", 0.5538, 0.0379),
    "showers":      ("\U0000e319", 0.4246, 0.0318),
    "thunder":      ("\U0000e31d", 0.4282, 0.0277),
    "day_thunder":  ("\U0000e30f", 0.5574, 0.0359),
}
TARGET_PX = 9.32   # digit cap height at 13px module font
MAX_PX = 20.0      # cap so the bar stays 35px tall

WMO = {
    0: ("Clear", "sunny", "night_clear"),
    1: ("Mainly clear", "partly", "night_partly"),
    2: ("Partly cloudy", "partly", "night_partly"),
    3: ("Overcast", "cloudy", "cloudy"),
    45: ("Fog", "fog", "fog"),
    48: ("Rime fog", "fog", "fog"),
    51: ("Light drizzle", "rain", "rain"),
    53: ("Drizzle", "rain", "rain"),
    55: ("Heavy drizzle", "rain", "rain"),
    56: ("Freezing drizzle", "rain", "rain"),
    57: ("Freezing drizzle", "rain", "rain"),
    61: ("Slight rain", "day_rain", "rain"),
    63: ("Rain", "day_rain", "rain"),
    65: ("Heavy rain", "day_rain", "rain"),
    66: ("Freezing rain", "day_rain", "rain"),
    67: ("Freezing rain", "day_rain", "rain"),
    71: ("Slight snow", "day_snow", "snow"),
    73: ("Snow", "day_snow", "snow"),
    75: ("Heavy snow", "day_snow", "snow"),
    77: ("Snow grains", "snow", "snow"),
    80: ("Rain showers", "showers", "showers"),
    81: ("Rain showers", "showers", "showers"),
    82: ("Violent showers", "showers", "showers"),
    85: ("Snow showers", "snow", "snow"),
    86: ("Snow showers", "snow", "snow"),
    95: ("Thunderstorm", "day_thunder", "thunder"),
    96: ("Thunderstorm, hail", "day_thunder", "thunder"),
    99: ("Thunderstorm, hail", "day_thunder", "thunder"),
}

AQI_LABELS = [
    (20, "Good"), (40, "Fair"), (60, "Moderate"),
    (80, "Poor"), (100, "Very poor"), (10**9, "Extremely poor"),
]


def icon_span(key):
    ch, ratio, bottom = ICONS[key]
    px = min(TARGET_PX / ratio, MAX_PX)
    shift = -0.13 - bottom * px  # px to move icon down (digit ink bottom)
    return (
        "<span font_family='FiraCode Nerd Font Mono' size='%d' rise='%d'>%s</span>"
        % (round(px * 768), round(shift * 768), ch)
    )


def fetch(url):
    req = urllib.request.Request(url, headers={"User-Agent": "waybar-weather"})
    with urllib.request.urlopen(req, timeout=6) as resp:
        return json.load(resp)


def cache_read(path):
    try:
        with open(path, encoding="utf-8") as fh:
            return json.load(fh)
    except (OSError, ValueError):
        return None


def cache_write(path, data):
    os.makedirs(CACHE_DIR, exist_ok=True)
    with open(path, "w", encoding="utf-8") as fh:
        json.dump(data, fh)


def location():
    loc = cache_read(LOC_CACHE)
    if loc and time.time() - loc.get("ts", 0) < LOC_TTL:
        return loc
    try:
        geo = fetch("https://ipwho.is/")
        loc = {
            "lat": geo["latitude"], "lon": geo["longitude"],
            "city": geo.get("city") or geo.get("country") or "",
            "ts": time.time(),
        }
        cache_write(LOC_CACHE, loc)
        return loc
    except Exception:
        return loc


def aqi_label(value):
    for limit, label in AQI_LABELS:
        if value <= limit:
            return label
    return "Unknown"


def main():
    loc = location()
    if not loc:
        return {"text": "", "tooltip": "Weather: no location"}
    lat, lon = loc["lat"], loc["lon"]
    current = (
        "temperature_2m,apparent_temperature,relative_humidity_2m,"
        "precipitation,weather_code,wind_speed_10m,is_day"
    )
    try:
        wx = fetch(
            f"https://api.open-meteo.com/v1/forecast?latitude={lat}&longitude={lon}"
            f"&current={current}&timezone=auto"
        )["current"]
        aqi = fetch(
            f"https://air-quality-api.open-meteo.com/v1/air-quality?latitude={lat}"
            f"&longitude={lon}&current=european_aqi,pm2_5,pm10&timezone=auto"
        )["current"]
        cache_write(WX_CACHE, {"wx": wx, "aqi": aqi, "city": loc["city"]})
    except Exception:
        cached = cache_read(WX_CACHE)
        if not cached:
            return {"text": "", "tooltip": "Weather unavailable"}
        wx, aqi = cached["wx"], cached["aqi"]
        loc = dict(loc, city=cached.get("city", loc.get("city", "")))

    code = wx["weather_code"]
    desc, day_key, night_key = WMO.get(code, ("Unknown", "cloudy", "cloudy"))
    key = day_key if wx.get("is_day", 1) else night_key
    temp = round(wx["temperature_2m"])
    feels = round(wx["apparent_temperature"])
    eu = aqi.get("european_aqi")

    text = f"{icon_span(key)} {temp}°C"
    lines = [
        f"<b>{loc['city']}</b>",
        f"{desc} · {temp}° (feels {feels}°)",
        f"Humidity {wx['relative_humidity_2m']}% · Wind {wx['wind_speed_10m']} km/h"
        f" · Precip {wx['precipitation']} mm",
    ]
    if eu is not None:
        lines.append(
            f"<b>AQI {eu}</b> ({aqi_label(eu)}) · "
            f"PM2.5 {aqi['pm2_5']} · PM10 {aqi['pm10']} µg/m³"
        )
    return {"text": text, "tooltip": "\n".join(lines)}


if __name__ == "__main__":
    print(json.dumps(main(), ensure_ascii=False))
