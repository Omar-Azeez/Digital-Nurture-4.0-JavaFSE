public class Main {
    public static void main(String[] args) {
        double presentValue = 1000.0; // Initial investment
        double annualGrowthRate = 0.08; // 8% growth
        int years = 5;

        double futureValue = ForecastCalculator.calculateFutureValue(presentValue, annualGrowthRate, years);
        System.out.printf("Future Value after %d years: %.2f\n", years, futureValue);
    }
}