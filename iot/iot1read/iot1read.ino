#include <WiFi.h>
#include <HTTPClient.h>

#define LED1 4  // GPIO for LED 1
#define LED2 5  // GPIO for LED 2

const char* ssid = "Galaxy M31sE1E0";
const char* password = "12345678";
const char* apiKey = "CRVSYEYVN1CLX3UM";
const char* server = "http://api.thingspeak.com";
const int channelID = 2824552;  // Replace with your ThingSpeak channel ID
const int fieldNumber = 1;             // Replace with the field number for temperature

void setup() {
  Serial.begin(115200);

  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);

  WiFi.begin(ssid, password);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  Serial.println("\nConnected to Wi-Fi");
}

void loop() {
  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient http;
    String url = String(server) + "/channels/" + String(channelID) + "/fields/" + String(fieldNumber) + "/last.json?api_key=" + apiKey;
    http.begin(url);

    int httpResponseCode = http.GET();
    if (httpResponseCode > 0) {
      String response = http.getString();
      Serial.println("Response: " + response);

      // Parse the temperature value from the JSON response
      float temperature = extractTemperature(response);
      Serial.println("Temperature: " + String(temperature));

      // Control LEDs based on temperature
      if (temperature > 30.0) {
        digitalWrite(LED1, HIGH);
        digitalWrite(LED2, LOW);
      } else if (temperature <= 30.0 && temperature >= 20.0) {
        digitalWrite(LED1, LOW);
        digitalWrite(LED2, HIGH);
      } else {
        digitalWrite(LED1, LOW);
        digitalWrite(LED2, LOW);
      }
    } else {
      Serial.println("Error in HTTP request: " + String(httpResponseCode));
    }
    http.end();
  } else {
    Serial.println("Wi-Fi disconnected, reconnecting...");
    WiFi.reconnect();
    delay(1000);
  }
  delay(5000);  // Wait before the next request
}

float extractTemperature(String json) {
  int index = json.indexOf("\"field" + String(fieldNumber) + "\":\"");
  if (index != -1) {
    int start = index + String("\"field" + String(fieldNumber) + "\":\"").length();
    int end = json.indexOf("\"", start);
    return json.substring(start, end).toFloat();
  }
  return -1;  // Return -1 if parsing fails
}
