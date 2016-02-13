import java.util.*;
public class User {
   private String id;
   private String firstName;
   private String lastName;
   private String name;
   private ArrayList<String> sports;
   private ArrayList<String> posts;
   private String provider;
   private ArrayList<User> userArray;
   
   public User(String name, ArrayList<String> sports, ArrayList<String> posts, String provider) {
      this.name = name;
      this.sports = sports;
      this.posts = posts;
      this.provider = provider;
   }
   public User() {
   
   }
}