
import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

public class ComplementaryPairs 
{


    //Time complexity:O(n^2)
    //Space compleity:O(1)
    protected static int isKComplement(List<Integer> nums,int k)
    {
		int counter=0;
		for (int i = 0; i < nums.size() ; i++) {
	    	for (int j = 0; j < nums.size(); j++) {
        		if (nums.get(i) + nums.get(j) == k) {
					counter++;
				}
	    	}
		}
		return counter;
    } 


    //efficient way in time performance:
    //Time complexity: O(N)
    //Space complexity: O(N)
    public static int isKComplementPerform(List<Integer> nums, int k) {
    	Map<Integer, Integer> mapa = new HashMap<Integer, Integer>();
	    for (int i = 0; i < nums.size(); i++) {
        	mapa.merge(k - nums.get(i), 1, Integer::sum);
	    }
    	return nums.stream().map(element -> mapa.getOrDefault(element,0) ).mapToInt(Integer::intValue).sum();

    }

    public static void main(String args[])
    {
		Scanner stdin = new Scanner(System.in);
		while(stdin.hasNextLine())
    	{
        	String line = stdin.nextLine();
		
			int pos = line.indexOf('|');
			String listNums = line.substring(0,pos);
			String kComplements = line.substring(pos+1, line.length());

			List<String> _nuns = Arrays.asList(listNums.split(","));
			List<String> _kcomp = Arrays.asList(kComplements.split(","));

	 		List<Integer> nums = _nuns.stream().map( res -> {
				return new Integer(res);
				}).collect(Collectors.toList()) ;
		
			for(String kElement : _kcomp)
			{
				int rest=0;
				//rest= isKComplement(nums, Integer.parseInt(kElement) );
				//System.out.print( String.format("C-K: %s Total:%d\n",kElement,rest));
				rest=isKComplementPerform(nums, Integer.parseInt(kElement) );
				System.out.print( String.format("K: %s Total:%d\n",kElement,rest));
			}
			System.out.println("----");

    	}

    }


}
