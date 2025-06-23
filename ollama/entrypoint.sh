#!/bin/sh
/bin/ollama serve &

# Czekamy chwilę aż serwer się uruchomi
sleep 10

apt-get update && apt-get install -y ca-certificates && update-ca-certificates


# Pobieramy model
ollama pull SpeakLeash/bielik-4.5b-v3.0-instruct:Q8_0

for dir in /custom_models/*; do
  if [ -d "$dir" ] && [ -f "$dir/Modelfile" ]; then
    model_name=$(basename "$dir")
    echo "Tworzenie modelu: $model_name"
    ollama create "$model_name" -f "$dir/Modelfile"
  fi
done

# Zatrzymujemy się, by kontener żył
wait