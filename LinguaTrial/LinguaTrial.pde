


class Word {
  String sing;
  String plur;
  int syllables;
  int[] metre;
  
  Word(String tempSing, String tempPlur, int tempSyl, int[] tempMet) {
    sing = tempSing;
    plur = tempPlur;
    syllables = tempSyl;
    metre = tempMet;
  }
}



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

int[] tetramPattern = {0,1,0,1,0,1,0,1};
int[] trimetPattern = {0,1,0,1,0,1};

String makePhrase(){
  float chooser = random(0,360);
  int word1 = floor(random(nouns.length));
  int word2 = floor(random(nouns.length));
  String result; 
  if (chooser < 120) {
    result = "a " + nouns[word1].sing + " for " 
              + nouns[word2].plur;
  } else if (chooser < 240) {
    result = "the " + nouns[word1].sing + " " + nouns[word2].sing;
  } else {
    if (chooser < 300) {
      result = nouns[word1].sing + " for " + nouns[word2].plur;
    } else {
      result = nouns[word1].plur + " for " + nouns[word2].plur;
    }
  }
  return result;
}

int[] addWord( int[] pattern, Word newWord, int patternLen){
  /*println("adding" + newWord.sing + "from " + patternLen + "to:");
  printArray(pattern);*/
  for(int i = 0; i < newWord.syllables; i++) {
    pattern[patternLen + i] = newWord.metre[i]; 
  }
  /*println("result:");
  printArray(pattern);*/
  return pattern;
}

Boolean followsMetre(int[] pattern, int[] testPattern, int size){
  for(int i = 0; i < size; i++){
    if (pattern[i] != testPattern[i]) {
      return false;
    }
  } 
  return true;
}

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

void setup() {
  //tetramPettern = {0,1,0,1,0,1,0,1};
  //trimetPattern = {0,1,0,1,0,1};
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
  
  
  nouns = new Word[6];
  nouns[0] = studio;
  nouns[1] = bee;
  nouns[2] = Lebanon;
  nouns[3] = diet;
  nouns[4] = bone;
  nouns[5] = timber;
  //nouns = {studio, bee, Lebanon, diet, bone, timber};
  allWords = new Word[11];
  allWords[0] = studio;
  allWords[1] = bee;
  allWords[2] = Lebanon;
  allWords[3] = diet;
  allWords[4] = bone;
  allWords[5] = timber;
  allWords[6] = of;
  allWords[7] = forWord;
  allWords[8] = along;
  allWords[9] = a;
  allWords[10] = redouble;
  //allWords = {studio, bee, Lebanon, diet, bone, timber, of, forWord, 
  //            along, a};
  
  println(makePhrase());
  println(makeTetram());
  println(makeTetram());
  println(makeTetram());
  println(makeTetram());
  println("");
  println(makeTetram());
  println(makeTetram());
  println(makeTetram());
  println(makeTetram());
  println("");
  println(makeTetram());
  println(makeTetram());
  println(makeTetram());
  println(makeTetram());
  println("");
  println(makeTetram());
  println(makeTetram());
  println(makeTetram());
  println(makeTetram());
   
}

void draw() {
  
}
