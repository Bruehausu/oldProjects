//class containgng pertinent information abot a word
class Word {
  String sing;
  String plur;
  int syllables;
  int[] metre;
  
  Word(String tempSing, String tempPlur, 
       int tempSyl, int[] tempMet) {
    sing = tempSing;
    plur = tempPlur;
    syllables = tempSyl;
    metre = tempMet;
  }
}

// word tupole class - needed for a function return
class WordTuple {
  Word x;
  Word y;
  WordTuple(Word tempX, Word tempY) {
    x = tempX;
    y = tempY;
  }
}

// class that contains the phrases (built from Words) that appear
// on the display
class Phrase {
  String contents;
  int x;
  int y;
  Phrase(String tempConts, int tempX, int tempY){
    contents = tempConts;
    x = tempX;
    y = tempY;
  }
  //phrases rise after generation
  void update(){
    y = y-1;
  }
  void display(){
    fill(250,250,250);
    textAlign(CENTER);
    text(contents,x,y);
  }
  Boolean finished(){
    return y < -50;
  }
}

//word declaration - I have to hard-code the words right now,
//but processing automitically seems possible, if difficult
Word confessional;
Word studio;
Word Lebanon;
Word diet;
Word timber;
Word along;
Word bee;
Word bone;
Word of;
Word forWord;
Word a;
Word redouble;


Word[] nouns;
Word[] allWords;

//rythm patterns for iambic tetrameter and trimeter - 0 is a soft
//stress, 1 a hard stress. tetram is the only one currently in use
//since makeTrimet only follows the syllable restriuction
//Note: this is oversimplified - actually 4 levels of stress in
//english.
int[] tetramPattern = {0,1,0,1,0,1,0,1};
int[] trimetPattern = {0,1,0,1,0,1};

ArrayList<Phrase> phrases;

//makes a gramatically correct english phrase of one of a set of 
//structures and randomly selected nouns
String makePhrase(){
  float chooser = random(0,360);
  int word1 = floor(random(nouns.length));
  int word2 = floor(random(nouns.length));
  String result; 
  if (chooser < 120) {
    // a noun for noun
    result = "a " + nouns[word1].sing + " for " 
              + nouns[word2].plur;
  } else if (chooser < 240) {
    // the noun noun
    result = "the " + nouns[word1].sing + " " + nouns[word2].sing;
  } else {
    // noun for noun
    if (chooser < 300) {
      result = nouns[word1].sing + " for " + nouns[word2].plur;
    } else {
      result = nouns[word1].plur + " for " + nouns[word2].plur;
    }
  }
  return result;
}

//adds a word's metre to the main pattern
int[] addWord( int[] pattern, Word newWord, int patternLen){
  /*println("adding" + newWord.sing + 
            "from " + patternLen + "to:");
  printArray(pattern);*/
  for(int i = 0; i < newWord.syllables; i++) {
    pattern[patternLen + i] = newWord.metre[i]; 
  }
  /*println("result:");
  printArray(pattern);*/
  return pattern;
}

//test wether a metre pattern follows the main pattern up to 
//the given size
Boolean followsMetre(int[] pattern, int[] testPattern, int size){
  for(int i = 0; i < size; i++){
    if (pattern[i] != testPattern[i]) {
      return false;
    }
  } 
  return true;
}


//maked a nonsense iambic tetrameter
String makeTetram(){
  int[] testPattern = new int[tetramPattern.length];
  int[] resultPattern = new int[tetramPattern.length];
  int currentLen = 0;
  int tryI = 0;
  int counter = 0;
  String result = ""; 
  Word tryWord;
  
  while (currentLen < tetramPattern.length) {
    tryI = floor(random(allWords.length));
    tryWord = allWords[(tryI + counter) % allWords.length];
    if ((currentLen + tryWord.syllables) <= tetramPattern.length){
      testPattern = addWord(resultPattern, tryWord, currentLen);
      if (followsMetre(tetramPattern, testPattern,
          currentLen + tryWord.syllables)) {
        resultPattern = testPattern;
        currentLen += tryWord.syllables;
        result = result + tryWord.sing + " ";
        counter = 0;
      } else { 
        testPattern = resultPattern;
      }
    }
    counter += 1;
    if (counter >= allWords.length) {
      /*println(currentLen);
      printArray(resultPattern);*/
      return result + "pain "; //code failure
    }
  }
  return result;
}

//chooses 2 words with total syllable cound of sylSum
WordTuple getWords(int sylSum){
  Word word1 = allWords[floor(random(allWords.length))];
  int[] nul = {};
  Word word2 = new Word("","",0,nul);
  int goalSyl = sylSum - word1.syllables;
  if(goalSyl == 0){
    return new WordTuple(word1, word2);
  }
  int tryI = floor(random(allWords.length));
  
  for(int i=0; i < allWords.length; i++){
    word2 = allWords[(tryI + i) % allWords.length];
    if(word2.syllables == goalSyl){
      return new WordTuple(word1, word2);
    }
  }
  return new WordTuple(word1, word2);
}

// makes a disyllabic trimeter loosely based off of the 
// phrase patterns
String makeTrimet(){
  float chooser = random(0,360);
  WordTuple choices;
  String result; 
  if (chooser < 120) {
    choices = getWords(4);
    result = "a " + choices.x.sing + " for " 
              + choices.y.plur;
  } else if (chooser < 240) {
    choices = getWords(5);
    result = "the " + choices.x.sing + " " + choices.y.sing;
  } else {
    choices = getWords(5);
    if (chooser < 300) {
      result = choices.x.sing + " for " + choices.y.plur;
    } else {
      result = choices.x.plur + " for " + choices.y.plur;
    }
  }
  return result;
}

void setup() {
  //sets up words - hard coding
  int[] feed4 = {0,1,0,1};
  confessional = new Word("confessional", 
                          "confessionals", 4, feed4);
  
  int[] feed3 = {1,0,1};
  studio = new Word("studio", "studios", 3, feed3); 
  Lebanon = new Word("Lebanon", "Lebanon", 3, feed3);
  int[] feed3a = {0,1,0};
  redouble = new Word("redouble", "redoubles", 3, feed3a);
  
  int[] feed2 = {1,0};
  diet = new Word("diet", "diets", 2, feed2); 
  timber = new Word("timber", "timber", 2, feed2); 
  int[] feed2a = {0,1};
  along = new Word("along", "along", 2, feed2a); 

  int[] feed1 = {1};  
  bee = new Word("bee", "bees", 1, feed1); 
  bone = new Word("bone", "bones", 1, feed1); 
  int[] feed1a = {0};
  of = new Word("of", "ofs", 1, feed1a); 
  forWord = new Word("for", "fors", 1, feed1a); 
  a = new Word("a", "a", 1, feed1a); 
  
  nouns = new Word[7];
  nouns[0] = studio;
  nouns[1] = bee;
  nouns[2] = Lebanon;
  nouns[3] = diet;
  nouns[4] = bone;
  nouns[5] = timber;
  nouns[6] = confessional;
  //nouns = {studio, bee, Lebanon, diet, bone, timber};
  allWords = new Word[12];
  allWords[0] = bee;
  allWords[1] = redouble;
  allWords[2] = Lebanon;
  allWords[3] = of;
  allWords[4] = diet;
  allWords[5] = confessional;
  allWords[6] = bone;
  allWords[7] = forWord;
  allWords[8] = studio;
  allWords[9] = timber;
  allWords[10] = along;
  allWords[11] = a;

  phrases = new ArrayList<Phrase>();

  size(800,500);
  frameRate(24);
  
  /*println(makePhrase());
  println("");
  println(makeTetram());
  println("");
  println(makeTrimet());*/
}

void draw() {
  background(0);
  Phrase phrase;
  for (int i = phrases.size()-1; i >= 0; i--) {
    phrase = phrases.get(i);
    phrase.update();
    phrase.display();
    if (phrase.finished()) {
      phrases.remove(i);
    }
  }
}

//what kind of phrase is selected based off of the mouse position
//when clicked3
void mousePressed() {
  println("mouse press:" + mouseX + "in" + width);
  if(mouseX < (width/3)){
    phrases.add(new Phrase(makePhrase(),mouseX, mouseY));
    println("phrase added");
  } else if(mouseX < 2*(width/3)){
    phrases.add(new Phrase(makeTrimet(),mouseX, mouseY));
    println("trimet added");
  } else {
    phrases.add(new Phrase(makeTetram(),mouseX, mouseY));
    println("tetram added");
  }
}
