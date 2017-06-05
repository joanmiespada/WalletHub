import java.io.*;
import java.util.*;
import java.util.concurrent.*;
import org.mapdb.*;

public class TopPhrases
{

    protected static void lineProcess(String line,ConcurrentMap<String,Integer> map)
    {
        List<String> listItem = Arrays.asList(line.split("|"));

        for(String elem: listItem)
        {
            map.merge(elem,1,Integer::sum );
        }

    }

    protected static void fileProcess(String path,ConcurrentMap<String,Integer> map) throws IOException, FileNotFoundException
    {
        FileInputStream inputStream = null;
        Scanner sc = null;
        try {
            inputStream = new FileInputStream(path);
            sc = new Scanner(inputStream, "UTF-8");
            while (sc.hasNextLine()) {
                String line = sc.nextLine();
                // System.out.println(line);
                lineProcess(line,map);
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

    public static ConcurrentMap<String,Integer>  openSuperHash(DB db)
    {
        db = DBMaker.fileDB("file.db").make();
        ConcurrentMap map = db.hashMap("map").createOrOpen();

        return map;
    }


    public static void main(String args[]) throws IOException
    {
            DB db;
            try {
                //System.out.println(args[0]);
                ConcurrentMap<String,Integer> map= openSuperHash(db);
                fileProcess(args[0],map);
            }
            finally{
                db.close();
            }



    }


}