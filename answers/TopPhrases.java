import java.io.*;
import java.util.*;
import org.mapdb.*;

public class TopPhrases
{
    protected static void lineProcess(String line)
    {
        List<String> listItem = Arrays.asList(line.split("|"));
    }

    protected static void fileProcess(String path) throws IOException, FileNotFoundException
    {
        FileInputStream inputStream = null;
        Scanner sc = null;
        try {
            inputStream = new FileInputStream(path);
            sc = new Scanner(inputStream, "UTF-8");
            while (sc.hasNextLine()) {
                String line = sc.nextLine();
                // System.out.println(line);
                lineProcess(line);
            }
            // note that Scanner suppresses exceptions
            if (sc.ioException() != null) {
                throw sc.ioException();
            }
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
            if (sc != null) {
                sc.close();
            }
        }
    }


    public static void main(String args[]) throws IOException
    {

            //System.out.println(args[0]);
            fileProcess(args[0]);



    }


}