# Robot project - ASE

Developed by Quentin Legrand & Bastien Sauvat

## 💻 Presentation

For this project we developed ASE_Robot, a language to define the behavior of a small robot.
This DSL include modeling domain and the associated tooling , an interpretor and a compiler. 

## 🔨 Architecture

Here is the model we created and relied on four our DSL.
<img src="model.png">

## 📝 Running

To use the DSL, you need to :
- clone this repository
```bash 
git clone https://github.com/bsauvat/ASE_Robot.git
```
- place yourself in the robot directory
```bash 
cd robot
```
- build the project
```bash 
npm run build:web
```
- run the server
```bash 
npm run serve
```
- open port 5173 : 
http://localhost:5173/
