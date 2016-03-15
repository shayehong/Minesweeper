import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_MINES = 17;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
private boolean gameOver = false;
//bombs = new ArrayList<MSButtons>();
//List<String> myList = new ArrayList<String>();
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0 ;r < NUM_ROWS; r++)
        {
            for(int c = 0; c<NUM_COLS; c++)
            {
                buttons[r][c] = new MSButton(r,c);
            }
        }
    
    
    setBombs();
}
public void setBombs()
{
    //your code
    while(bombs.size() <= NUM_MINES){
        int row = (int)(Math.random()*20);
        int col = (int)(Math.random()*20);
        if(!bombs.contains(buttons[row][col]))
        {
            bombs.add(buttons[row][col]);
        }

    }
    
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
  for(int r = 0; r<NUM_ROWS;r++)
  {
    for(int c = 0; c< NUM_COLS; c++)
    {
        if(bombs.contains(buttons[r][c]) && !buttons[r][c].isMarked())
        {
            return false;
        }
    }
  }
  return true;
}
public void displayLosingMessage()
{
    //your code here
    if(isWon() == false)
    {
        buttons[10][5].setLabel("Y");
        buttons[10][6].setLabel("O");
        buttons[10][7].setLabel("U");
        buttons[10][8].setLabel(" ");
        buttons[10][9].setLabel("L");
        buttons[10][10].setLabel("O");
        buttons[10][11].setLabel("S");
        buttons[10][12].setLabel("T");
    }
}
public void displayWinningMessage()
{
    //your code here
    if(isWon() == true)
    {
        buttons[10][5].setLabel("Y");
        buttons[10][6].setLabel("O");
        buttons[10][7].setLabel("U");
        buttons[10][8].setLabel(" ");
        buttons[10][9].setLabel("W");
        buttons[10][10].setLabel("I");
        buttons[10][11].setLabel("N");
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        
        if(gameOver == true)
        {
            return;
        }
        
        clicked = true;
        if(keyPressed == true)
        {
           marked = !marked;
        }
        else if (bombs.contains(this))
        {
            displayLosingMessage();
            gameOver = true;

        } 
        else if(countBombs(r,c)>0)
        {
            setLabel(""+countBombs(r,c));
        }
        
        else 
        {
           if(isValid(r,c+1) == true && buttons[r][c+1].isClicked()==false)
           {
            buttons[r][c+1].mousePressed();
            }
            
            if(isValid(r,c-1) == true && buttons[r][c-1].isClicked()==false)
           {
            buttons[r][c-1].mousePressed();
            }

            if(isValid(r-1,c) == true && buttons[r-1][c].isClicked()==false)
           {
            buttons[r-1][c].mousePressed();
            }

            if(isValid(r+1,c) == true && buttons[r+1][c].isClicked()==false)
           {
            buttons[r+1][c].mousePressed();
            }

            if(isValid(r-1,c-1) == true && buttons[r-1][c-1].isClicked()==false)
           {
            buttons[r-1][c-1].mousePressed();
            }

            if(isValid(r+1,c+1) == true && buttons[r+1][c+1].isClicked()==false)
           {
            buttons[r+1][c+1].mousePressed();
            }

            if(isValid(r+1,c-1) == true && buttons[r+1][c-1].isClicked()==false)
           {
            buttons[r+1][c-1].mousePressed();
            }

            if(isValid(r-1,c+1) == true && buttons[r-1][c+1].isClicked()==false)
           {
            buttons[r-1][c+1].mousePressed();
            }
 
        }
    }

    public void draw () 
    {    
        stroke(255, 255, 255);
        if (marked)
            fill(1,48,52);
        else if( clicked && bombs.contains(this) ) 
             fill(255,255,255);
        else if(clicked)
            fill(13,77,77);
        else 
            fill(35,100,103);

        rect(x, y, width, height);
        fill(255);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r<NUM_ROWS && c<NUM_COLS && r>=0 && c>=0)
        {
            return true;
        }
        else
        {
            return false;
        }
        
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
        {
            numBombs++;
        }
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
        {
            numBombs++;
        }
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs++;
        }
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
        {
            numBombs++;
        }
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
        {
            numBombs++;
        }
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
        {
            numBombs++;
        }
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
        {
            numBombs++;
        }
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
        {
            numBombs++;
        }
        
        return numBombs;
    }
}

