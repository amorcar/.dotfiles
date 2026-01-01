#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.12"
# dependencies = [
#   "cyclopts",
#   "speedtest-cli",
#   "pandas",
#   "matplotlib",
# ]
# ///
"""
Usage: $ monitor-wifi [monitor | plot] --help

Track ping (min, max, avg) packet loss % and upload/download speeds and plot
the results.

Data gets saved into a SQLite DB (in ~/.local/share/internet-monitor/data.db').
"""

from dataclasses import dataclass
from os import getenv
import sqlite3
import subprocess
import time
import datetime
import platform
import logging
import sys

from pathlib import Path

import speedtest  # type: ignore
import pandas as pd  # type: ignore
import matplotlib.pyplot as plt  # type: ignore
import matplotlib.dates as mdates  # type: ignore
from cyclopts import App  # type: ignore

app = App()


DATA_DIR = Path().home() / ".local/share/internet-monitor"
DB_FILENAME = "data.db"
DB_PATH = DATA_DIR / DB_FILENAME

LOG_PATH = DATA_DIR / "monitor.log"


def setup():
    DATA_DIR.mkdir(exist_ok=True, parents=True)
    logging.basicConfig(
        level=logging.DEBUG if getenv("DEBUG") else logging.INFO,
        format="%(asctime)s [%(levelname)s] %(message)s",
        handlers=[logging.FileHandler(LOG_PATH), logging.StreamHandler(sys.stdout)],
    )


def init_db():
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    c.execute("""
        CREATE TABLE IF NOT EXISTS measurements (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT NOT NULL,
            ip TEXT,
            ping_ms_avg REAL,
            ping_ms_min REAL,
            ping_ms_max REAL,
            packet_loss_percent REAL,
            download_mbps REAL,
            upload_mbps REAL
        )
    """)
    conn.commit()
    conn.close()
    logging.debug("Database initialized.")


@dataclass
class PingTestResult:
    ping_ms_avg: float | None = None
    ping_ms_min: float | None = None
    ping_ms_max: float | None = None
    packet_loss: float | None = None


def ping_test(target: str = "8.8.8.8", count: int = 10) -> PingTestResult:
    """ """
    param = "-n" if platform.system().lower() == "windows" else "-c"
    command = ["ping", param, str(count), target]
    test_result = PingTestResult()
    try:
        result = subprocess.run(command, capture_output=True, text=True, timeout=30)
        try:
            output = result.stdout.split("\n")[-3:]
        except Exception as e:
            logging.error(f"ping output parse error: {e} | {result=}")
            return test_result
        try:
            xmit_stats = output[0].split(",")
            packet_loss = float(xmit_stats[2].split("%")[0])
            test_result.packet_loss = packet_loss
        except Exception as e:
            logging.error(f"xmit_stats error: {e}. {output}")

        try:
            timing_stats = output[1].split("=")[1].split("/")
            ping_min = float(timing_stats[0])
            ping_avg = float(timing_stats[1])
            ping_max = float(timing_stats[2])

            test_result.ping_ms_min = ping_min
            test_result.ping_ms_avg = ping_avg
            test_result.ping_ms_max = ping_max

        except Exception as e:
            logging.error(f"xmit_stats error: {e}. {output}")

        return test_result

    except Exception as e:
        logging.error(f"Ping test failed: {e}")
        return test_result


@dataclass
class SpeedTestResult:
    download: float | None = None
    upload: float | None = None


def speed_test() -> SpeedTestResult:
    """ """
    try:
        st = speedtest.Speedtest()
        st.get_best_server()
        st.download(threads=4)
        st.upload(threads=4)
        download = st.results.download / 1_000_000  # bits/s → Mbps
        upload = st.results.upload / 1_000_000
        return SpeedTestResult(download=round(download, 2), upload=round(upload, 2))
    except Exception as e:
        logging.error(f"Speed test failed: {e}")
        return SpeedTestResult(None, None)


def get_ip_address() -> str | None:
    # Run the dig command
    command = [
        "dig",
        "-4",
        "TXT",
        "+short",
        "o-o.myaddr.l.google.com",
        "@ns1.google.com",
    ]
    result = subprocess.run(command, capture_output=True, text=True)

    # Get the output and remove double quotes
    if result.returncode == 0:
        # Split the result into lines and remove quotes
        output = result.stdout.strip()
        output = output.replace('"', "")  # Remove double quotes
        return output
    else:
        logging.error("Couldnt get the IP: {result=}")
        return None


def log_measurement(
    ip: str | None, ping_test_result: PingTestResult, speed_test_result: SpeedTestResult
):
    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()
    now = datetime.datetime.now().isoformat()
    c.execute(
        """
        INSERT INTO measurements (
            timestamp,
            ip,
            ping_ms_avg,
            ping_ms_min,
            ping_ms_max,
            packet_loss_percent,
            download_mbps,
            upload_mbps
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    """,
        (
            now,
            ip,
            ping_test_result.ping_ms_avg,
            ping_test_result.ping_ms_min,
            ping_test_result.ping_ms_max,
            ping_test_result.packet_loss,
            speed_test_result.download,
            speed_test_result.upload,
        ),
    )
    conn.commit()
    conn.close()
    logging.info(
        f"Logged: ping={ping_test_result.ping_ms_avg}ms, "
        f"dl={speed_test_result.download}Mbps, "
        f"ul={speed_test_result.upload}Mbps, "
        f"loss={ping_test_result.packet_loss}%"
    )


@app.command(name="monitor")
def monitor(interval: int = 60):
    """
    Run the internet monitor.

    Arguments
    ---------
    interval: int
        Use interval < 0 for a one off run
    """
    logging.info(f"Starting internet monitor (interval: {interval}s)...")
    init_db()
    while True:
        try:
            logging.info("Running tests...")
            start_time = time.monotonic()
            ip = get_ip_address()
            ip_time = time.monotonic()
            ping_result = ping_test()
            ping_time = time.monotonic()
            speed_result = speed_test()
            speed_time = time.monotonic()
            log_measurement(ip, ping_result, speed_result)
            log_time = time.monotonic()

            logging.debug(
                f"ip {(ip_time - start_time):.3f}s "
                f"ping {(ping_time - ip_time):.3f}s "
                f"speed {(speed_time - start_time):.3f}s "
                f"db {(log_time - speed_time):.3f}s"
            )
            if interval <= 0:
                break
        except KeyboardInterrupt:
            logging.info("Monitor stopped by user.")
            break
        except Exception as e:
            logging.error(f"Unexpected error: {e}")
        else:
            time.sleep(interval)


def load_data(hours_back=24):
    conn = sqlite3.connect(DB_PATH)
    query = """
        SELECT
            timestamp,
            ping_ms_avg,
            download_mbps,
            upload_mbps,
            packet_loss_percent
        FROM measurements
        WHERE timestamp >= datetime('now', '-{} hours')
        ORDER BY timestamp ASC
    """.format(hours_back)
    df = pd.read_sql_query(query, conn)
    conn.close()
    df["timestamp"] = pd.to_datetime(df["timestamp"])
    return df


def plot_all(hours_back: int = 24):
    df = load_data(hours_back)
    if df.empty:
        print("No data found in the last {} hours.".format(hours_back))
        return

    fig, axes = plt.subplots(4, 1, figsize=(12, 10), sharex=True)
    fig.suptitle(f"Internet Quality (Last {hours_back} Hours)", fontsize=16)

    # Ping
    axes[0].plot(
        df["timestamp"], df["ping_ms_avg"], "o-", color="tab:blue", label="Ping (ms)"
    )
    axes[0].set_ylabel("Ping (ms)")
    axes[0].grid(True)
    axes[0].legend()

    # Download
    axes[1].plot(
        df["timestamp"],
        df["download_mbps"],
        "o-",
        color="tab:green",
        label="Download (Mbps)",
    )
    axes[1].set_ylabel("Download (Mbps)")
    axes[1].grid(True)
    axes[1].legend()

    # Upload
    axes[2].plot(
        df["timestamp"],
        df["upload_mbps"],
        "o-",
        color="tab:orange",
        label="Upload (Mbps)",
    )
    axes[2].set_ylabel("Upload (Mbps)")
    axes[2].grid(True)
    axes[2].legend()

    # Packet Loss
    axes[3].plot(
        df["timestamp"],
        df["packet_loss_percent"],
        "o-",
        color="tab:red",
        label="Packet Loss (%)",
    )
    axes[3].set_ylabel("Packet Loss (%)")
    axes[3].set_xlabel("Time")
    axes[3].grid(True)
    axes[3].legend()

    # Format x-axis
    for ax in axes:
        ax.xaxis.set_major_formatter(mdates.DateFormatter("%H:%M"))
        ax.xaxis.set_major_locator(
            mdates.HourLocator(interval=2 if hours_back <= 24 else 6)
        )
        ax.tick_params(axis="x", rotation=45)

    plt.tight_layout()
    plt.subplots_adjust(top=0.93)
    plt.show()


def plot_summary():
    df = load_data(hours_back=168)  # 7 days
    if df.empty:
        print("No data.")
        return

    print("\n📊 Summary Statistics (last 7 days):")
    print(
        df[
            ["ping_ms_avg", "download_mbps", "upload_mbps", "packet_loss_percent"]
        ].describe()
    )

    # Optional: Plot daily averages
    df["date"] = df["timestamp"].dt.date
    daily = df.groupby("date").mean(numeric_only=True)

    fig, ax = plt.subplots(figsize=(10, 5))
    daily[["download_mbps", "upload_mbps"]].plot(ax=ax, marker="o")
    ax.set_title("Daily Avg Speed (7 Days)")
    ax.set_ylabel("Mbps")
    ax.grid(True)
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()


@app.command(name="plot")
def plot(hours: int = 24):
    """Plot results

    Arguments
    ---------
    hours: int
        How much time back to plot
    """
    plot_all(hours)
    plot_summary()


if __name__ == "__main__":
    setup()
    app()
