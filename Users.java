import java.util.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class Users {
  public static void main(String[] args) {
    Scanner console = new Scanner(System.in);
    Gson gson = new Gson();
    System.out.println("This is a program for managing all the users of SquadUp");
    System.out.println("Do you want to create a new user or get info about a user? Type create to create and get to get");
    String answer = console.next();
    if(answer.equalsIgnoreCase("create")) {
      createUser(console);
    } else {
    }
  }
  public static void createUser(Scanner console) {
    System.out.println("Type the user's first name");
    String firstName = console.next();
    System.out.println("Type the user's last name");
    String lastName = console.next();
    String name = firstName + " " + lastName;
    System.out.println("Type all the sports, type done when done adding sports");
    String ans = console.next();
    ArrayList<String> sportList = new ArrayList<String>();
    sportList.add(ans);
    while(!ans.equals("done")) {
      System.out.println("Add sport");
      ans = console.next();
      if(!ans.equals("done")) {
        sportList.add(ans);
      }
    }
    System.out.println("Male or Female?");
    String gender = console.next();
    System.out.println("Type in the post IDs, type done when done");
    String posts = console.next();
    ArrayList<String> postList = new ArrayList<String>();
    postList.add(posts);
    while(!posts.equals("done")) {
      System.out.println("Add post");
      posts = console.next();
      if(!posts.equals("done"))
      postList.add(posts);
    }
    System.out.println("Provider?");
    String provider = console.next();
    User user = new User(name, sportList, postList, provider);
    Random r = new Random();
    int randomId = r.nextInt(1000);
    Gson gson = new Gson();
    System.out.println("\"" + randomId + "\"" + " : " + gson.toJson(user) + ",");
  }
}
