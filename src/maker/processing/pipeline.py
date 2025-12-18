from pathlib import Path

import pandas as pd


class DataLoader:
    def load(self, file_path: str) -> pd.DataFrame:
        """Load CSV or JSON file."""
        path = Path(file_path)
        if path.suffix == ".csv":
            return pd.read_csv(path)
        elif path.suffix == ".json":
            return pd.read_json(path, lines=True)
        else:
            raise ValueError(f"Unsupported format: {path.suffix}")
