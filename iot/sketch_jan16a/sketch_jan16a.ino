void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(13,INPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println(digitalRead(13));

}
