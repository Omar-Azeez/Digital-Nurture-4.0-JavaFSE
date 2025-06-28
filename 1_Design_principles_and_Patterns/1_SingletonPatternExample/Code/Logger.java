public class Logger {
    // Private static instance of Logger
    private static Logger singleInstance;

    // Private constructor so it can't be instantiated outside
    private Logger() {
        System.out.println("Logger initialized.");
    }

    // Public static method to get the single instance
    public static Logger getInstance() {
        if (singleInstance == null) {
            singleInstance = new Logger();
        }
        return singleInstance;
    }
}
