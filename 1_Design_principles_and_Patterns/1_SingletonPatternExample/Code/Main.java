public class Main {
    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        // Print their hash codes to verify they are the same object
        System.out.println("Logger 1 hashCode: " + logger1.hashCode());
        System.out.println("Logger 2 hashCode: " + logger2.hashCode());

        if (logger1 == logger2) {
            System.out.println("Test Passed: Both references point to the same Logger instance.");
        } else {
            System.out.println("Test Failed: Different instances exist.");
        }
    }
}
