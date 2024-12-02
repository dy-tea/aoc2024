import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.List;
import java.util.Arrays;
import java.util.ArrayList;

public class Day2 {
  public static void p1() {
    try {
      File f = new File("input");
      Scanner in = new Scanner(f);

      int numLines = 0, sum = 0;

      while (in.hasNextLine()) {
        numLines++;

        String line = in.nextLine();
        String[] items = line.split(" ");

        int last = Integer.parseInt(items[0]);
        int curr = Integer.parseInt(items[1]);

        boolean increasing = last < curr;

        for (int i = 1; i < items.length; ++i) {
          last = Integer.parseInt(items[i - 1]);
          curr = Integer.parseInt(items[i]);

          int diff = increasing ? curr - last : last - curr;

          if (diff < 1 || diff > 3) {
            sum++;
            break;
          } 
        }  
      }
      System.out.println(numLines - sum + "/" + numLines);

      in.close();
    } catch (FileNotFoundException e) {
      System.out.println("No input file found");
    }
  }

  static boolean safe(ArrayList<Integer> levels) {
    int last = levels.get(0);
    boolean increasing = last < levels.get(levels.size() - 1);

    for (int i = 1; i != levels.size(); ++i) {
      int curr = levels.get(i);
      int diff = increasing ? curr - last : last - curr;
      if (diff > 3 || diff < 1) return false;
      last = curr;
    }

    return true;
  }

  static <T> ArrayList<T> cloneWithout(ArrayList<T> list, int without) {
    ArrayList<T> cloned = new ArrayList<>(list.size() - 1);

    for (int i = 0; i != list.size(); ++i)
      if (i != without)
        cloned.add(list.get(i));

    return cloned;
  }

  public static void p2() {
    try {
      File f = new File("input");
      Scanner in = new Scanner(f);

      int numLines = 0, sum = 0;

      while (in.hasNextLine()) {
        numLines++;

        String line = in.nextLine();
        String[] items = line.split(" ");

        ArrayList<Integer> nums = new ArrayList<>();

        for (String s : items)
          nums.add(Integer.parseInt(s));

        if (safe(nums)) {
          sum++;
          continue;
        }

        for (int i = 0; i != nums.size(); ++i) {
          if (safe(cloneWithout(nums, i))) {
            sum++;
            break;
          }
        }
      }
      System.out.println(sum  + "/" + numLines);

      in.close();
    } catch (FileNotFoundException e) {
      System.out.println("No input file found");
    }
  }

  public static void main(String []args) {
    p1(); 
    p2(); 
  }
}
