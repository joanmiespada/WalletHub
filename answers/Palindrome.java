
import java.io.*;
import java.util.Scanner;


public class Palindrome
{

   //Computational cost: O(n)
   //Space cost: O(n) due to it's a recursive version 
   protected static boolean isPalindrome(String s)
   {
       if(s.length()==0 ||
               s.length()==1)
           return true;
       else
       {
           if(s.charAt(0) == s.charAt( s.length()-1  ))
               return isPalindrome( s.substring(1, s.length()-1) );
       }
       return false;
   }



    public static void main(String args[])
    {
	Scanner stdin = new Scanner(System.in);
	while(stdin.hasNextLine())
    	{
        	String line = stdin.nextLine();
        	System.out.print(line +": ");
		boolean t= isPalindrome(line);
        	System.out.println(t);
    	}


    }


}
