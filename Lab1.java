// Solution 1. 

// public class Lab1 {

//     public static void main(String[] args) {
//         for (int i = 5; i == 5; i++) {
//             System.out.println(i);
//             for (int j = 4; j == 4; j++) {
//                 System.out.println(i + " " + j);
//                 for (int k = 3; k == 3; k++) {
//                     System.out.println(i + " " + j + " " + k);
//                     for (int m = 2; m == 2; m++) {
//                         System.out.println(i + " " + j + " " + k + " " + m);
//                         for (int n = 1; n == 1; n++) {
//                             System.out.println(i + " " + j + " " + k + " " + m + " " + n);

//                         }
//                     }
//                 }
//             }
//         }
//     }
// }
import java.util.Scanner;
import java.util.Random;

public class Lab1 {
    public static void main(String[] args) {
        for (int i = 1; i <= 5; i++) {
            for (int j = 5; j > 5 - i; j--) {
                System.out.print(j + " ");
            }
            System.out.println();
        }
        Scanner input = new Scanner(System.in);

        // allow user input;
        System.out.println("How many numbers do you want to enter?");
        int num = input.nextInt();

        int array[] = new int[num];

        System.out.println("Enter the " + num + " numbers now.");

        for (int i = 0; i < array.length; i++) {
            array[i] = input.nextInt();
        }
        // Boolean result = isSorted(array);
        System.out.println(isSorted(array));
        rollingDice(1000);
    }

     public static boolean isSorted(int[] array) {

        for (int i = 0; i < array.length - 1; i++) {
            if (array[i] > array[i + 1]) {
                return false;
            }
        }
        return true;

    }

    static void rollingDice(int n) {
        Random rnd = new Random();
        int freq[] = new int[6];


        for (int roll = 1; roll <= n; roll++) {
            freq[rnd.nextInt(6)]++;
            switch 
            
        }

        System.out.println("Face \t Frequency");

        for (int face = 0; face < freq.length; face++) {
            System.out.println(face + 1 + "\t" + freq[face]);
        }
    }
}

// Solution 2.
// import java.util.Scanner;

// public class Lab1 {

// public static void main(String[] args) {
// Scanner input = new Scanner(System.in);

// // allow user input;
// System.out.println("How many numbers do you want to enter?");
// int num = input.nextInt();

// int array[] = new int[num];

// System.out.println("Enter the " + num + " numbers now.");

// for (int i = 0; i < array.length; i++) {
// array[i] = input.nextInt();
// }
// for (int i = 0; i < array.length-1; i++) {
// if (array[i] > array[i + 1]) {
// System.out.println("False");
// return;
// }
// }
// System.out.println("True");

// }
// }

// import java.util.Random;
// public class Lab1 {
// public static void main(String[] args) {
// rollingDice(1000);
// }

// public static void rollingDice(int n){
// Random rnd = new Random();
// int freq[] = new int[7];

// for (int roll = 1; roll<=n; roll++) {
// ++freq[1+rnd.nextInt(6)];
// }

// System.out.println("Face \t Frequency");

// for(int face =1 ; face<freq.length; face++)
// {
// System.out.println(face + "\t" + freq[face]);
// }
// }

// }

// import java.util.Random;

// public class Lab1 {
// public static void main(String[] args) {
// rollingDice(1000);
// }

// public static void rollingDice(int n) {
// Random rnd = new Random();
// int freq[] = new int[6];

// for (int roll = 1; roll <= n; roll++) {
// freq[ rnd.nextInt(6)]++;
// }

// System.out.println("Face \t Frequency");

// for (int face = 0; face < freq.length; face++) {
// System.out.println(face+1 + "\t" + freq[face]);
// }
// }

// }