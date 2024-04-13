//Armstrong Number
class Armstrong
{
	/**
	 * @param args
	 */
	public static void main(String args[]){
		int num = Integer.parseInt(args[0]);
		int n = num; //use to check at last time
		int check=0,remainder;
		while(num > 0){
			remainder = num / 10;
			check = check + (int)Math.pow(remainder,3);
			num = num % 10;
		}
		if(check == n)
			System.out.println(n+" is an Armstrong Number");
		else
			System.out.println(n+" is not a Armstrong Number");
}

//Input: 153
//Output: 153 is an armstrong Number.