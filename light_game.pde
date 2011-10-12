/* Light Game

 created 2011
 by Anthony Webb
 
 This example code is in the public domain.

 */

int currLed =  13;              // looping of the LED's which one is currently lit
int prevLed =  0;               
int countDown = 1;              // store whether we should be counting up or down
int ledState = LOW;             
int prevledState = HIGH;
int buttonState = 0;
int isWinner = -1;              // have they pressed the button looking for a winner
long previousMillis = 0;        // will store last time LED was updated
long interval = 1000;           // interval at which to blink (milliseconds)

void setup() {
  // these are the LED's used in the game
  pinMode(13, OUTPUT);    
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);  
  pinMode(10, OUTPUT);
  pinMode(9, OUTPUT);
  
  // the push button to try and lock a winner
  pinMode(7, INPUT);  

  // serial connection used to write stuff to the console  
  Serial.begin(9600);
  Serial.println("\nLets start this game:");
}

void loop()
{
  // here is where you'd put code that needs to be running all the time.

  // check to see if it's time to blink the LED; that is, if the 
  // difference between the current time and last time you blinked 
  // the LED is bigger than the interval at which you want to 
  // blink the LED.
  unsigned long currentMillis = millis();
  buttonState = digitalRead(7);
  
  if (buttonState == HIGH) { 
    if (isWinner == -1) {
      Serial.println("Button Press!");
      Serial.println(currLed);
      
      if (currLed == 11) {
        Serial.println("WINNER! LETS GO DOUBLETIME!");
        isWinner = 1;
        
        allLedOff();
        blinkThree(currLed);
        
        delay(1000); 
        interval = interval/2;
        isWinner = -1;
        
      } 
      else {
        Serial.println("LOSER! RESETTING THE GAME....");
        isWinner = 0;
        
        allLedOff();
        blinkThree(currLed);
        
        delay(1000); 
        interval = 1000;
        isWinner = -1;
        
      }
      
    }
  }
  
  // the loop is constantly running but we only want to enter here every X (interval) MS, and 
  // ONLY if the user has not pressed the button looking for a winner...
  if(currentMillis - previousMillis > interval && isWinner == -1) {
    // save the last time you blinked the LED 
    previousMillis = currentMillis;   
    
    // if you are at the top start going down
    if (currLed == 13)
      countDown = 1;
      
    // if you are at the bottom start counting up
    if (currLed == 9)
      countDown = 0;  
    
    // once we move the currLED var and turn it on, we need to know which one to shut down on the next pass...
    prevLed = currLed;
    
    // onto the next LED
    if (countDown == 1)
      currLed--;
    else
      currLed++;
    
    // set the LED on and turn off the previous one
    digitalWrite(currLed, HIGH);
    digitalWrite(prevLed, LOW);
  }
}

// custom function to turn off all the LED's
void allLedOff() {
  digitalWrite(13, LOW);
  digitalWrite(12, LOW);
  digitalWrite(11, LOW);
  digitalWrite(10, LOW);
  digitalWrite(9, LOW);
}

// custom function to blink a given LED X times
void blinkThree(int x) {
  int blinkLen = 200;
  
  digitalWrite(x, HIGH);   
  delay(blinkLen);           
  digitalWrite(x, LOW);   
  delay(blinkLen);
  digitalWrite(x, HIGH);   
  delay(blinkLen);           
  digitalWrite(x, LOW);   
  delay(blinkLen);
  digitalWrite(x, HIGH);   
  delay(blinkLen);           
  digitalWrite(x, LOW);   
  delay(blinkLen);
}
