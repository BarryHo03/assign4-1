PImage bg1, bg2, end1, end2, enemy, fighter, hp, start1, start2, treasure,shoot;
float background1X,background2X,e,blood,fighterX,fighterY,treasureX,treasureY,enemyT1,enemyT2,enemyT3;
float speedF=5;
PImage explodeFlames[]= new PImage[5];
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
final int GAME_START = 0;
final int GAME_RUN= 1;
final int GAME_OVER= 2;
final int nbrEnemy=5;
float []enemyX=new float[nbrEnemy];
float []enemyX2=new float[nbrEnemy];
float []enemyX3=new float[nbrEnemy];
float[]enemyY=new float [nbrEnemy];
float[]enemyY2=new float [nbrEnemy];
float[]enemyY3_1=new float [nbrEnemy];
float[]enemyY3_2=new float [nbrEnemy];
float []flameX=new float[5];
float []flameY=new float[5];
float []shootX=new float[5];
float []shootY=new float[5];
float []bulletS=new float[5];
float []bulletCompensateX=new float[5];
float []bulletCompensateY=new float[5];
boolean[]enemyDetect= new boolean[nbrEnemy];
boolean[]enemyDetect2=new boolean[nbrEnemy];
boolean[]enemyDetect3_1=new boolean[nbrEnemy];
boolean[]enemyDetect3_2=new boolean[nbrEnemy];
boolean[]explode=new boolean[5];
boolean[]fire=new boolean[5];
int spacingX=70;
int spacingY=60;
int gameState = GAME_START;
int currentFrame;
int bullet = 5;

void setup () {
  size(640, 480) ;
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  enemy=loadImage("img/enemy.png");
  fighter=loadImage("img/fighter.png");
  hp=loadImage("img/hp.png");
  treasure=loadImage("img/treasure.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  shoot=loadImage("img/shoot.png");
  e=random(0,height-enemy.height);
  treasureX=random(0,width-treasure.width);
  treasureY=random(0,height-treasure.height);
  background1X=640;
  background2X=0;
  blood=39;
  enemyT1=1980;
  enemyT2=990;
  enemyT3=0;
  currentFrame=0;
  fighterX=width-fighter.width;
  fighterY=height/2 - fighter.height/2;
  for(int i =0;i<explodeFlames.length;i++){
    explodeFlames[i]=loadImage("img/flame"+(i+1)+".png");
  }
  for(int i =0;i<nbrEnemy; i++){
    enemyDetect[i]=true;
    enemyDetect2[i]=true;
    enemyDetect3_1[i]=true;
    enemyDetect3_2[i]=true;
    explode[i]=false;
    fire[i]=false;
    bulletS[i]=0;
    bulletCompensateX[i]=0;
    bulletCompensateY[i]=0;
  } 
}

void draw() { 
  switch(gameState){
    case GAME_START:
      image(start2,0,0);
      if(mouseY >370 && mouseY<420 && mouseX>210 && mouseX<450){
        image(start1,0,0);
        if(mousePressed){
          gameState=GAME_RUN;
        }
      }
    break;
    case GAME_OVER:
    image(end2,0,0);
    if(mouseY >310 && mouseY<350 && mouseX>200 && mouseX<440){
        if(mousePressed){
          gameState=GAME_RUN;
          blood=39;
          e=random(0,height-enemy.height);
          fighterX=width-fighter.width;
          fighterY=height/2-fighter.height;
          enemyT1=1980;
          enemyT2=990;
          enemyT3=0;
          for(int i=0;i<nbrEnemy;i++){
            enemyDetect[i]=true;
            enemyDetect2[i]=true;
            enemyDetect3_1[i]=true;
            enemyDetect3_2[i]=true;
            explode[i]=false;
            fire[i]=false;
            bulletS[i]=0;
            bulletCompensateX[i]=0;
            bulletCompensateY[i]=0;
            bullet=5;
          }
        }else{
        image(end1,0,0);
        }
    }
    break;
    case GAME_RUN:
    //bg
    image(bg1,background1X-640,0);
    background1X++;
    background1X%=1280;
    
    image(bg2,background2X-640,0);
    background2X++;
    background2X%=1280;
    
    //hp 
    noStroke();
    fill(255,0,0);
    rect(10,0,blood,20);
    image(hp,0,0);
        
    //explosion
    int j = currentFrame ++;
    for(int i=0;i<5;i++){
      if(explode[i]){
        if(0<=j&&j<6){
          image(explodeFlames[0], flameX[i], flameY[i]);    
        }
        if(6<=j&&j<12){
          image(explodeFlames[1], flameX[i], flameY[i]);    
        }
        if(12<=j&&j<18){
          image(explodeFlames[2], flameX[i], flameY[i]);    
        }
        if(18<=j&&j<24){
          image(explodeFlames[3], flameX[i], flameY[i]);    
        }
        if(24<=j&&j<30){
          image(explodeFlames[4], flameX[i], flameY[i]);    
        }
        if(j>=30){
          explode[i]=false;
        }
      }    
    }
         
    //enemy & its movement
    //first enemy team
    for(int i=0;i<nbrEnemy;i++){
      if(enemyDetect[i]){
        enemyX[i]=enemyT1-2330+i*spacingX;
        enemyY[i]=e;
        image(enemy,enemyX[i],enemyY[i]);
      } 
      //collision
      if(fighterX<=enemyX[i]+enemy.width && fighterX>=enemyX[i]-fighter.width && fighterY>=enemyY[i]-fighter.height && fighterY<=enemyY[i]+enemy.height){
        enemyDetect[i]=false;
        currentFrame=0;
        explode[i]=true;
        flameX[i]=enemyX[i];
        flameY[i]=enemyY[i];
        enemyX[i]=-100;
        enemyY[i]=-100;
        blood-=39;    
      }            
    }
    enemyT1+=4;
    enemyT1%=2970;
    if(enemyT1==0||enemyT1==2){
      for(int i=0;i<nbrEnemy;i++){
        enemyDetect[i]=true;
      }
      e=random(240,425);
    }
    
    //second enemy team
    for(int i=0;i<nbrEnemy;i++){
      if(enemyDetect2[i]){
      enemyX2[i]=enemyT2-2330+i*spacingX;
      enemyY2[i]=e-i*spacingY;
      image(enemy,enemyX2[i],enemyY2[i]);
      }
      //collision
      if(fighterX<=enemyX2[i]+enemy.width && fighterX>=enemyX2[i]-fighter.width && fighterY>=enemyY2[i]-fighter.height && fighterY<=enemyY2[i]+enemy.height){
        enemyDetect2[i]=false;
        currentFrame=0;
        explode[i]=true;
        flameX[i]=enemyX2[i];
        flameY[i]=enemyY2[i];        
        blood-=39;
        enemyX2[i]=-100;
        enemyY2[i]=-100;
      }
    }
    enemyT2+=4;
    enemyT2%=2970;
    if(enemyT2==0||enemyT2==2){
      for(int i=0;i<nbrEnemy;i++){
        enemyDetect2[i]=true;
      }
    e=random(120,310);
    }
    
    //third enemy team
    for(int i=0;i<nbrEnemy;i++){
      if(enemyDetect3_1[i]){
      if(i==0||i==4){
        enemyX3[i]=-1000;
        enemyY3_1[i]=-1000;
      }
      if(0<i && i<=2){
        enemyX3[i]=enemyT3-2330+i*spacingX;
        enemyY3_1[i]=e-i*spacingY;
        image(enemy,enemyX3[i],enemyY3_1[i]);
      }
      if(2<i &&i<4){
        enemyX3[i]=enemyT3-2330+i*spacingX;
        enemyY3_1[i]=e-2*spacingY+(i-2)*spacingY;
        image(enemy,enemyX3[i],enemyY3_1[i]);
      }
      }
      if(enemyDetect3_2[i]){
      if(i<=2){
        enemyX3[i]=enemyT3-2330+i*spacingX;
        enemyY3_2[i]=e+i*spacingY;
      }else{
        enemyX3[i]=enemyT3-2330+i*spacingX;
        enemyY3_2[i]=e+2*spacingY-(i-2)*spacingY;
      }
      image(enemy,enemyX3[i],enemyY3_2[i]);
      }
      //collision
      if(fighterX<=enemyX3[i]+enemy.width && fighterX>=enemyX3[i]-fighter.width && fighterY>=enemyY3_1[i]-fighter.height && fighterY<=enemyY3_1[i]+enemy.height){
        enemyDetect3_1[i]=false;
        currentFrame=0;
        explode[i]=true;
        flameX[i]=enemyX3[i];
        flameY[i]=enemyY3_1[i];
        blood-=39;
        enemyX3[i]=-100;
        enemyY3_1[i]=-100;
      }
      if(fighterX<=enemyX3[i]+enemy.width && fighterX>=enemyX3[i]-fighter.width && fighterY>=enemyY3_2[i]-fighter.height && fighterY<=enemyY3_2[i]+enemy.height){
        enemyDetect3_2[i]=false;
        currentFrame=0;
        explode[i]=true;
        flameX[i]=enemyX3[i];
        flameY[i]=enemyY3_2[i];
        blood-=39;
        enemyX3[i]=-100;
        enemyY3_2[i]=-100;
      }
    }
    enemyT3+=4;
    enemyT3%=2970;
    if(enemyT3==0||enemyT3==2){
      for(int i=0;i<nbrEnemy;i++){
        enemyDetect3_1[i]=true;
        enemyDetect3_2[i]=true;  
      }
    e=random(0,425);
    }
    
    //fighter&shoot
    for(int i=0;i<5;i++){
      if(fire[i]){ 
        shootX[i]=bulletCompensateX[i]+bulletS[i]+fighterX;
        shootY[i]=bulletCompensateY[i]+fighterY+fighter.height/2-shoot.height/2;  
        image(shoot,shootX[i],shootY[i]);
      if(upPressed){
        if(fighterY>0){
        bulletCompensateY[i]+=5;
        }
      }
      if(downPressed){
        if(fighterY<height-fighter.height){
        bulletCompensateY[i]-=5;
        }
      }
      if(leftPressed){
        if(fighterX>0){
        bulletCompensateX[i]+=5;
        }
      }
      if(rightPressed){
        if(fighterX<width-fighter.width){
        bulletCompensateX[i]-=5;
        }
      }
      bulletS[i]-=8;
      if(shootX[i]<=0-shoot.width){
        bulletCompensateX[i]=0;
        bulletCompensateY[i]=0;
        bulletS[i]=0;
        shootX[i]=bulletCompensateX[i]+bulletS[i]+fighterX;
        shootY[i]=bulletCompensateY[i]+fighterY+fighter.height/2-shoot.height/2;  
        fire[i]=false;
        bullet++;
      }
      // bullet hit detection
      for(int k=0; k<5; k++){
        if(abs(shootX[i]-enemyX[k])<enemy.width&&shootY[i]>enemyY[k]-shoot.height && shootY[i]<enemyY[k]+enemy.height){
          fire[i]=!fire[i];
          shootX[i]=shootY[i]=1000;
          enemyDetect[k]=false;
          bulletCompensateX[i]=0;
          bulletCompensateY[i]=0;
          bulletS[i]=0;
          bullet++;
          currentFrame=0;
          explode[k]=true;
          flameX[k]=enemyX[k];
          flameY[k]=enemyY[k];
          enemyX[k]=-100;
          enemyY[k]=-100;
        }
        if(abs(shootX[i]-enemyX2[k])<=enemy.width&&shootY[i]>=enemyY2[k]-shoot.height && shootY[i]<=enemyY2[k]+enemy.height){
          fire[i]=false;
          bulletCompensateX[i]=0;
          bulletCompensateY[i]=0;
          bulletS[i]=0;
          enemyDetect2[k]=false;
          bullet++;
          currentFrame=0;
          explode[k]=true;
          flameX[k]=enemyX2[k];
          flameY[k]=enemyY2[k];
          enemyX2[k]=-100;
          enemyY2[k]=-100;
        }
        if(abs(shootX[i]-enemyX3[k])<=enemy.width&&shootY[i]>=enemyY3_1[k]-shoot.height && shootY[i]<=enemyY3_1[k]+enemy.height){
          fire[i]=false;
          bulletCompensateX[i]=0;
          bulletCompensateY[i]=0;
          bulletS[i]=0;
          enemyDetect3_1[k]=false;
          bullet++;
          currentFrame=0;
          explode[k]=true;
          flameX[k]=enemyX3[k];
          flameY[k]=enemyY3_1[k];
          enemyX3[k]=-100;
          enemyY3_1[k]=-100;
        }
        if(abs(shootX[i]-enemyX3[k])<=enemy.width&&shootY[i]>=enemyY3_2[k]-shoot.height && shootY[i]<=enemyY3_2[k]+enemy.height){
          fire[i]=false;
          bulletCompensateX[i]=0;
          bulletCompensateY[i]=0;
          bulletS[i]=0;
          enemyDetect3_2[k]=false;
          bullet++;
          currentFrame=0;
          explode[k]=true;
          flameX[k]=enemyX3[k];
          flameY[k]=enemyY3_2[k];
          enemyX3[k]=-100;
          enemyY3_2[k]=-100;
          }
        }
      }
    }
    image(fighter,fighterX,fighterY);
    
    //treasure
    image(treasure,treasureX,treasureY); 
    
    //refill hp
    if(fighterX<=treasureX+treasure.width && fighterX>=treasureX-fighter.width && fighterY>=treasureY-fighter.height && fighterY<=treasureY+treasure.height){
      blood+=19.5;
      treasureX=random(0,width-treasure.width);
      treasureY=random(0,height-treasure.height);
    }
    if(blood>195){
      blood=195;
    }
      
    //fighter control
    if(upPressed){
      fighterY-=speedF;
     }
    if(downPressed){
      fighterY+=speedF;
    }
    if(rightPressed){
      fighterX+=speedF;
    }
    if(leftPressed){
      fighterX-=speedF;
    }
    if(fighterX>width-fighter.width){
    fighterX=width-fighter.width;
    }
    if(fighterX<0){
    fighterX=0;
    }
    if(fighterY>height-fighter.height){
    fighterY=height-fighter.height;
    }
    if(fighterY<0){
    fighterY=0;
    } 
    if(blood<=0){
    gameState=GAME_OVER;
    for(int i=0;i<nbrEnemy;i++){
        enemyDetect[i]=false;
        enemyDetect2[i]=false;
        enemyDetect3_1[i]=false;
        enemyDetect3_2[i]=false;  
      }
    }
    break;   
  }  
}
void keyPressed(){
  if(key == ' ' ){
    bullet--;
    if(bullet<=0){
    bullet=0;
  }
  for(int i=0;i<5;i++){
    if(bullet<=i && bullet>=0){
      fire[i]=true;
    }
  }  
}   
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }      
  }
}
void keyReleased(){ 
  if (key == CODED) {    
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
