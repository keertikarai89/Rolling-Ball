# Rolling-Ball
A simple iOS 2D game that uses the accelerometer to control the game play

Software Design:

•	There are two classes in this application ball.swift class and ViewController.swift class.
•	 Ball.swift class is handling the drawing of the ball and prizes/hazards. In this class we are hangling the velocity of the ball and prizes/hazards.
•	In ViewController class, we are calculating the user acceleration and defining gravity for ball and prizes/hazards and handling the score label based on game rules.
•	shouldAutorotate is set to false in ViewController class.

Game Rules:

There are below three rules for my game.

1.	If the ball hits a prize (green square box), user will get 1 point.
2.	If the score is >= 1 and ball hits a hazard (red square box), 1 point will be deducted from total score.
3.	If the score is 0 and user hits a hazard, game will end.
4.	Score will be amplified if user hits the ball with a force, this time 2 points will be added in the score.


Detail Description:

Below methods are used while designing this app to controle the movement of the ball and prizes/hazards which will enter the playfield.

•	start(): This function is defining the x and y positon of the ball and prizes/hazards which will appear on the screen.

•	stop(): This function is stopping the movement of the ball and prizes/hazards.

•	update(): Using this function, whenever a moving prize/hazard hits any of the four sides, will call updatePlayer() function and will bounce back.

•	updatePlayer(): Using this function, whenever the ball hits any of the four sides, it will bounce back.

•	collision(): This function will detect the collision between ball and prizes/hazards and update the score based on game rules.


To calculate velocity/user acceleration:

self.ball.velocity = CGFloat(( (data.userAcceleration.x * data.userAcceleration.x) + (data.userAcceleration.y * data.userAcceleration.y) ).squareRoot())


Movement of the Ball:

self.ball.velocity = 4 + 100 * self.ball.velocity

(Ball was moving very slowly, the movement for almost invisible, so have multiplied velocity by 100 and added a constant to increase the movement of the ball)


Gravity of the Ball:
                
self.ball.dx = CGFloat(data.gravity.x)
self.ball.dy = -CGFloat(data.gravity.y)

