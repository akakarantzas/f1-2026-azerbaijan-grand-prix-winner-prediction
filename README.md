# F1 2026 Azerbaijan Grand Prix Winner Prediction

Standalone machine learning project for predicting the winner of the 2026 Azerbaijan Grand Prix at Baku City Circuit on September 26, 2026.

The driver roster reflects the confirmed Azerbaijan lineup announced on September 22: Isack Hadjar returns to Red Bull, Liam Lawson returns to Racing Bulls, and Yuki Tsunoda resumes reserve duties.

This repository owns the data loading, feature engineering, training, validation, model artifact, and prediction export. The production app consumes the exported JSON rather than training the model at request time.

## Approach

- Loads recent Formula 1 results and historical Azerbaijan Grand Prix results with FastF1.
- Builds rolling driver and team form features.
- Adds Azerbaijan experience, Azerbaijan win rate, and street circuit context.
- Trains a calibrated histogram gradient boosting classifier.
- Tunes the model and form probability blend with walk forward validation.
- Exports ranked win probabilities for the 2026 Azerbaijan Grand Prix.

## Run

```bash
pip install -r requirements.txt
python train_azerbaijan.py
```

Use `requirements.lock.txt` when you need the exact dependency set used by the Docker image.

FastF1 downloads race data into the local `cache/` directory.

## Run with Docker

Build and run the reproducible training environment with Docker Compose:

```bash
docker compose up --build
```

The container uses Python 3.12, persists FastF1 downloads in `cache/`, and writes the generated model, predictions, and metadata to `artifacts/`.

To rebuild the image and retrain from a clean container:

```bash
docker compose run --rm --build train
```

Run the feature and artifact regression tests in the same environment:

```bash
docker compose run --rm --build train python -m unittest discover -s tests -v
```

## Qualifying Grid

Before qualifying, the script uses its projected grid. After qualifying, copy `qualifying_grid.example.json` to `qualifying_grid.json`, update the positions, and rerun the script.

## Outputs

- `azerbaijan_predictions.json`
- `azerbaijan_model.pkl`
- `azerbaijan_metadata.json`

## Production Integration

`chicane-ai` can consume the exported prediction artifacts. Training code and FastF1 cache data remain in this repository.

## License

This project is available under the [MIT License](LICENSE).
