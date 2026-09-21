#!/usr/bin/env python3

import os

import pandas as pd
from sklearn.cluster import HDBSCAN

INPUT_CSV = os.getenv("CLASSIFY_INPUT", "discovered_devices.csv")
OUTPUT_CSV = os.getenv("CLASSIFY_OUTPUT", "classified_devices.csv")


def extract_features(df):
    """Create numerical features used for clustering."""

    def vendor_category(vendor):
        value = str(vendor).lower()

        if "raspberry" in value:
            return 1
        if any(item in value for item in ["intel", "dell", "hp", "lenovo"]):
            return 2
        if "apple" in value:
            return 3
        if any(item in value for item in ["cisco", "netgear", "tp-link", "mikrotik"]):
            return 4

        return 0

    def hostname_category(hostname):
        value = str(hostname).lower()

        if "proxmox" in value or "pve" in value:
            return 1
        if "truenas" in value or "nas" in value:
            return 2
        if "opnsense" in value or "pfsense" in value or "router" in value:
            return 3
        if "dns" in value or "pihole" in value:
            return 4
        if "ubuntu" in value or "debian" in value:
            return 5

        return 0

    df["port_count"] = df["ports"].apply(
        lambda value: len(str(value).split(";"))
        if pd.notna(value) and str(value).strip()
        else 0
    )

    # This feature is retained from the original project for demonstration,
    # but future versions may replace address-derived features with stronger
    # device characteristics.
    df["ip_last"] = df["ip"].apply(
        lambda value: int(str(value).split(".")[-1])
        if pd.notna(value) and "." in str(value)
        else 0
    )

    df["vendor_cat"] = df["vendor"].apply(vendor_category)
    df["name_cat"] = df["hostname"].apply(hostname_category)

    return df


def main():
    df = pd.read_csv(INPUT_CSV)

    if len(df) < 2:
        print("Not enough devices for clustering. Copying input to output.")
        df.to_csv(OUTPUT_CSV, index=False)
        return

    df = extract_features(df)

    feature_columns = [
        "vendor_cat",
        "name_cat",
        "port_count",
        "ip_last",
    ]

    feature_matrix = df[feature_columns].fillna(0).values

    clusterer = HDBSCAN(
        min_cluster_size=2,
        metric="euclidean",
    )

    df["cluster"] = clusterer.fit_predict(feature_matrix)
    df.to_csv(OUTPUT_CSV, index=False)

    print(f"Classified {len(df)} devices; saved to {OUTPUT_CSV}")


if __name__ == "__main__":
    main()
